# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' Monthly/annual climatology
#'
#' @description
#' Get monthly/annual climatology values for a station or all the stations.
#' `aemet_monthly_period()` and `aemet_monthly_period_all()` allow requests
#' that span several years.
#'
#' @rdname aemet_monthly
#' @name aemet_monthly
#'
#' @family aemet_api_data
#'
#' @param station Character string with station identifier code(s).
#'   (see [aemet_stations()]).
#'
#' @param year Numeric value as date (format: `YYYY`).
#'
#' @inheritParams aemet_last_obs
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @return A [tibble][tibble::tbl_df] or a \CRANpkg{sf} object.
#'
#' @examplesIf aemet_detect_api_key()
#'
#' library(tibble)
#' obs <- aemet_monthly_clim(station = c("9434", "3195"), year = 2000)
#' glimpse(obs)
#' @export
#' @encoding UTF-8
aemet_monthly_clim <- function(
  station = NULL,
  year = as.integer(format(Sys.Date(), "%Y")),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs ----
  if (is.null(station)) {
    cli::cli_abort("{.arg station} cannot be {.obj_type_friendly {station}}.")
  }
  station <- as.character(station)
  if (isTRUE(extract_metadata)) {
    station <- default_station
  }

  if (!is.numeric(year)) {
    cli::cli_abort(
      "{.arg year} needs to be numeric, not {.obj_type_friendly {year}}."
    )
  }
  stopifnot(is.logical(verbose))
  stopifnot(is.logical(return_sf))

  # Avoid errors in January because annual data is not yet available.
  today <- as.integer(format(Sys.Date() - 31, "%Y"))

  year <- min(year, today)
  # 2. Call API ----

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

  # Make calls in a loop for the progress bar.
  final_result <- list() # Store results

  # Deactivate the progress bar when verbose output is enabled.
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
      cli::cli_progress_update() # nocov
    }
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

  # Check spatial output ----
  if (return_sf) {
    # Get coordinates from stations.
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
#' @encoding UTF-8
aemet_monthly_period <- function(
  station = NULL,
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs ----
  if (is.null(station)) {
    cli::cli_abort("{.arg station} cannot be {.obj_type_friendly {station}}.")
  }

  if (!is.numeric(start)) {
    cli::cli_abort(
      "{.arg start} needs to be numeric, not {.obj_type_friendly {start}}."
    )
  }

  if (!is.numeric(end)) {
    cli::cli_abort(
      "{.arg end} needs to be numeric, not {.obj_type_friendly {end}}."
    )
  }

  # The rest of the arguments are validated in aemet_monthly_clim().

  final_result <- NULL
  # 2. Call API ----

  ## Metadata ----
  if (extract_metadata) {
    # Use aemet_monthly_clim() for metadata.
    final_result <- aemet_monthly_clim(
      station = station[1],
      verbose = verbose,
      extract_metadata = TRUE
    )
    return(final_result)
  }

  # Normal call.
  # Split requests into intervals of up to 3 years.
  nr <- seq_along(station)

  db_cuts <- lapply(nr, function(x) {
    id <- station[x]

    # Avoid errors in January.
    curr <- as.integer(format(Sys.Date() - 31, "%Y"))

    seq_d <- pmin(c(seq(end, start, by = -3), start, end), curr)
    seq_d <- sort(unique(seq_d))

    # Repeat single-year intervals.
    if (length(seq_d) == 1) {
      seq_d <- rep(seq_d, 2)
    }

    # Create the final data frame.
    df_end <- data.frame(st = seq_d[-length(seq_d)], en = seq_d[-1])
    df_end$id <- id

    df_end
  })

  db_cuts <- dplyr::bind_rows(db_cuts)
  db_cuts <- dplyr::distinct(db_cuts)
  # Done

  # Make calls in a loop for the progress bar.
  # Prepare progress bar

  ln <- seq_len(nrow(db_cuts))

  # Deactivate the progress bar when verbose output is enabled.
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

  ### API loop ----
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
      cli::cli_progress_update() # nocov
    }
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

  # Check spatial output ----
  if (return_sf) {
    # Get coordinates from stations.
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
#' @encoding UTF-8
aemet_monthly_period_all <- function(
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # Validate inputs ----
  if (is.null(start)) {
    cli::cli_abort("{.arg start} cannot be {.obj_type_friendly {start}}.")
  }

  if (is.null(end)) {
    cli::cli_abort("{.arg end} cannot be {.obj_type_friendly {end}}.")
  }

  if (!is.numeric(start)) {
    cli::cli_abort(
      "{.arg start} needs to be numeric, not {.obj_type_friendly {start}}."
    )
  }

  if (!is.numeric(end)) {
    cli::cli_abort(
      "{.arg end} needs to be numeric, not {.obj_type_friendly {end}}."
    )
  }
  # The rest of the arguments are validated in aemet_monthly_clim().

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
