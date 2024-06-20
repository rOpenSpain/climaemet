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
#' @param start,end  Character string with start and end date. See **Details**.
#'
#' @inheritParams aemet_last_obs
#'
#' @details
#' `start` and `end` parameters should be:
#' - For `aemet_daily_clim()`: A `Date` object or a string with format:
#'   YYYY-MM-DD (2020-12-31) coercible with [as.Date()].
#' - For `aemet_daily_period()` and `aemet_daily_period_all()`: A string
#'   representing the year(s) to be extracted: "2020", "2018".
#'
#' # API Key
#' You need to set your API Key globally using [aemet_api_key()].
#'
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object
#'
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
#' @seealso [aemet_api_key()], [as.Date()]
#' @export
aemet_daily_clim <- function(station = "all", start = Sys.Date() - 7,
                             end = Sys.Date(), verbose = FALSE,
                             return_sf = FALSE, extract_metadata = FALSE,
                             progress = TRUE) {
  # Validate inputs----
  if (is.null(station)) {
    stop("Station can't be missing")
  }
  station <- as.character(station)

  # For metadata make simplified version
  if (isTRUE(extract_metadata)) {
    station <- default_station
    start <- Sys.Date() - 7
    end <- Sys.Date()
  }

  start_conv <- min(Sys.Date(), as.Date(start))
  end_conv <- min(Sys.Date(), as.Date(end))

  if (is.na(start_conv) || is.na(end_conv)) {
    stop("Error parsing start/end dates.Use YYYY-MM-DD format")
  }
  stopifnot(is.logical(return_sf))
  stopifnot(is.logical(verbose))

  # Call API----

  # Metadata
  if (extract_metadata) {
    apidest <- paste0(
      "/api/valores/climatologicos/diarios/datos/fechaini/",
      start_conv, "T00:00:00UTC/fechafin/", end_conv,
      "T23:59:59UTC/estacion/", station
    )

    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
    return(final_result)
  }

  # Extract data creating a master table
  # In all select API endpoint all
  if (any(station == "all")) station <- "all"

  # Create data frame with cuts

  # Cut by time, max 6 months, we use cuts of 5 months
  # except in all, that is 15 days
  nr <- seq_len(length(station))


  db_cuts <- lapply(nr, function(x) {
    id <- station[x]
    int <- switch(id,
      "all" = "-14 days",
      "-5 months"
    )

    seq_d <- unique(c(start_conv, seq(end_conv, start_conv, int), end_conv))
    seq_d <- sort(pmin(Sys.Date(), seq_d))
    # Single day: repeat
    if (length(seq_d) == 1) seq_d <- rep(seq_d, 2)

    # Create final data.frame
    df_end <- data.frame(
      st = seq_d[-length(seq_d)],
      en = seq_d[-1]
    )
    df_end$id <- id
    df_end$st <- paste0(df_end$st, "T00:00:00UTC")
    df_end$en <- paste0(df_end$en, "T23:59:59UTC")

    df_end
  })


  db_cuts <- dplyr::bind_rows(db_cuts)


  # Make calls on loop for progress bar
  ln <- seq_len(nrow(db_cuts))
  final_result <- list()

  # Deactive progressbar if verbose
  if (verbose) progress <- FALSE
  if (!cli::is_dynamic_tty()) progress <- FALSE

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
      total = nrow(db_cuts), clear = FALSE
    )
  }


  for (id in ln) {
    this <- db_cuts[id, ]
    apidest <- paste0(
      "/api/valores/climatologicos/diarios/datos/fechaini/",
      this$st, "/fechafin/", this$en
    )
    if (this$id == "all") {
      apidest <- paste0(apidest, "/todasestaciones")
    } else {
      apidest <- paste0(apidest, "/estacion/", this$id)
    }
    if (progress) cli::cli_progress_update()
    df <- get_data_aemet(apidest = apidest, verbose = verbose)

    final_result <- c(final_result, list(df))
  }

  if (progress) {
    cli::cli_progress_done()
    options(
      cli.progress_bar_style = opts$cli.progress_bar_style,
      cli.progress_show_after = opts$cli.progress_show_after,
      cli.spinner = opts$cli.spinner
    )
  }

  final_result <- dplyr::bind_rows(final_result)
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(final_result, "indicativo")

  # Check spatial----
  if (return_sf) {
    # Coordinates from statios
    sf_stations <-
      aemet_stations(verbose = verbose, return_sf = FALSE)
    sf_stations <- sf_stations[c("indicativo", "latitud", "longitud")]

    final_result <- dplyr::left_join(final_result, sf_stations,
      by = "indicativo"
    )
    final_result <- aemet_hlp_sf(final_result, "latitud", "longitud", verbose)
  }

  return(final_result)
}


#' @rdname aemet_daily
#' @name aemet_daily
#' @export
aemet_daily_period <- function(station,
                               start = as.integer(format(Sys.Date(), "%Y")),
                               end = start,
                               verbose = FALSE, return_sf = FALSE,
                               extract_metadata = FALSE,
                               progress = TRUE) {
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

  # Other inputs are validated in aemet_daily_clim
  fdoy <- paste0(start, "-01-01")
  ldoy <- paste0(end, "-12-31")

  # Call API----
  # Via daily clim
  final_result <- aemet_daily_clim(station, fdoy, ldoy, verbose, return_sf,
    extract_metadata = extract_metadata, progress = progress
  )

  return(final_result)
}


#' @rdname aemet_daily
#' @name aemet_daily
#' @export
aemet_daily_period_all <- function(start = as.integer(format(Sys.Date(), "%Y")),
                                   end = start, verbose = FALSE,
                                   return_sf = FALSE,
                                   extract_metadata = FALSE,
                                   progress = TRUE) {
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
  # Rest of parameters validated in aemet_daily_clim

  fdoy <- paste0(start, "-01-01")
  ldoy <- paste0(end, "-12-31")
  # Call API----
  # via aemet_daily_clim
  data_all <- aemet_daily_clim("all", fdoy, ldoy, verbose, return_sf,
    extract_metadata = extract_metadata, progress = progress
  )

  return(data_all)
}
