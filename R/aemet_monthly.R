# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' Monthly/annual climatology
#'
#' @description
#' Get monthly/annual climatology values for a station or all the stations.
#' `aemet_monthly_period()` and `aemet_monthly_period_all()` allows requests
#' that span several years.
#'
#' @rdname aemet_monthly
#' @name aemet_monthly
#'
#' @family aemet_api_data
#'
#' @param station Character string with station identifier code(s)
#'   (see [aemet_stations()]).
#'
#' @param year Numeric value as date (format: `YYYY`).
#'
#' @inheritParams aemet_last_obs
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object.
#'
#' @examplesIf aemet_detect_api_key()
#'
#' library(tibble)
#' obs <- aemet_monthly_clim(station = c("9434", "3195"), year = 2000)
#' glimpse(obs)
#' @export
aemet_monthly_clim <- function(
  station = NULL,
  year = as.integer(format(Sys.Date(), "%Y")),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs----
  if (is.null(station)) {
    stop("Station can't be missing")
  }
  station <- as.character(station)
  if (isTRUE(extract_metadata)) {
    station <- default_station
  }

  if (!is.numeric(year)) {
    stop("Year need to be numeric")
  }
  stopifnot(is.logical(verbose))
  stopifnot(is.logical(return_sf))

  today <- as.integer(format(Sys.Date(), "%Y"))

  year <- min(year, today)
  # 2. Call API----

  ## Metadata ----
  if (extract_metadata) {
    apidest <- paste0(
      "/api/valores/climatologicos/mensualesanuales/datos",
      "/anioini/",
      year,
      "/aniofin/",
      year,
      "/estacion/",
      station
    )
    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
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
    apidest <- paste0(
      "/api/valores/climatologicos/mensualesanuales/datos",
      "/anioini/",
      year,
      "/aniofin/",
      year,
      "/estacion/",
      id
    )

    if (progress) {
      cli::cli_progress_update()
    } # nocov
    df <- get_data_aemet(apidest = apidest, verbose = verbose)

    for (i in seq_len(9)) {
      patt <- paste0("-", i, "$")
      newpat <- paste0("-0", i)
      df$fecha <- gsub(patt, newpat, df$fecha)
    }

    df <- df[order(df$fecha), ]

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

  # Final tweaks
  final_result <- dplyr::bind_rows(final_result)
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(final_result, "indicativo", dec_mark = ".")

  # Check spatial----
  if (return_sf) {
    # Coordinates from stations
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

#' @rdname aemet_monthly
#'
#' @param start Numeric value as start year (format: `YYYY`).
#'
#' @param end Numeric value as end year (format: `YYYY`).
#'
#' @export
aemet_monthly_period <- function(
  station = NULL,
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs----
  if (is.null(station)) {
    stop("Station can't be missing")
  }

  if (!is.numeric(start)) {
    stop("Start year need to be numeric")
  }

  if (!is.numeric(end)) {
    stop("End year need to be numeric")
  }

  # The rest of parameters are validated in aemet_monthly_clim

  final_result <- NULL
  # 2. Call API----

  ## Metadata ----
  if (extract_metadata) {
    # Use monthly clim
    final_result <- aemet_monthly_clim(
      station = station[1],
      verbose = verbose,
      extract_metadata = TRUE
    )
    return(final_result)
  }

  # Normal call
  # Cut by max 3 years, we use cuts of 3 years
  nr <- seq_along(station)

  db_cuts <- lapply(nr, function(x) {
    id <- station[x]

    curr <- as.integer(format(Sys.Date(), "%Y"))

    seq_d <- pmin(c(seq(end, start, by = -3), start, end), curr)
    seq_d <- sort(unique(seq_d))

    # Single year: repeat
    if (length(seq_d) == 1) {
      seq_d <- rep(seq_d, 2)
    }

    # Create final data.frame
    df_end <- data.frame(
      st = seq_d[-length(seq_d)],
      en = seq_d[-1]
    )
    df_end$id <- id

    df_end
  })

  db_cuts <- dplyr::bind_rows(db_cuts)
  db_cuts <- dplyr::distinct(db_cuts)
  # Done

  # Make calls on loop for progress bar
  # Prepare progress bar

  ln <- seq_len(nrow(db_cuts))

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
      total = nrow(db_cuts),
      clear = FALSE
    )
  }

  # nocov end
  # nolint end

  ### API Loop ----
  for (id in ln) {
    this <- db_cuts[id, ]
    apidest <- paste0(
      "/api/valores/climatologicos/mensualesanuales/datos",
      "/anioini/",
      this$st,
      "/aniofin/",
      this$en,
      "/estacion/",
      this$id
    )

    if (progress) {
      cli::cli_progress_update()
    } # nocov
    df <- get_data_aemet(apidest = apidest, verbose = verbose)

    df <- get_data_aemet(apidest = apidest, verbose = verbose)

    for (i in seq_len(9)) {
      patt <- paste0("-", i, "$")
      newpat <- paste0("-0", i)
      df$fecha <- gsub(patt, newpat, df$fecha)
    }

    df <- df[order(df$fecha), ]

    final_result <- c(final_result, list(df))

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

  # Final tweaks
  final_result <- dplyr::bind_rows(final_result)
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(final_result, "indicativo", dec_mark = ".")

  # Check spatial----
  if (return_sf) {
    # Coordinates from stations
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

#' @rdname aemet_monthly
#'
#' @export
aemet_monthly_period_all <- function(
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # Validate inputs----
  if (is.null(start)) {
    stop("Start year can't be missing")
  }

  if (is.null(end)) {
    stop("End year can't be missing")
  }

  if (!is.numeric(start)) {
    stop("Start year need to be numeric")
  }

  if (!is.numeric(end)) {
    stop("End year need to be numeric")
  }
  # The rest of parameters are validated on aemet_monthly_clim

  # Get stations----
  if (isTRUE(extract_metadata)) {
    stations <- data.frame(indicativo = default_station)
  } else {
    stations <- aemet_stations(verbose = verbose) # nocov
  }

  # nocov start
  all <- aemet_monthly_period(
    station = stations$indicativo,
    start = start,
    end = end,
    verbose = verbose,
    return_sf = return_sf,
    extract_metadata = extract_metadata,
    progress = progress
  )
  # nocov end

  all
}
