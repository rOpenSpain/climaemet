# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' Extreme values for a station
#'
#' Get recorded extreme values for a station.
#'
#' @family aemet_api_data
#'
#' @param station Character string with station identifier code(s)
#'   (see [aemet_stations()]).
#'
#' @param parameter Character string as temperature (`"T"`),
#'   precipitation (`"P"`) or wind (`"V"`) parameter.
#'
#' @inheritParams aemet_last_obs
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @seealso [aemet_api_key()]
#' @return
#' A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object. If the function
#' finds an error when parsing it would return the result as a `list()` object.
#'
#' @examplesIf aemet_detect_api_key()
#' library(tibble)
#' obs <- aemet_extremes_clim(c("9434", "3195"))
#' glimpse(obs)
#' @export

aemet_extremes_clim <- function(station = NULL, parameter = "T",
                                verbose = FALSE, return_sf = FALSE,
                                extract_metadata = FALSE, progress = TRUE) {
  # 1. Validate parameters----
  if (is.null(station)) {
    stop("Station can't be missing")
  }

  station <- as.character(station)

  if (isTRUE(extract_metadata)) station <- default_station

  if (is.null(parameter)) {
    stop("Parameter can't be missing")
  }

  if (!is.character(parameter)) {
    stop("Parameter need to be character string")
  }

  if (!parameter %in% c("T", "P", "V")) {
    stop("Parameter should be one of 'T', 'P', 'V'")
  }

  # 2. Call API----

  ## Metadata ----

  if (extract_metadata) {
    apidest <- paste0(
      "/api/valores/climatologicos/valoresextremos/parametro/",
      parameter, "/estacion/", default_station
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
  if (verbose) progress <- FALSE
  if (!cli::is_dynamic_tty()) progress <- FALSE

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
      total = length(station), clear = FALSE
    )
  }

  # nocov end
  # nolint end

  for (id in station) {
    apidest <- paste0(
      "/api/valores/climatologicos",
      "/valoresextremos/parametro/", parameter, "/estacion/",
      id
    )


    if (progress) cli::cli_progress_update() # nocov
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

  bindtry <- try(dplyr::bind_rows(final_result), silent = TRUE)
  if (inherits(bindtry, "try-error")) {
    message("Can't convert to tibble, return list")
    return(final_result)
  }
  final_result <- dplyr::bind_rows(final_result)
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(final_result, "indicativo", dec_mark = ".")

  # Check spatial----
  if (return_sf) {
    # Coordinates from stations
    sf_stations <- aemet_stations(verbose, return_sf = FALSE)
    sf_stations <- sf_stations[c("indicativo", "latitud", "longitud")]

    final_result <- dplyr::left_join(final_result, sf_stations,
      by = "indicativo"
    )
    final_result <- aemet_hlp_sf(final_result, "latitud", "longitud", verbose)
  }

  final_result
}
