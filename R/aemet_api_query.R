# API Functions: This functions makes a direct call to the API

#' Client tool for AEMET API
#'
#' Client tool to get data and metadata from AEMET and convert json to tibble.
#'
#' @source <https://opendata.aemet.es/dist/index.html>
#'
#' @param apidest Character string as destination URL. See
#'   <https://opendata.aemet.es/dist/index.html>.
#'
#' @param apikey Character string as personal API key. It can be set
#'   on the environment variable AEMET_API_KEY, see [aemet_api_key()].
#'
#' @param verbose Logical TRUE/FALSE. Provides information about the flow of
#' information between the client and server.
#'
#'
#' @return
#' A tibble. On error, a tibble with a column `apidest_error` showing the
#' errored apidest and `error_message` column is returned.
#'
#' @examples
#' url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"
#' get_data_aemet(url)
#' get_metadata_aemet(url)
#' @export
get_data_aemet <-
  function(apidest,
           apikey = NULL,
           verbose = FALSE) {
    # API Key management
    apikey <-
      dplyr::coalesce(c(apikey, Sys.getenv("AEMET_API_KEY")))[1]

    NA_result <-
      tibble::tibble(apidest_error = apidest, error_message = "No API Key")

    if (is.null(apikey) || is.na(apikey) || apikey == "") {
      message("AEMET apikey not found, returning empty result")
      message("See ??aemet_api_key")
      return(NA_result)
    }
    stopifnot(is.logical(verbose))
    url_base <- "https://opendata.aemet.es/opendata"

    url1 <- paste0(url_base, apidest)

    if (verbose) {
      message("\nRequesting ", url1)
    }


    # 1. First call: Get path----

    # Initialise status for the loop

    status <- 429
    i_first <- 0
    while (status == 429 && i_first < 5) {
      response <- httr::GET(url1, httr::add_headers(api_key = apikey))

      i_first <- i_first + 1

      # Retrieve status after call
      status <- httr::status_code(response)
      headers <- httr::headers(response)

      if (verbose && status == 429) {
        message("Attempt: ", i_first, "/5")
      }
      # Overwrite
      if (!is.null(headers$aemet_estado)) {
        status <- as.integer(headers$aemet_estado)
      }

      if (verbose) {
        httr::message_for_status(status)
        message(headers$aemet_mensaje)
      }

      # On timeout still 429, wait and rerun
      if (status == 429) {
        if (verbose) {
          message("Retry on ", i_first * 10, " seconds...")
        }
        Sys.sleep(i_first * 10)
      }
    }


    # On bad request return empty tibble
    if (!status %in% c(200)) {
      NA_result[["error_message"]] <- paste0("Error Code: ", status)
      message("Error on request. Returning empty line, check your results")
      return(NA_result)
    }

    results <-
      httr::content(response, as = "text", encoding = "UTF-8")
    # On error when parsing
    if (isFALSE(jsonlite::validate(results))) {
      message("Error parsing JSON. Returning empty line, check your results")
      NA_result[["error_message"]] <- "Error parsing JSON"
      return(NA_result)
    }

    data_tibble <- jsonlite::fromJSON(results)
    data_tibble <- tibble::as_tibble(data_tibble)

    # 2. Get data from first call----
    if (verbose) {
      message("-----Requesting data-----")
      message("Requesting ", data_tibble$datos)
    }
    rm(status, response, headers)
    # Initialise status for the loop
    status_data <- 429
    i_second <- 0
    while (status_data == 429 && i_second < 5) {
      response_data <-
        httr::GET(data_tibble$datos, httr::add_headers(api_key = apikey))

      i_second <- i_second + 1

      # Retrieve status after call
      status_data <- httr::status_code(response_data)
      headers_data <- httr::headers(response_data)

      if (verbose && status_data == 429) {
        message("Attempt: ", i_second, "/5")
      }

      # Overwrite
      if (!is.null(headers_data$aemet_estado)) {
        status_data <- as.integer(headers_data$aemet_estado)
      }

      if (verbose) {
        httr::message_for_status(status_data)
        message(headers_data$aemet_mensaje)
      }

      # On timeout still 429, wait and rerun
      if (status_data == 429) {
        if (verbose) {
          message("Retry on ", i_second * 10, "seconds...")
        }
        Sys.sleep(i_second * i_second)
      }
    }

    # On bad request return empty tibble
    if (!status_data %in% c(200)) {
      message("Error on some requests. Returning empty line, check your results")
      NA_result[["error_message"]] <- paste0("Error Code: ", status_data)
      return(NA_result)
    }
    if (verbose) {
      message(
        "Remaining requests: ",
        headers_data$`remaining-request-count`
      )
    }

    results_data <- httr::content(response_data)
    data_tibble_end <- jsonlite::fromJSON(results_data)

    data_tibble_end <- tryCatch(
      {
        tibble::as_tibble(data_tibble_end)
      },
      error = function(e) {
        message("Error parsing results. Returning empty line, check your results")
        NA_result[["error_message"]] <- paste0("Error parsing result")
        return(NA_result)
      }
    )

    return(data_tibble_end)
  }

