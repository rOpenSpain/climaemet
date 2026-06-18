# observacion-convencional calls
# https://opendata.aemet.es/dist/index.html#/

#' Last observation values for a station
#'
#' Get last observation values for a station.
#'
#' @param station Character string with station identifier code(s) (see
#'   [aemet_stations()]) or `"all"` for all the stations.
#' @param return_sf Logical. If `TRUE`, the function returns an
#'   [`sf`][sf::st_sf] spatial object. If `FALSE` (the default value), it
#'   returns a [tibble][dplyr::tibble]. The \CRANpkg{sf} package must be
#'   installed.
#' @param progress Logical. Displays a [cli::cli_progress_bar()] object. If
#'   `verbose = TRUE`, it will not be displayed.
#'
#' @inheritParams get_data_aemet
#' @inheritParams aemet_forecast_daily
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @return A [tibble][dplyr::tibble] or a \CRANpkg{sf} object.
#'
#' @family aemet_api_data
#'
#' @export
#' @encoding UTF-8
#'
#' @examplesIf aemet_detect_api_key()
#' obs <- aemet_last_obs(c("9434", "3195"))
#' dplyr::glimpse(obs)
aemet_last_obs <- function(
  station = "all",
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs ----
  if (is.null(station)) {
    cli::cli_abort("{.arg station} cannot be {.obj_type_friendly {station}}.")
  }

  aemet_hlp_validate_logical(return_sf, "return_sf")
  aemet_hlp_validate_logical(verbose, "verbose")

  station <- as.character(station)

  # Use a simplified request for metadata.
  if (isTRUE(extract_metadata)) {
    if (tolower(station[1]) == "all") {
      station <- default_station
    }
    station <- station[1]
  }
  # 2. Call API ----

  ## Metadata -----

  if (isTRUE(extract_metadata)) {
    final_result <- get_metadata_aemet(
      apidest = aemet_endpoint_last_obs("all"),
      verbose = verbose
    )
    return(final_result)
  }

  ## Normal call ----

  station <- aemet_hlp_match_all(station)

  final_result <- aemet_hlp_fetch_loop(
    station,
    function(id) {
      get_data_aemet(
        apidest = aemet_endpoint_last_obs(id),
        verbose = verbose
      )
    },
    progress = progress,
    verbose = verbose
  )

  final_result <- aemet_hlp_finalize(final_result, "idema")

  # Check spatial output ----
  if (return_sf) {
    final_result <- aemet_hlp_sf(final_result, "lat", "lon", verbose)
  }

  final_result
}
