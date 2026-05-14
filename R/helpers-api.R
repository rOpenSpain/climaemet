# Add a delay based on the response header.
delay_aemet_api <- function(counts) {
  # Check remaining requests and delay to avoid API throttling.
  remain <- as.integer(counts)
  if (any(is.null(remain), is.na(remain), length(remain) == 0)) {
    return(NULL)
  }

  if (remain %in% seq(105, 120)) {
    Sys.sleep(1)
  }
  if (remain %in% seq(120, 130)) {
    Sys.sleep(0.25)
  }
  NULL
}

#' Helper function for parsing responses with misleading MIME types
#'
#' Sometimes the result has MIME type `"text/plain"` even though it is a JSON
#' object.
#' @noRd
try_parse_resp <- function(resp) {
  if (!grepl("json|plain", httr2::resp_content_type(resp))) {
    return(resp)
  }

  # Try to parse as JSON.
  resp_parsed <- try(
    httr2::resp_body_json(resp, check_type = FALSE),
    silent = TRUE
  )

  if (!inherits(resp_parsed, "try-error")) {
    return(resp_parsed)
  }

  # Try another parsing strategy.
  resp_parsed <- try(
    jsonlite::fromJSON(httr2::resp_body_string(resp)),
    silent = TRUE
  )

  if (!inherits(resp_parsed, "try-error")) {
    return(resp_parsed)
  }

  # Last parsing attempt.

  # nocov start
  txt <- try(rawToChar(httr2::resp_body_raw(resp)), silent = TRUE)
  if (inherits(txt, "try-error")) {
    return(resp)
  }
  Encoding(txt) <- "latin1" # Ensure text is parsed with the expected encoding.
  resp_parsed <- try(jsonlite::fromJSON(txt), silent = TRUE)
  if (inherits(resp_parsed, "try-error")) {
    return(resp)
  }
  # nocov end

  resp_parsed
}

#' Minimal utility to extract the response code
#'
#' Sometimes this is in the response body.
#'
#' @noRd
extract_resp_code <- function(resp) {
  # Look for messages in the header first.
  init <- list()
  init$estado <- httr2::resp_header(resp, "aemet_estado")
  init$descripcion <- httr2::resp_header(resp, "aemet_mensaje")

  if ("estado" %in% names(init)) {
    init$estado <- as.numeric(gsub("[^0-9]", "", init$estado))
    return(init)
  }

  # Otherwise, try the response body.
  try_parse_res <- try_parse_resp(resp)
  if (!inherits(try_parse_res, "list")) {
    return(httr2::resp_status(resp))
  }

  if ("estado" %in% names(try_parse_res)) {
    return(try_parse_res)
  }

  # If everything fails, use the response status.
  httr2::resp_status(resp)
}
