# Make direct calls to the AEMET API.

#' Query the AEMET API
#'
#' Retrieves data and metadata from AEMET and converts JSON responses to a
#' [tibble][dplyr::tibble] when possible.
#'
#' @param apidest A character string containing the destination URL. See
#'   <https://opendata.aemet.es/dist/index.html>.
#'
#' @param verbose A logical value. If `TRUE`, displays information about the
#'   exchange between the client and server.
#'
#' @returns
#' A [tibble][dplyr::tibble] (if possible) or the results of the query as
#' provided by [httr2::resp_body_raw()] or [httr2::resp_body_string()].
#'
#' @source <https://opendata.aemet.es/dist/index.html>.
#'
#' @seealso See examples of how to use these functions in
#' `vignette("extending-climaemet", package = "climaemet")`.
#'
#' @concept aemet_low
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' # Run only when AEMET_API_KEY is detected.
#'
#' url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"
#'
#' get_data_aemet(url)
#'
#' # Metadata.
#'
#' get_metadata_aemet(url)
#'
#' # Get data from any API endpoint.
#'
#' # Plain text.
#'
#' plain <- get_data_aemet("/api/prediccion/nacional/hoy")
#'
#' cat(plain)
#'
#' # An image.
#'
#' image <- get_data_aemet("/api/mapasygraficos/analisis")
#'
#' # Write and read.
#' tmp <- tempfile(fileext = ".gif")
#'
#' writeBin(image, tmp)
#'
#' gganimate::gif_file(tmp)
get_data_aemet <- function(apidest, verbose = FALSE) {
  # Manage the API key.
  apikey_detected <- aemet_detect_api_key()
  if (isFALSE(apikey_detected)) {
    cli::cli_abort(
      "An API key is required. See {.fn climaemet::aemet_api_key}."
    )
  }
  aemet_hlp_validate_logical(verbose, "verbose")

  getapikeys <- cache_apikeys()
  initapikey <- getapikeys$initapikey
  apikey <- getapikeys$apikey

  if (verbose && length(initapikey) > 1) {
    maskapi <- substr(apikey, nchar(apikey) - 10, nchar(apikey) + 1) # nolint
    cli::cli_par()
    cli::cli_h1("{.pkg climaemet}: API call")
    cli::cli_par()
    cli::cli_alert_info(paste0(
      "Using API key ",
      "{.val {paste0('XXXX...', maskapi, collapse = '')}}."
    ))
  }

  # 1. Initial request ----
  response_initial <- aemet_api_call(apidest, verbose, apikey = apikey)

  if (is.null(response_initial)) {
    return(NULL)
  }

  # Extract data to prepare the second request.
  results <- try_parse_resp(response_initial)

  if (is.null(results$datos)) {
    cli::cli_alert_warning(
      "Could not parse JSON. Returning {.val NULL}. Check the response."
    )
    return(NULL)
  }

  # 2. Get data from first call ----
  if (verbose) {
    cli::cli_h2("Requesting data")
  }

  # Prepare the second request.
  newapientry <- results$datos
  response_data <- aemet_api_call(
    newapientry,
    verbose,
    data_call = TRUE,
    apikey = apikey
  )

  if (!inherits(response_data, "httr2_response")) {
    return(NULL)
  }

  # Check that the data response has content.
  if (!httr2::resp_has_body(response_data)) {
    cli::cli_alert_warning(
      "API request did not return a body. Skipping {.url {apidest}}."
    )
    return(NULL)
  }

  # Guess the output because AEMET does not always provide correct MIME types.
  # Some JSON payloads are returned as "text/plain".

  mime_data <- extract_content_type(response_data)

  if (!grepl("json|plain|unknown", mime_data)) {
    cli::cli_alert_info("Response MIME type: {.val {mime_data}}.")
    cli::cli_alert("Returning {.cls raw} bytes. See also {.fn base::writeBin}.")

    raw <- httr2::resp_body_raw(response_data)
    return(raw)
  }

  if (grepl("unknown", mime_data, fixed = TRUE)) {
    results_data <- encode_text(rawToChar(httr2::resp_body_raw(response_data)))

    # Try to convert the response to a tibble.
    data_tibble_end <- try(
      dplyr::as_tibble(jsonlite::fromJSON(results_data)),
      silent = TRUE
    )

    if (inherits(data_tibble_end, "try-error")) {
      cli::cli_alert_info("Response MIME type: {.val {mime_data}}.")
      cli::cli_alert(
        "Returning {.cls raw} bytes. See also {.fn base::writeBin}."
      )

      raw <- httr2::resp_body_raw(response_data)
      return(raw)
    }
  } else {
    results_data <- httr2::resp_body_string(response_data)
    # Try to convert the response to a tibble.
    data_tibble_end <- try(
      dplyr::as_tibble(jsonlite::fromJSON(results_data)),
      silent = TRUE
    )

    if (inherits(data_tibble_end, "try-error")) {
      cli::cli_alert_info("Response MIME type: {.val {mime_data}}.")
      cli::cli_alert("Returning a UTF-8 {.cls character} string.")
      str <- httr2::resp_body_string(response_data)
      return(str)
    }
  }

  data_tibble_end
}

