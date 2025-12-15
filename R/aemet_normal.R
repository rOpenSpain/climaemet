# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' Normal climatology values
#'
#' @rdname aemet_normal
#' @name aemet_normal
#' @family aemet_api_data
#'
#' @description
#' Get normal climatology values for a station (or all the stations with
#' `aemet_normal_clim_all()`. Standard climatology from 1981 to 2010.
#'
#' @note
#' Code modified from project <https://github.com/SevillaR/aemet>.
#'
#' @inheritParams aemet_last_obs
#'
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object.
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @examplesIf aemet_detect_api_key()
#'
#' library(tibble)
#' obs <- aemet_normal_clim(c("9434", "3195"))
#' glimpse(obs)
#' @export

aemet_normal_clim <- function(
  station = NULL,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs----
  if (is.null(station)) {
    stop("Station can't be missing")
  }

  stopifnot(is.logical(return_sf))
  stopifnot(is.logical(verbose))

  station <- as.character(station)

  if (isTRUE(extract_metadata)) {
    station <- default_station
  }

  # 2. Call API----

  ## Metadata ----
  if (extract_metadata) {
    apidest <- paste0(
      "/api/valores/climatologicos/normales/estacion/",
      station
    )
    final_result <- get_metadata_aemet(
      apidest = apidest,
      verbose = verbose
    )
    return(final_result)
  }

  ## Normal call ----

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
    apidest <- paste0("/api/valores/climatologicos/normales/estacion/", id)

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
  final_result <- aemet_hlp_guess(final_result, "indicativo", dec_mark = ".")

  # Check spatial----
  if (return_sf) {
    # Coordinates from statios
    sf_stations <- aemet_stations(verbose, return_sf = FALSE)
    sf_stations <- sf_stations[c("indicativo", "latitud", "longitud")]

    final_result <- dplyr::left_join(
      final_result,
      sf_stations,
      by = "indicativo"
    )

    final_result <- aemet_hlp_sf(final_result, "latitud", "longitud", verbose)
  }

  final_result
}

#' @rdname aemet_normal
#' @name aemet_normal
#'
#'
#' @export
aemet_normal_clim_all <- function(
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # Parameters are validated on aemet_normal_clim

  if (isTRUE(extract_metadata)) {
    stations <- data.frame(indicativo = default_station)
  } else {
    stations <- aemet_stations(verbose = verbose) # nocov
  }

  # No cover since is a huge extraction
  # nocov start
  data_all <- aemet_normal_clim(
    stations$indicativo,
    verbose = verbose,
    return_sf = return_sf,
    extract_metadata = extract_metadata,
    progress = progress
  )
  # nocov end

  data_all
}
