# Add some delay based on the response of the header
delay_aemet_api <- function(counts) {
  # See remaining requests and add delay (avoid throttling of the API)
  remain <- as.integer(counts)
  if (any(is.na(remain), is.null(remain), length(remain) == 0)) {
    return(NULL)
  }

  if (remain < 105) {
    # Changed, let httr2::req_retry() handles the full retry instead of delay
    return(NULL)
  }
  if (remain %in% seq(105, 120)) {
    Sys.sleep(1)
  }
  if (remain %in% seq(120, 130)) {
    Sys.sleep(0.25)
  }
  return(NULL)
}

#' Helper function. For some reason the API gives misleading mime types
#'
#' Sometimes the results has mime 'text/plain' even though is a json object
#' @noRd
try_parse_resp <- function(resp) {
  if (!grepl("json|plain", httr2::resp_content_type(resp))) {
    return(resp)
  }

  # If not try to parse
  resp_parsed <- try(
    httr2::resp_body_json(resp, check_type = FALSE),
    silent = TRUE
  )

  if (!inherits(resp_parsed, "try-error")) {
    return(resp_parsed)
  }

  # Try another strategy
  resp_parsed <- try(
    jsonlite::fromJSON(httr2::resp_body_string(resp)),
    silent = TRUE
  )

  if (!inherits(resp_parsed, "try-error")) {
    return(resp_parsed)
  }

  # Last try

  txt <- try(rawToChar(httr2::resp_body_raw(resp)), silent = TRUE)
  if (inherits(txt, "try-error")) {
    return(resp)
  }
  Encoding(txt) <- "latin1" # (just to make sure)
  resp_parsed <- try(jsonlite::fromJSON(txt), silent = TRUE)
  if (inherits(resp_parsed, "try-error")) {
    return(resp)
  }

  resp_parsed
}

#' Minimal utility for extract response code
#'
#' Sometimes this is in the body of the request.
#'
#' @noRd
extract_resp_code <- function(resp) {
  # Look for messages first in header
  init <- list()
  init$estado <- httr2::resp_header(resp, "aemet_estado")
  init$descripcion <- httr2::resp_header(resp, "aemet_mensaje")

  if ("estado" %in% names(init)) {
    init$estado <- as.numeric(gsub("[^0-9]", "", init$estado))
    return(init)
  }

  # If not, try from  the body
  try_parse_res <- try_parse_resp(resp)
  if (!inherits(try_parse_res, "list")) {
    return(httr2::resp_status(resp))
  }

  if ("estado" %in% names(try_parse_res)) {
    return(try_parse_res)
  }

  # If everything fails, from the response
  httr2::resp_status(resp)
}
