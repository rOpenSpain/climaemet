# observacion-convencional calls
# https://opendata.aemet.es/dist/index.html#/

#' Last observation values for a station
#'
#' Get last observation values for a station.
#'
#' @export
#'
#' @family aemet_api_data
#'
#' @param station Character string with station identifier code(s)
#'   (see [aemet_stations()]) or "all" for all the stations.
#' @inheritParams get_data_aemet
#' @inheritParams aemet_forecast_daily
#'
#' @param return_sf Logical `TRUE` or `FALSE`.
#'   Should the function return an `sf` spatial object? If `FALSE`
#'   (the default value) it returns a tibble. Note that you need to
#'   have the `sf` package installed.
#'
#' @return A tibble or a `sf` object.
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @examplesIf aemet_detect_api_key()
#'
#' library(tibble)
#' obs <- aemet_last_obs(c("9434", "3195"))
#' glimpse(obs)
aemet_last_obs <- function(station = "all", verbose = FALSE,
                           return_sf = FALSE, extract_metadata = FALSE) {
  # Validate inputs----
  if (is.null(station)) {
    stop("Station can't be missing")
  }

  stopifnot(is.logical(return_sf))
  stopifnot(is.logical(verbose))

  station <- as.character(station)

  # For metadata
  if (isTRUE(extract_metadata)) {
    st <- aemet_stations()
    station <- st$indicativo[[1]]
  }
  # Call API----
  ## All----
  if ("all" %in% tolower(station)) {
    final_result <-
      get_data_aemet("/api/observacion/convencional/todas", verbose)
  } else {
    # Single request----
    # Vectorize function
    final_result <- NULL

    for (i in seq_len(length(station))) {
      apidest <- paste0(
        "/api/observacion/convencional/datos/estacion/",
        station[i]
      )

      if (isTRUE(extract_metadata)) {
        final_result <- get_metadata_aemet(
          apidest = apidest,
          verbose = verbose
        )
      } else {
        final_result <-
          dplyr::bind_rows(
            final_result,
            get_data_aemet(apidest, verbose)
          )
      }
    }
  }

  final_result <- dplyr::distinct(final_result)
  if (isTRUE(extract_metadata)) {
    return(final_result)
  }

  # Guess formats----
  final_result <-
    aemet_hlp_guess(final_result, "idema", dec_mark = ".")

  # Check spatial----
  if (return_sf) {
    final_result <- aemet_hlp_sf(final_result, "lat", "lon", verbose)
  }

  return(final_result)
}
