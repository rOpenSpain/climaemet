# API Functions: This functions makes a direct call to the API

#' Client tool for AEMET API
#'
#' Client tool to get data and metadata from AEMET and convert json to
#' [tibble][tibble::tibble()].
#'
#' @family aemet_api
#'
#' @source <https://opendata.aemet.es/dist/index.html>
#'
#' @param apidest Character string as destination URL. See
#'   <https://opendata.aemet.es/dist/index.html>.
#'
#' @param verbose Logical `TRUE/FALSE`. Provides information about the flow of
#' information between the client and server.
#'
#'
#' @return
#' A [tibble][tibble::tibble()] (if possible) or the results of the query as
#' provided by [httr2::resp_body_raw()] or [httr2::resp_body_string()].
#'
#' @seealso
#' Some examples on how to use these functions on
#' `vignette("extending-climaemet")`.
#'
#' @examplesIf aemet_detect_api_key()
#' # Run this example only if AEMET_API_KEY is detected
#'
#' url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"
#'
#' get_data_aemet(url)
#'
#'
#' # Metadata
#'
#' get_metadata_aemet(url)
#'
#' # We can get data from any API endpoint
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
#' # Write and read
#' tmp <- tempfile(fileext = ".gif")
#'
#' writeBin(image, tmp)
#'
#' gganimate::gif_file(tmp)
#' @export
get_data_aemet <- function(apidest, verbose = FALSE) {
  # 1. Initial request ----
  response_initial <- aemet_api_call(apidest, verbose)

  if (is.null(response_initial)) {
    return(NULL)
  }

  # Extract data preparing the second request
  results <- try_parse_resp(response_initial)

  if (is.null(results$datos)) {
    warning("Error parsing JSON. Returning empty line, check your results")
    return(NULL)
  }

  # 2. Get data from first call----
  if (verbose) {
    message("\n-----Requesting data-----")
  }

  # Prepare second request
  newapientry <- results$datos
  response_data <- aemet_api_call(newapientry, verbose, data_call = TRUE)

  if (!inherits(response_data, "httr2_response")) {
    return(NULL)
  }


  # Last check
  if (!httr2::resp_has_body(response_data)) {
    warning("API request does not return a body. Skipping ", apidest)
    return(NULL)
  }

  # Try to guess output, AEMET does not provide right mime types
  # Some json texts are given as "text/plain"


  mime_data <- httr2::resp_content_type(response_data)

  if (!grepl("json|plain", mime_data)) {
    message(
      "\nResults are MIME type: ", mime_data, "\n",
      "Returning raw data"
    )
    raw <- httr2::resp_body_raw(response_data)
    return(raw)
  }



  results_data <- httr2::resp_body_string(response_data)

  # try to tibble
  data_tibble_end <- try(tibble::as_tibble(jsonlite::fromJSON(results_data)),
    silent = TRUE
  )

  if (inherits(data_tibble_end, "try-error")) {
    message(
      "\nResults are MIME type: ", mime_data, "\n",
      "Returning data as string"
    )
    str <- httr2::resp_body_string(response_data)
    return(str)
  }

  return(data_tibble_end)
}