#' @rdname get_data_aemet
#' @name get_data_aemet
#' @export
#' @encoding UTF-8
get_metadata_aemet <- function(apidest, verbose = FALSE) {
  # Manage the API key.
  apikey_detected <- aemet_detect_api_key()
  if (isFALSE(apikey_detected)) {
    cli::cli_abort(
      "An API key is required. See {.fn climaemet::aemet_api_key}."
    )
  }
  aemet_hlp_validate_logical(verbose, "verbose")

  getapikeys <- cache_apikeys()
  initapikey <- getapikeys$initapikey
  apikey <- getapikeys$apikey

  if (verbose && length(initapikey) > 1) {
    cli::cli_par()
    cli::cli_h1("{.pkg climaemet}: API call")
    cli::cli_par()

    maskapi <- substr(apikey, nchar(apikey) - 10, nchar(apikey) + 1) # nolint
    cli::cli_alert_info(paste0(
      "Using API key ",
      "{.val {paste0('XXXX...', maskapi, collapse = '')}}."
    ))
  }

  # 1. Initial request ----
  response_initial <- aemet_api_call(apidest, verbose, apikey = apikey)

  if (is.null(response_initial)) {
    return(NULL)
  }

  # Extract data to prepare the second request.
  results <- try_parse_resp(response_initial)

  if (is.null(results$metadatos)) {
    cli::cli_alert_warning(
      "Could not parse JSON. Returning {.val NULL}. Check the response."
    )
    return(NULL)
  }

  # 2. Get data from first call ----
  if (verbose) {
    cli::cli_h2("Requesting metadata")
  }

  # Prepare the second request.
  newapientry <- results$metadatos
  response_data <- aemet_api_call(
    newapientry,
    verbose,
    data_call = TRUE,
    apikey = apikey
  )

  if (!inherits(response_data, "httr2_response")) {
    return(NULL)
  }

  # Check that the metadata response has content.
  if (!httr2::resp_has_body(response_data)) {
    cli::cli_alert_warning(
      "API request did not return a body. Skipping {.url {apidest}}."
    )
    return(NULL)
  }

  # Guess the output because AEMET does not always provide correct MIME types.
  # Some JSON payloads are returned as "text/plain".

  mime_data <- extract_content_type(response_data)

  # Handle unexpected MIME types.

  if (!grepl("json|plain|unknow", mime_data)) {
    cli::cli_alert_info("Response MIME type: {.val {mime_data}}.")
    cli::cli_alert("Returning {.cls raw} bytes. See also {.fn base::writeBin}.")
    raw <- httr2::resp_body_raw(response_data)
    return(raw)
  }

  try_list <- try_parse_resp(response_data)

  if (is.list(try_list)) {
    try_list <- try_list[lapply(try_list, length) > 0]
  }

  # Try to convert the response to a tibble.
  data_tibble_end <- try(dplyr::as_tibble(try_list), silent = TRUE)

  if (all(inherits(data_tibble_end, "tbl_df"), nrow(data_tibble_end) > 0)) {
    return(data_tibble_end)
  }

  # Fall back to a UTF-8 string if tibble conversion fails.

  cli::cli_alert_info("Response MIME type: {.val {mime_data}}.")
  cli::cli_alert("Returning a UTF-8 {.cls character} string.")
  str <- httr2::resp_body_string(response_data)

  str
}