#' @rdname get_data_aemet
#' @export
get_metadata_aemet <-
  function(apidest,
           apikey = NULL,
           verbose = FALSE) {
    # API Key management
    apikey <-
      dplyr::coalesce(c(apikey, Sys.getenv("AEMET_API_KEY")))[1]

    NA_result <-
      tibble::tibble(apidest_error = apidest, error_message = "No API Key")

    if (is.null(apikey) || is.na(apikey) || apikey == "") {
      message("AEMET apikey not found, returning empty result")
      message("See ??aemet_api_key")
      return(NA_result)
    }

    url_base <- "https://opendata.aemet.es/opendata"

    url1 <- paste0(url_base, apidest)

    if (verbose) {
      message("\nRequesting ", url1)
    }


    # 1. First call: Get path----

    # Initialise status for the loop

    status <- 429
    i_first <- 0
    while (status == 429 && i_first < 5) {
      response <- httr::GET(url1, httr::add_headers(api_key = apikey))

      i_first <- i_first + 1

      # Retrieve status after call
      status <- httr::status_code(response)
      headers <- httr::headers(response)

      if (verbose && status == 429) {
        message("Attempt: ", i_first, "/5")
      }
      # Overwrite
      if (!is.null(headers$aemet_estado)) {
        status <- as.integer(headers$aemet_estado)
      }

      if (verbose) {
        httr::message_for_status(status)
        message(headers$aemet_mensaje)
      }

      # On timeout still 429, wait and rerun
      if (status == 429) {
        if (verbose) {
          message("Retry on ", i_first * 10, " seconds...")
        }
        Sys.sleep(i_first * 10)
      }
    }


    # On bad request return empty tibble
    if (!status %in% c(200)) {
      NA_result[["error_message"]] <- paste0("Error Code: ", status)
      return(NA_result)
    }

    results <-
      httr::content(response, as = "text", encoding = "UTF-8")
    # On error when parsing
    if (isFALSE(jsonlite::validate(results))) {
      message("Error parsing JSON")
      NA_result[["error_message"]] <- "Error parsing JSON"

      return(NA_result)
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
    status_data <- 429
    i_second <- 0
    while (status_data == 429 && i_second < 5) {
      response_data <-
        httr::GET(
          data_tibble$metadatos,
          httr::add_headers(api_key = apikey)
        )

      i_second <- i_second + 1

      # Retrieve status after call
      status_data <- httr::status_code(response_data)
      headers_data <- httr::headers(response_data)

      if (verbose && status_data == 429) {
        message("Attempt: ", i_second, "/5")
      }

      # Overwrite
      if (!is.null(headers_data$aemet_estado)) {
        status_data <- as.integer(headers_data$aemet_estado)
      }

      if (verbose) {
        httr::message_for_status(status_data)
        message(headers_data$aemet_mensaje)
      }

      # On timeout still 429, wait and rerun
      if (status_data == 429) {
        if (verbose) {
          message("Retry on ", i_second * 10, "seconds...")
        }
        Sys.sleep(i_second * i_second)
      }
    }

    # On bad request return empty tibble
    if (!status_data %in% c(200)) {
      NA_result[["error_message"]] <- paste0("Error Code: ", status_data)
      return(NA_result)
    }
    if (verbose) {
      message(
        "Remaining requests: ",
        headers_data$`remaining-request-count`
      )
    }

    results_data <- httr::content(response_data)
    data_tibble_end <- jsonlite::fromJSON(results_data)
    data_tibble_end <- tibble::as_tibble(data_tibble_end)

    return(data_tibble_end)
  }
