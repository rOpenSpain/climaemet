# API Functions: This functions makes a direct call to the API

#' Client tool for AEMET API
#'
#' Client tool to get data and metadata from AEMET and convert json to tibble.
#'
#' @concept aemet_api
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
#' A tibble or an empty tibble if no valid results from the API.
#'
#' @example inst/examples/aemet_api_query.R
#'
#' @export
get_data_aemet <-
  function(apidest,
           apikey = NULL,
           verbose = FALSE) {
    # API Key management
    apikey <-
      dplyr::coalesce(c(apikey, Sys.getenv("AEMET_API_KEY")))[1]

    if (is.null(apikey) || is.na(apikey) || apikey == "") {
      stop("API key can't be missing. See ??aemet_api_key.", call. = FALSE)
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
    while (status %in% c(429, 500) && i_first < 5) {
      response <- httr::GET(url1, httr::add_headers(api_key = apikey))

      i_first <- i_first + 1


      status <- httr::status_code(response)
      headers <- httr::headers(response)

      if (verbose && status == 429) {
        message("Attempt: ", i_first, "/5")
      }

      # Retrieve status after call - sometimes the status is in the header
      if (!is.null(headers$aemet_estado)) {
        status <- as.integer(headers$aemet_estado)
      }

      # On timeout still 429, wait and rerun
      if (status %in% c(429, 500)) {
        if (verbose) {
          httr::message_for_status(status)
          message(headers$aemet_mensaje)
          message("Retry on ", i_first * 10, " seconds...")
        }
        Sys.sleep(i_first * 10)
      }
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

    results <-
      httr::content(response, as = "text", encoding = "UTF-8")

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
      message("Requesting ", data_tibble$datos)
    }
    rm(status, response, headers)

    # Initialise status for the loop
    status_data <- 429
    i_second <- 0
    while (status_data %in% c(429, 500) && i_second < 5) {
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

      # On timeout still 429, wait and rerun
      if (status_data %in% c(429, 500)) {
        if (verbose) {
          httr::message_for_status(status_data)
          message(headers_data$aemet_mensaje)
          message("Retry on ", i_second * 10, " seconds...")
        }
        Sys.sleep(i_second * i_second)
      }
    }
    if (verbose) {
      message(
        "Remaining requests: ",
        headers_data$`remaining-request-count`
      )
    }

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
    data_tibble_end <- jsonlite::fromJSON(results_data)

    data_tibble_end <- tryCatch(
      {
        tibble::as_tibble(data_tibble_end)
      },
      error = function(e) {
        message(
          "Error parsing results. Returning empty line, ",
          "check your results"
        )
        return(NULL)
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

    if (is.null(apikey) || is.na(apikey) || apikey == "") {
      stop("API key can't be missing. See ??aemet_api_key.", call. = FALSE)
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
    while (status %in% c(429, 500) && i_first < 5) {
      response <- httr::GET(url1, httr::add_headers(api_key = apikey))

      i_first <- i_first + 1


      status <- httr::status_code(response)
      headers <- httr::headers(response)

      if (verbose && status == 429) {
        message("Attempt: ", i_first, "/5")
      }

      # Retrieve status after call - sometimes the status is in the header
      if (!is.null(headers$aemet_estado)) {
        status <- as.integer(headers$aemet_estado)
      }

      # On timeout still 429, wait and rerun
      if (status %in% c(429, 500)) {
        if (verbose) {
          httr::message_for_status(status)
          message(headers$aemet_mensaje)
          message("Retry on ", i_first * 10, " seconds...")
        }
        Sys.sleep(i_first * 10)
      }
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

    results <-
      httr::content(response, as = "text", encoding = "UTF-8")

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

    # 2. Get metadata from first call----
    if (verbose) {
      message("-----Requesting data-----")
      message("Requesting ", data_tibble$metadatos)
    }
    rm(status, response, headers)

    # Initialise status for the loop
    status_data <- 429
    i_second <- 0
    while (status_data %in% c(429, 500) && i_second < 5) {
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

      # On timeout still 429, wait and rerun
      if (status_data %in% c(429, 500)) {
        if (verbose) {
          httr::message_for_status(status_data)
          message(headers_data$aemet_mensaje)
          message("Retry on ", i_second * 10, " seconds...")
        }
        Sys.sleep(i_second * i_second)
      }
    }
    if (verbose) {
      message(
        "Remaining requests: ",
        headers_data$`remaining-request-count`
      )
    }

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
    data_tibble_end <- jsonlite::fromJSON(results_data)

    data_tibble_end <- tryCatch(
      {
        tibble::as_tibble(data_tibble_end)
      },
      error = function(e) {
        message(
          "Error parsing results. Returning empty line, ",
          "check your results"
        )
        return(NULL)
      }
    )

    return(data_tibble_end)
  }