#' Perform an initial API request
#'
#' @description
#' Handles a low-level request to the AEMET API.
#'
#' @param apikey An AEMET API key.
#' @inheritParams get_data_aemet apidest verbose
#'
#' @returns The result of [httr2::req_perform()] on success or `NULL` after a
#'   warning.
#' Fatal HTTP responses produce an error from [httr2::resp_check_status()].
#'
#' @noRd
aemet_api_call <- function(
  apidest,
  verbose = FALSE,
  data_call = FALSE,
  apikey = NULL
) {
  if (is.null(apikey)) {
    cli::cli_abort("{.arg apikey} cannot be {.val NULL}.")
  }

  realm <- substr(apikey, nchar(apikey) - 10, nchar(apikey) + 1) # nolint

  # Prepare the initial request.
  if (data_call) {
    req1 <- httr2::request(apidest)
  } else {
    req1 <- httr2::request("https://opendata.aemet.es/opendata")
    req1 <- httr2::req_url_path_append(req1, apidest)
  }
  req1 <- httr2::req_headers(req1, api_key = apikey)
  req1 <- httr2::req_error(req1, is_error = function(x) {
    FALSE
  })

  # Increase the timeout.
  req1 <- aemet_hlp_req_timeout(req1)
  req1 <- httr2::req_throttle(
    req1,
    capacity = 40,
    fill_time_s = 60,
    realm = realm
  )

  # Perform the request.
  if (verbose) {
    cli::cli_alert_info("Requesting {.url {req1$url}}.")
  }

  response <- httr2::req_perform(req1)
  # Add an extra delay based on the remaining request count.
  msg_count <- httr2::resp_header(response, "Remaining-request-count")

  # Update the local quota database with the remaining request count.
  db <- get_db_apikeys()
  msg_count <- as.numeric(msg_count)
  if (!identical(msg_count, numeric(0))) {
    db[db$apikey == apikey, "remain"] <- msg_count
    saveRDS(db, file.path(tempdir(), "dbapikey.rds"))
  }
  delay_aemet_api(msg_count)

  # Parse API messages.

  parsed_resp <- extract_resp_code(response)
  msg <- NULL

  if ("estado" %in% names(parsed_resp)) {
    parsed_code <- parsed_resp$estado
  } else {
    parsed_code <- parsed_resp
  }

  if ("descripcion" %in% names(parsed_resp)) {
    msg <- parsed_resp$descripcion
  }

  # Return early for 404 responses.
  if (parsed_code == 404) {
    if (is.null(msg)) {
      msg <- "Not found."
    }

    cli::cli_alert_danger("HTTP {.code {parsed_code}}:")
    cli::cli_bullets(c(" " = "{.emph {msg}}"))
    return(NULL)
  }

  if (parsed_code == 401) {
    if (is.null(msg)) {
      msg <- "The API key is not valid. Try a new one."
    }
    cli::cli_alert_danger("{.emph {msg}}")
    httr2::resp_check_status(response)
  }

  # Retry transient API errors.
  if (parsed_code %in% c(429, 500, 503)) {
    if (is.null(msg)) {
      msg <- "API rate limit reached."
    }
    cli::cli_alert_warning("HTTP {.code {parsed_code}}:")
    cli::cli_bullets(c(" " = "{.emph {msg}}"))
    cli::cli_par()
    cli::cli_alert_info("Retrying.")
    req1 <- httr2::req_retry(
      req1,
      max_seconds = 60,
      is_transient = function(x) {
        httr2::resp_status(x) %in% c(429, 500, 503) # nocov
      }
    )

    response <- httr2::req_perform(req1)
  }

  # Reparse the final response before returning it.
  parsed_resp <- extract_resp_code(response)
  msg <- NULL

  if ("estado" %in% names(parsed_resp)) {
    parsed_code <- parsed_resp$estado
  } else {
    parsed_code <- parsed_resp
  }

  if ("descripcion" %in% names(parsed_resp)) {
    msg <- parsed_resp$descripcion
  }

  if (parsed_code == 401) {
    if (is.null(msg)) {
      msg <- "The API key is not valid. Try a new one."
    }
    cli::cli_alert_danger("{.emph {msg}}")
    httr2::resp_check_status(response)
  }

  if (parsed_code != 200) {
    if (is.null(msg)) {
      msg <- httr2::resp_header(response, "aemet_mensaje")
    }
    if (is.null(msg)) {
      msg <- "API request failed."
    }
    cli::cli_alert_danger("HTTP {.code {parsed_code}}:")
    cli::cli_bullets(c(" " = "{.emph {msg}}"))
    return(NULL)
  }

  msg_count <- httr2::resp_header(response, "Remaining-request-count")
  if (verbose) {
    if (is.null(msg)) {
      msg <- httr2::resp_header(response, "aemet_mensaje")
    }
    if (is.null(msg)) {
      msg <- "OK"
    }
    cli::cli_alert_success("HTTP {.code {parsed_code}}: {.emph {msg}}")
    cli::cli_par()
    if (!is.null(msg_count)) {
      cli::cli_alert_info("Remaining request count: {.val {msg_count}}.")
    }
  }

  response
}

# Cache API keys.
cache_apikeys <- function(path = "dbapikey.rds") {
  dbapikey <- file.path(tempdir(), path)

  if (!file.exists(dbapikey)) {
    initapikey <- aemet_hlp_get_allkeys()
    initapikey <- c("a", NULL, NA, initapikey)
    # Drop invalid API keys.
    initapikey <- initapikey[!is.na(initapikey)]
    initapikey <- initapikey[nchar(initapikey) > 10]
    initapikey <- unique(initapikey)

    if (length(initapikey) < 1) {
      cli::cli_abort(
        "Cannot find a valid API key. See {.fn climaemet::aemet_api_key}."
      )
    }

    db <- dplyr::tibble(apikey = initapikey)
    db$remain <- 150
    saveRDS(db, dbapikey)
  } else {
    db <- get_db_apikeys()
  }

  # Select the API key with the highest quota.
  dbsort <- db[order(db$remain, decreasing = TRUE), ]
  apikey <- as.character(dbsort$apikey[[1]])
  initapikey <- as.character(dbsort$apikey)
  res <- list(apikey = apikey, initapikey = initapikey)

  res
}

get_db_apikeys <- function(path = "dbapikey.rds") {
  readRDS(file.path(tempdir(), path))
}
