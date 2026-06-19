# AEMET monthly climatology endpoints.

#' Monthly and annual climatology values
#'
#' @description
#' Retrieves monthly or annual climatology values for one or more stations.
#' `aemet_monthly_period()` and `aemet_monthly_period_all()` allow requests
#' that span several years.
#'
#' @rdname aemet_monthly
#' @name aemet_monthly
#'
#' @param station A character vector of station identifiers. See
#'   [aemet_stations()].
#'
#' @inheritParams aemet_last_obs
#' @inheritParams first_day_of_year
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @inherit aemet_last_obs return
#'
#' @family climatology
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' obs <- aemet_monthly_clim(station = c("9434", "3195"), year = 2000)
#' dplyr::glimpse(obs)
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
      "{.arg year} must be numeric, not {.obj_type_friendly {year}}."
    )
  }
  aemet_hlp_validate_logical(verbose, "verbose")
  aemet_hlp_validate_logical(return_sf, "return_sf")

  # Avoid errors in January because annual data is not yet available.
  today <- as.integer(format(Sys.Date() - 31, "%Y"))

  year <- min(year, today)
  # 2. Call the API ----

  ## Metadata ----
  if (extract_metadata) {
    apidest <- aemet_endpoint_monthly(year, year, station)
    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
    return(final_result)
  }

  ## Data request ----

  final_result <- aemet_hlp_fetch_loop(
    station,
    function(id) {
      apidest <- aemet_endpoint_monthly(year, year, id)
      df <- get_data_aemet(apidest = apidest, verbose = verbose)

      aemet_hlp_order_monthly(df)
    },
    progress,
    verbose
  )

  # Apply final tweaks.
  final_result <- aemet_hlp_finalize(
    final_result,
    "indicativo",
    dec_mark = "."
  )

  # Prepare spatial output ----
  if (return_sf) {
    final_result <- aemet_hlp_station_sf(final_result, verbose)
  }
  final_result
}

#' @rdname aemet_monthly
#'
#' @param start A numeric value specifying the start year in `YYYY` format.
#'
#' @param end A numeric value specifying the end year in `YYYY` format.
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

  aemet_hlp_check_year_range(start, end)

  # The remaining arguments are validated in `aemet_monthly_clim()`.

  final_result <- NULL
  # 2. Call the API ----

  ## Metadata ----
  if (extract_metadata) {
    # Use `aemet_monthly_clim()` for metadata.
    final_result <- aemet_monthly_clim(
      station = station[1],
      verbose = verbose,
      extract_metadata = TRUE
    )
    return(final_result)
  }

  # Request data.
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
  # Prepare monthly climatology downloads.

  ln <- seq_len(nrow(db_cuts))

  final_result <- aemet_hlp_fetch_loop(
    ln,
    function(id) {
      this <- db_cuts[id, ]
      apidest <- aemet_endpoint_monthly(this$st, this$en, this$id)
      df <- get_data_aemet(apidest = apidest, verbose = verbose)

      aemet_hlp_order_monthly(df)
    },
    progress,
    verbose
  )

  # Apply final tweaks.
  final_result <- aemet_hlp_finalize(
    final_result,
    "indicativo",
    dec_mark = "."
  )

  # Prepare spatial output ----
  if (return_sf) {
    final_result <- aemet_hlp_station_sf(final_result, verbose)
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
  aemet_hlp_check_year_range(start, end)
  # The remaining arguments are validated in `aemet_monthly_clim()`.

  # Get stations ----
  if (isTRUE(extract_metadata)) {
    stations <- data.frame(indicativo = default_station)
  } else {
    stations <- aemet_stations(verbose = verbose) # nocov
  }

  all <- aemet_monthly_period(
    station = stations$indicativo,
    start = start,
    end = end,
    verbose = verbose,
    return_sf = return_sf,
    extract_metadata = extract_metadata,
    progress = progress
  )

  all
}