#' @rdname get_data_aemet
#' @name get_data_aemet
#' @export
get_metadata_aemet <- function(apidest, verbose = FALSE) {
  # API Key management
  apikey_detected <- aemet_detect_api_key()
  if (isFALSE(apikey_detected)) {
    stop("API key can't be missing. See ??aemet_api_key.", call. = FALSE)
  }
  apikey <- Sys.getenv("AEMET_API_KEY")


  stopifnot(is.logical(verbose))
  url_base <- "https://opendata.aemet.es/opendata"

  url1 <- paste0(url_base, apidest)

  if (verbose) {
    message("\nRequesting ", url1)
  }


  # 1. Call: Get path----
  response <- httr::GET(url1, httr::add_headers(api_key = apikey))

  status <- httr::status_code(response)
  headers <- httr::headers(response)

  delay_aemet_api(headers$`remaining-request-count`)

  # Retrieve status after call - sometimes the status is in the header
  if (!is.null(headers$aemet_estado)) {
    status <- as.integer(headers$aemet_estado)
  }

  # On 401 stop, invalid API Key
  if (status == 401) {
    message("API Key Not Valid. Try with a new one.")
    httr::stop_for_status(status)
  }

  # On timeout retry
  if (status %in% c(429, 500)) {
    response <- httr::RETRY("GET", url1, httr::add_headers(api_key = apikey),
      quiet = !verbose,
      pause_min = 30, pause_base = 30, pause_cap = 60
    )
  }

  status <- httr::status_code(response)
  headers <- httr::headers(response)
  if (!is.null(headers$aemet_estado)) {
    status <- as.integer(headers$aemet_estado)
  }
  if (verbose) {
    httr::message_for_status(status)
    message(headers$aemet_mensaje)
  }

  # Status handling: Valid 200, Invalid 401, The rest are empty,
  if (status == 401) {
    message("API Key Not Valid. Try with a new one.")
    httr::stop_for_status(status)
  } else if (status != 200) {
    # Return NULL value
    msg <- "Something went wrong"
    if (!is.null(headers$aemet_mensaje)) {
      msg <- headers$aemet_mensaje
    }
    httr::message_for_status(status)
    message() # Create new line
    warning("With: ", apidest, ": ", msg, call. = FALSE)

    return(NULL)
  }

  results <- httr::content(response, as = "text", encoding = "UTF-8")

  # On error when parsing return NULL
  if (isFALSE(jsonlite::validate(results))) {
    warning("Error parsing JSON. Returning empty line, check your results")
    return(NULL)
  }

  # OK, valid
  if (verbose) {
    httr::message_for_status(status)
    message(headers$aemet_mensaje)
  }

  data_tibble <- jsonlite::fromJSON(results)
  data_tibble <- tibble::as_tibble(data_tibble)

  # 2. Get data from first call----
  if (verbose) {
    message("-----Requesting data-----")
    message("Requesting ", data_tibble$metadatos)
  }
  rm(status, response, headers)

  # Initialise status for the loop
  response_data <- httr::GET(data_tibble$metadatos)

  # Retrieve status after call
  status_data <- httr::status_code(response_data)
  headers_data <- httr::headers(response_data)

  # On timeout still 429, wait and rerun
  if (status_data %in% c(429, 500)) {
    response_data <- httr::RETRY("GET", data_tibble$metadatos,
      quiet = !verbose,
      pause_min = 30, pause_base = 30, pause_cap = 60
    )
  }

  status_data <- httr::status_code(response_data)
  headers_data <- httr::headers(response_data)

  if (verbose) {
    message(
      "Remaining requests: ",
      headers_data$`remaining-request-count`
    )
  }

  delay_aemet_api(headers_data$`remaining-request-count`)

  # Status handling: Valid 200, Invalid 401, The rest are empty,
  if (status_data == 401) {
    message("API Key Not Valid. Try with a new one.")
    httr::stop_for_status(status_data)
  } else if (status_data != 200) {
    # Return NULL value
    if (!is.null(headers_data$aemet_mensaje)) {
      message(headers_data$aemet_mensaje)
    }
    httr::warn_for_status(status_data)
    return(NULL)
  }

  if (verbose) {
    httr::message_for_status(status_data)
    message(headers_data$aemet_mensaje)
  }

  results_data <- httr::content(response_data)

  data_tibble_end <- tryCatch(
    {
      s <- jsonlite::fromJSON(results_data)
      this <- vapply(s, length, FUN.VALUE = numeric(1)) > 0
      tibble::as_tibble(s[this])
    },
    error = function(e) {
      return(results_data)
    }
  )

  return(data_tibble_end)
}

#' First call function
#'
#' @description
#' Handles call to API.
#'
#' @param apidest Character string as destination URL. See
#'   <https://opendata.aemet.es/dist/index.html>.
#'
#' @param verbose Logical `TRUE/FALSE`. Provides information about the flow of
#' information between the client and server.
#' @return
#'
#' - If everything is successful, the result of [httr2::req_perform()].
#' - On warnings, a `NULL` object.
#' - On fatal errors, an error as of [httr2::resp_check_status()].
#'
#' @noRd
aemet_api_call <- function(apidest, verbose = FALSE, data_call = FALSE) {
  # API Key management
  apikey_detected <- aemet_detect_api_key()
  if (isFALSE(apikey_detected)) {
    stop("API key can't be missing. See ??aemet_api_key.", call. = FALSE)
  }
  apikey <- Sys.getenv("AEMET_API_KEY")


  stopifnot(is.logical(verbose))

  # Prepare initial request
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

  # Perform resquest
  if (verbose) {
    message("\nRequesting ", req1$url)
  }

  response <- httr2::req_perform(req1)
  # Add extra delay based on Remaining request
  msg_count <- httr2::resp_header(response, "Remaining-request-count")
  delay_aemet_api(msg_count)


  # Other msgs

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

  # On 404 continue, bad request
  if (parsed_code == 404) {
    if (is.null(msg)) msg <- "Not Found"

    warning("HTTP ", parsed_code, ": ", msg)
    return(NULL)
  }

  if (parsed_code == 401) {
    if (is.null(msg)) msg <- "API Key Not Valid. Try with a new one."
    message(msg)
    httr2::resp_check_status(response)
  }

  # In other cases retry
  if (parsed_code %in% c(429, 500, 503)) {
    if (is.null(msg)) msg <- "Hit API Limits."
    message("HTTP ", parsed_code, ": ", msg, " Retrying...")
    req1 <- httr2::req_retry(req1,
      max_seconds = 60,
      is_transient = function(x) {
        httr2::resp_status(x) %in% c(429, 500, 503)
      }
    )

    response <- httr2::req_perform(req1)
  }

  # Prepare for final output re-parsing code again
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
    if (is.null(msg)) msg <- "API Key Not Valid. Try with a new one."
    message(msg)
    httr2::resp_check_status(response)
  }

  if (parsed_code != 200) {
    if (is.null(msg)) msg <- httr2::resp_header(response, "aemet_mensaje")
    if (is.null(msg)) msg <- "Something went wrong"
    warning("HTTP ", parsed_code, ": ", msg)
    return(NULL)
  }

  msg_count <- httr2::resp_header(response, "Remaining-request-count")
  if (verbose) {
    if (is.null(msg)) msg <- httr2::resp_header(response, "aemet_mensaje")
    if (is.null(msg)) msg <- "OK"
    message("HTTP ", parsed_code, ": ", msg)

    if (!is.null(msg_count)) {
      message("Remaining request count: ", msg_count)
    }
  }

  return(response)
}
