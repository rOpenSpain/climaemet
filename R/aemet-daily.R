# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' Daily/annual climatology values
#'
#' @description
#' Get climatology values for a station or for all the available stations.
#' Note that `aemet_daily_period()` and `aemet_daily_period_all()` are shortcuts
#' of `aemet_daily_clim()`.
#'
#' @rdname aemet_daily
#' @name aemet_daily_clim
#'
#' @family aemet_api_data
#'
#' @param start,end Character strings with start and end dates. See
#'   **Details**.
#'
#' @inheritParams aemet_last_obs
#' @inherit aemet_last_obs return
#'
#' @details
#' `start` and `end` arguments must be:
#' - For `aemet_daily_clim()`: A `Date` object or a string with format
#'   `YYYY-MM-DD` (`"2020-12-31"`) coercible with [as.Date()].
#' - For `aemet_daily_period()` and `aemet_daily_period_all()`: A string
#'   representing the year(s) to be extracted: `"2020"`, `"2018"`.
#'
#' # API key
#' You need to set your API key globally using [aemet_api_key()].
#' Query timeout can be controlled with
#' `options(climaemet_timeout = 60)` (default value). See
#' [httr2::req_timeout()] for details.
#'
#' @seealso [aemet_api_key()], [as.Date()]
#' @examplesIf aemet_detect_api_key()
#'
#' library(tibble)
#' obs <- aemet_daily_clim(c("9434", "3195"))
#' glimpse(obs)
#'
#' # Metadata
#' meta <- aemet_daily_clim(c("9434", "3195"), extract_metadata = TRUE)
#'
#' glimpse(meta$campos)
#'
#' @export
#' @encoding UTF-8
aemet_daily_clim <- function(
  station = "all",
  start = Sys.Date() - 7,
  end = Sys.Date(),
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

  # Use a simplified request for metadata.
  if (isTRUE(extract_metadata)) {
    station <- default_station
    start <- Sys.Date() - 7
    end <- Sys.Date()
  }

  start_conv <- min(Sys.Date(), as.Date(start))
  end_conv <- min(Sys.Date(), as.Date(end))
  aemet_hlp_validate_logical(return_sf, "return_sf")
  aemet_hlp_validate_logical(verbose, "verbose")

  # 2. Call API ----

  ## Metadata ----
  if (extract_metadata) {
    apidest <- aemet_endpoint_daily(
      paste0(start_conv, "T00:00:00UTC"),
      paste0(end_conv, "T23:59:59UTC"),
      station
    )

    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
    return(final_result)
  }

  ## Normal call ----

  # Extract data by creating a master table.
  # Select the "all" endpoint when any station is "all".
  station <- aemet_hlp_match_all(station)

  # Create a data frame with request intervals.

  # Split requests into intervals of up to 5 months.
  # Use 15-day intervals for the "all" endpoint.
  nr <- seq_along(station)

  db_cuts <- lapply(nr, function(x) {
    id <- station[x]
    int <- switch(id,
      "all" = "-14 days",
      "-5 months"
    )

    seq_d <- unique(c(start_conv, seq(end_conv, start_conv, int), end_conv))
    seq_d <- sort(pmin(Sys.Date(), seq_d))
    # Repeat single-day intervals.
    if (length(seq_d) == 1) {
      seq_d <- rep(seq_d, 2)
    }

    # Create the final data frame.
    df_end <- data.frame(st = seq_d[-length(seq_d)], en = seq_d[-1])
    df_end$id <- id
    df_end$st <- paste0(df_end$st, "T00:00:00UTC")
    df_end$en <- paste0(df_end$en, "T23:59:59UTC")

    df_end
  })

  db_cuts <- dplyr::bind_rows(db_cuts)
  # Prepare daily climatology downloads.

  ln <- seq_len(nrow(db_cuts))

  final_result <- aemet_hlp_fetch_loop(
    ln,
    function(id) {
      this <- db_cuts[id, ]
      apidest <- aemet_endpoint_daily(this$st, this$en, this$id)
      get_data_aemet(apidest = apidest, verbose = verbose)
    },
    progress,
    verbose
  )

  # Apply final tweaks.
  final_result <- aemet_hlp_finalize(final_result, "indicativo")

  # Check spatial output ----
  if (return_sf) {
    final_result <- aemet_hlp_station_sf(final_result, verbose)
  }

  final_result
}

#' @rdname aemet_daily
#' @name aemet_daily
#' @export
#' @encoding UTF-8
aemet_daily_period <- function(
  station,
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # Validate inputs ----
  aemet_hlp_check_year_range(start, end)

  # Other inputs are validated in aemet_daily_clim().
  fdoy <- paste0(start, "-01-01")
  ldoy <- paste0(end, "-12-31")

  # Call API through aemet_daily_clim().
  final_result <- aemet_daily_clim(
    station,
    fdoy,
    ldoy,
    verbose,
    return_sf,
    extract_metadata = extract_metadata,
    progress = progress
  )

  final_result
}

#' @rdname aemet_daily
#' @name aemet_daily
#' @export
#' @encoding UTF-8
aemet_daily_period_all <- function(
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # Validate inputs ----
  aemet_hlp_check_year_range(start, end)

  # The rest of the arguments are validated in aemet_daily_clim().

  # nocov start
  # Do not test this because it would exhaust the API quota.
  fdoy <- paste0(start, "-01-01")
  ldoy <- paste0(end, "-12-31")
  # Call API through aemet_daily_clim().
  data_all <- aemet_daily_clim(
    "all",
    fdoy,
    ldoy,
    verbose,
    return_sf,
    extract_metadata = extract_metadata,
    progress = progress
  )

  data_all
  # nocov end
}
