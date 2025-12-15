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
#'   Should the function return an [`sf`][sf::st_sf] spatial object? If `FALSE`
#'   (the default value) it returns a [`tibble`][tibble::tibble()]. Note that
#'   you need to have the \CRANpkg{sf} package installed.
#' @param progress Logical, display a [cli::cli_progress_bar()] object. If
#'   `verbose = TRUE` won't be displayed.
#'
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @examplesIf aemet_detect_api_key()
#'
#' library(tibble)
#' obs <- aemet_last_obs(c("9434", "3195"))
#' glimpse(obs)
aemet_last_obs <- function(
  station = "all",
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs----
  if (is.null(station)) {
    cli::cli_abort("{.arg station} can't be {.obj_type_friendly {station}}.")
  }

  stopifnot(is.logical(return_sf))
  stopifnot(is.logical(verbose))

  station <- as.character(station)

  # For metadata
  if (isTRUE(extract_metadata)) {
    if (tolower(station[1]) == "all") {
      station <- default_station
    }
    station <- station[1]
  }
  # 2. Call API----

  ## Metadata -----

  if (isTRUE(extract_metadata)) {
    final_result <- get_metadata_aemet(
      apidest = "/api/observacion/convencional/todas",
      verbose = verbose
    )
    return(final_result)
  }

  ## Normal call ----

  if (any(station == "all")) {
    station <- "all"
  }

  # Make calls on loop for progress bar
  final_result <- list() # Store results

  # Deactive progressbar if verbose
  if (verbose) {
    progress <- FALSE
  }
  if (!cli::is_dynamic_tty()) {
    progress <- FALSE
  }

  # nolint start
  # nocov start
  if (progress) {
    opts <- options()
    options(
      cli.progress_bar_style = "fillsquares",
      cli.progress_show_after = 3,
      cli.spinner = "clock"
    )

    cli::cli_progress_bar(
      format = paste0(
        "{cli::pb_spin} AEMET API ({cli::pb_current}/{cli::pb_total}) ",
        "| {cli::pb_bar} {cli::pb_percent}  ",
        "| ETA:{cli::pb_eta} [{cli::pb_elapsed}]"
      ),
      total = length(station),
      clear = FALSE
    )
  }

  # nocov end
  # nolint end

  for (id in station) {
    if (id == "all") {
      apidest <- "/api/observacion/convencional/todas"
    } else {
      apidest <- paste0("/api/observacion/convencional/datos/estacion/", id)
    }

    if (progress) {
      cli::cli_progress_update()
    } # nocov
    df <- get_data_aemet(apidest = apidest, verbose = verbose)

    final_result <- c(final_result, list(df))
  }

  # nolint start
  # nocov start

  if (progress) {
    cli::cli_progress_done()
    options(
      cli.progress_bar_style = opts$cli.progress_bar_style,
      cli.progress_show_after = opts$cli.progress_show_after,
      cli.spinner = opts$cli.spinner
    )
  }

  # nocov end
  # nolint end

  final_result <- dplyr::bind_rows(final_result)
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(final_result, "idema")

  # Check spatial----
  if (return_sf) {
    final_result <- aemet_hlp_sf(final_result, "lat", "lon", verbose)
  }

  final_result
}
