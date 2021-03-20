##############################################################################
# API Functions: This functions makes a direct call to the API
##############################################################################

#' Client tool for AEMET API
#'
#' @description Client tool to get data from AEMET and convert json to tibble.
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
#' @param ... Further arguments of the function.
#'
#' @return
#' A tibble. On error, a tibble with a column `apidest_error` showing the
#' errored apidest and `error_message` column is returned.
#'
#' @export
get_data_aemet <-
  function(apidest,
           apikey = NULL,
           verbose = FALSE,
           ...) {
    # Extract internal
    extra_args <- list(...)
    retry <- extra_args[["retry"]]
    data_request <- extra_args[["data_request"]]

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
    if (is.null(data_request)) {
      url_base <- "https://opendata.aemet.es/opendata"
    } else {
      url_base <- ""
    }

    url1 <- paste0(url_base, apidest)

    if (verbose) {
      message("\nRequesting ", url1)
    }
    # Get path----
    response <- httr::GET(url1, httr::add_headers(api_key = apikey))

    status <- httr::status_code(response)
    headers <- httr::headers(response)


    # Overwrite
    if (!is.null(headers$aemet_estado)) {
      status <- as.integer(headers$aemet_estado)
    }

    if (verbose) {
      httr::message_for_status(status)
      message(headers$aemet_mensaje)
    }

    # On timeout, wait and rerun
    if (status == 429 && is.null(retry)) {
      if (verbose) {
        message("Retry on 6 seconds...")
      }
      Sys.sleep(6)
      retry <- get_data_aemet(apidest, apikey, verbose, FALSE)
      return(retry)
    }

    # On bad request return empty tibble
    if (!status %in% c(200)) {
      NA_result[["error_message"]] <- paste0("Error Code: ", status)
      return(NA_result)
    }

    # Different parsing on data request or main request
    if (is.null(data_request)) {
      results <- httr::content(response, as = "text", encoding = "UTF-8")
      # On error when parsing
      if (isFALSE(jsonlite::validate(results))) {
        message("Error parsing JSON")
        NA_result[["error_message"]] <- "Error parsing JSON"

        return(NA_result)
      }
    } else {
      results <- httr::content(response)
    }

    data_tibble <- jsonlite::fromJSON(results)
    data_tibble <- tibble::as_tibble(data_tibble)

    # Get data----
    if (is.null(data_request)) {
      if (verbose) {
        message("-----Requesting data-----")
      }
      data_tibble <-
        get_data_aemet(
          data_tibble$datos,
          apikey = apikey,
          verbose = verbose,
          data_request = TRUE
        )
    }
    return(data_tibble)
  }
