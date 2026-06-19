# AEMET conventional observation endpoints.

#' Latest observations from weather stations
#'
#' Retrieves the latest observations for one or more weather stations.
#'
#' @param station A character vector of station identifiers (see
#'   [aemet_stations()]) or `"all"` for all stations.
#' @param return_sf A logical value. If `TRUE`, the function returns an
#'   [`sf`][sf::st_sf] spatial object. If `FALSE` (the default), it
#'   returns a [tibble][dplyr::tibble]. The \CRANpkg{sf} package must be
#'   installed.
#' @param progress A logical value. If `TRUE`, displays a
#'   [cli::cli_progress_bar()] unless `verbose = TRUE`.
#' @param extract_metadata A logical value. If `TRUE`, returns a
#'   [tibble][dplyr::tibble] describing the response fields. See
#'   [get_metadata_aemet()].
#'
#' @inheritParams get_data_aemet verbose
#'
#' @inheritSection aemet_api_key API key
#'
#' @returns A [tibble][dplyr::tibble] or a \CRANpkg{sf} object.
#'
#' @concept observations
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
  # 2. Call the API ----

  ## Metadata ----

  if (isTRUE(extract_metadata)) {
    final_result <- get_metadata_aemet(
      apidest = aemet_endpoint_last_obs("all"),
      verbose = verbose
    )
    return(final_result)
  }

  ## Data request ----

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

  # Prepare spatial output ----
  if (return_sf) {
    final_result <- aemet_hlp_sf(final_result, "lat", "lon", verbose)
  }

  final_result
}
