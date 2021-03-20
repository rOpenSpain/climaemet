##############################################################################
# observacion-convencional calls
# https://opendata.aemet.es/dist/index.html#/
##############################################################################

#' Last observation values for a station
#'
#' Get last observation values for a station.
#'
#' @export
#'
#' @concept aemet_observaciones
#'
#' @param station Character string with station identifier code(s)
#'   (see [aemet_stations()]) or "all" for all the values.
#' @inheritParams get_data_aemet
#'
#' @return a tibble.
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#' apikey <- Sys.getenv("AEMET_API_KEY")
#' if (apikey != "") {
#'   library(tibble)
#'   obs <- aemet_last_obs()
#'   glimpse(obs)
#' }
aemet_last_obs <-
  function(station = "all",
           apikey = NULL,
           verbose = FALSE) {
    if (is.na(station) || is.null(station)) {
      stop("Station can't be missing")
    }
    station <- as.character(station)

    # If all

    if ("all" %in% tolower(station)) {
      final_result <-
        get_data_aemet("/api/observacion/convencional/todas", apikey, verbose)
    } else {
      # Vectorize function
      final_result <- NULL

      for (i in seq_len(length(station))) {
        apidest <-
          paste0(
            "/api/observacion/convencional/datos/estacion/",
            station[i]
          )

        final_result <-
          dplyr::bind_rows(final_result, get_data_aemet(apidest, apikey, verbose))
      }
    }


    # Reorder columns
    if ("apidest_error" %in% names(final_result)) {
      final_result <-
        dplyr::bind_cols(
          final_result[!names(final_result) %in% c("apidest_error", "error_message")],
          final_result[c("apidest_error", "error_message")]
        )
    }

    # Format dates
    if ("fint" %in% names(final_result)) {
      final_result["fint"] <-
        lubridate::as_datetime(final_result$fint, tz = "Europe/Madrid")
    }

    # Guess formats

    final_result <- aemet_hlp_guess(final_result, "idema")

    return(final_result)
  }
