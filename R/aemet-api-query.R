# API functions: these functions make direct calls to the AEMET API.

#' Client tool for the AEMET API
#'
#' Client tool to get data and metadata from AEMET and convert JSON to a
#' [tibble][tibble::tbl_df].
#'
#' @family aemet_api
#'
#' @source
#' <https://opendata.aemet.es/dist/index.html>.
#'
#' @param apidest Character string as destination URL. See
#'   <https://opendata.aemet.es/dist/index.html>.
#'
#' @param verbose Logical `TRUE/FALSE`. Provides information about the flow of
#' information between the client and server.
#'
#' @return
#' A [tibble][tibble::tbl_df] (if possible) or the results of the query as
#' provided by [httr2::resp_body_raw()] or [httr2::resp_body_string()].
#'
#' @seealso
#' See examples of how to use these functions in
#' `vignette("extending-climaemet")`.
#'
#' @examplesIf aemet_detect_api_key()
#' # Run this example only if AEMET_API_KEY is detected.
#'
#' url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"
#'
#' get_data_aemet(url)
#'
#' # Metadata
#'
#' get_metadata_aemet(url)
#'
#' # Get data from any API endpoint.
#'
#' # Plain text
#'
#' plain <- get_data_aemet("/api/prediccion/nacional/hoy")
#'
#' cat(plain)
#'
#' # An image
#'
#' image <- get_data_aemet("/api/mapasygraficos/analisis")
#'
#' # Write and read.
#' tmp <- tempfile(fileext = ".gif")
#'
#' writeBin(image, tmp)
#'
#' gganimate::gif_file(tmp)
#' @export
#' @encoding UTF-8
get_data_aemet <- function(apidest, verbose = FALSE) {
  # Manage the API key.
  apikey_detected <- aemet_detect_api_key()
  if (isFALSE(apikey_detected)) {
    cli::cli_abort(
      "API key cannot be missing. See {.fn climaemet::aemet_api_key}."
    )
  }
  stopifnot(is.logical(verbose))

  getapikeys <- cache_apikeys()
  initapikey <- getapikeys$initapikey
  apikey <- getapikeys$apikey

  if (verbose && length(initapikey) > 1) {
    maskapi <- substr(apikey, nchar(apikey) - 10, nchar(apikey) + 1) # nolint
    cli::cli_par()
    cli::cli_h1("{.pkg climaemet}: API call")
    cli::cli_par()
    cli::cli_alert_info(paste0(
      "Using API KEY ",
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
      "Error parsing JSON. Returning NULL, check your results."
    )
    return(NULL)
  }

  # 2. Get data from first call ----
  if (verbose) {
    cli::cli_h2("Requesting data")
  }

  # Prepare second request
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

  # Last check
  if (!httr2::resp_has_body(response_data)) {
    cli::cli_alert_warning(
      "API request does not return a body. Skipping {.val {apidest}}.",
    )
    return(NULL)
  }

  # Guess the output because AEMET does not always provide correct MIME types.
  # Some JSON payloads are returned as "text/plain".

  mime_data <- httr2::resp_content_type(response_data)

  if (!grepl("json|plain", mime_data)) {
    cli::cli_alert_info("Results are MIME type: {.val {mime_data}}.")
    cli::cli_alert("Returning {.cls raw} bytes. See also {.fn base::writeBin}.")

    raw <- httr2::resp_body_raw(response_data)
    return(raw)
  }

  results_data <- httr2::resp_body_string(response_data)

  # Try to convert the response to a tibble.
  data_tibble_end <- try(
    tibble::as_tibble(jsonlite::fromJSON(results_data)),
    silent = TRUE
  )

  if (inherits(data_tibble_end, "try-error")) {
    cli::cli_alert_info("Results are MIME type: {.val {mime_data}}.")
    cli::cli_alert("Returning data as UTF-8 string.")
    str <- httr2::resp_body_string(response_data)
    return(str)
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
      "API key cannot be missing. See {.fn climaemet::aemet_api_key}."
    )
  }
  stopifnot(is.logical(verbose))

  getapikeys <- cache_apikeys()
  initapikey <- getapikeys$initapikey
  apikey <- getapikeys$apikey

  if (verbose && length(initapikey) > 1) {
    cli::cli_par()
    cli::cli_h1("{.pkg climaemet}: API call")
    cli::cli_par()

    maskapi <- substr(apikey, nchar(apikey) - 10, nchar(apikey) + 1) # nolint
    cli::cli_alert_info(paste0(
      "Using API KEY ",
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
      "Error parsing JSON. Returning NULL, check your results."
    )
    return(NULL)
  }

  # 2. Get data from first call ----
  if (verbose) {
    cli::cli_h2("Requesting metadata")
  }

  # Prepare second request
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

  # Last check
  if (!httr2::resp_has_body(response_data)) {
    cli::cli_alert_warning(
      "API request does not return a body. Skipping {.val {apidest}}."
    )
    return(NULL)
  }

  # Guess the output because AEMET does not always provide correct MIME types.
  # Some JSON payloads are returned as "text/plain".

  mime_data <- httr2::resp_content_type(response_data)

  # This should never happen.
  # nocov start
  if (!grepl("json|plain", mime_data)) {
    cli::cli_alert_info("Results are MIME type: {.val {mime_data}}.")
    cli::cli_alert("Returning {.cls raw} bytes. See also {.fn base::writeBin}.")
    raw <- httr2::resp_body_raw(response_data)
    return(raw)
  }
  # nocov end

  try_list <- try_parse_resp(response_data)

  if (is.list(try_list)) {
    try_list <- try_list[lapply(try_list, length) > 0]
  }

  # Try to convert the response to a tibble.
  data_tibble_end <- try(tibble::as_tibble(try_list), silent = TRUE)

  if (all(inherits(data_tibble_end, "tbl_df"), nrow(data_tibble_end) > 0)) {
    return(data_tibble_end)
  }

  # This branch should never happen.
  # nocov start
  cli::cli_alert_info("Results are MIME type: {.val {mime_data}}.")
  cli::cli_alert("Returning data as UTF-8 string.")
  str <- httr2::resp_body_string(response_data)

  str

  # nocov end
}

#' First call function
#'
#' @description
#' Handle a call to the API.
#'
#' @param apidest Character string as destination URL. See
#'   <https://opendata.aemet.es/dist/index.html>.
#'
#' @param verbose Logical `TRUE/FALSE`. Provides information about the flow of
#' information between the client and server.
#'
#' @param apikey API key.
#'
#' @return
#'
#' - If everything is successful, the result of [httr2::req_perform()].
#' - On warnings, a `NULL` object.
#' - On fatal errors, an error as of [httr2::resp_check_status()].
#'
#' @noRd
aemet_api_call <- function(
  apidest,
  verbose = FALSE,
  data_call = FALSE,
  apikey = NULL
) {
  if (is.null(apikey)) {
    cli::cli_abort("{.arg apikey} cannot be NULL.")
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
  req1 <- httr2::req_timeout(req1, 20)
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

  # Continue on 404 bad request responses.
  if (parsed_code == 404) {
    if (is.null(msg)) {
      msg <- "Not Found."
    }

    cli::cli_alert_danger("HTTP {parsed_code}:")
    cli::cli_bullets(c(" " = "{.emph {msg}}"))
    return(NULL)
  }

  if (parsed_code == 401) {
    if (is.null(msg)) {
      msg <- "API key is not valid. Try with a new one."
    }
    cli::cli_alert_danger(msg)
    httr2::resp_check_status(response)
  }

  # Retry transient API errors.
  if (parsed_code %in% c(429, 500, 503)) {
    if (is.null(msg)) {
      msg <- "Hit API limits."
    }
    cli::cli_alert_warning("HTTP {parsed_code}:")
    cli::cli_bullets(c(" " = "{.emph {msg}}"))
    cli::cli_par()
    cli::cli_alert_info("Retrying.")
    req1 <- httr2::req_retry(
      req1,
      max_seconds = 60,
      is_transient = function(x) {
        httr2::resp_status(x) %in% c(429, 500, 503)
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
      msg <- "API key is not valid. Try with a new one."
    }
    cli::cli_alert_danger(msg)
    httr2::resp_check_status(response)
  }

  if (parsed_code != 200) {
    if (is.null(msg)) {
      msg <- httr2::resp_header(response, "aemet_mensaje")
    }
    if (is.null(msg)) {
      msg <- "Something went wrong."
    }
    cli::cli_alert_danger("HTTP {parsed_code}:")
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
    cli::cli_alert_success("HTTP {parsed_code}: {msg}")
    cli::cli_par()
    if (!is.null(msg_count)) {
      cli::cli_alert_info("Remaining request count: {msg_count}.")
    }
  }

  response
}

# Helpers: cache API keys.
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
        "Can't find any valid API key. See {.fn climaemet::aemet_api_key}."
      )
    }

    db <- tibble::tibble(apikey = initapikey)
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
