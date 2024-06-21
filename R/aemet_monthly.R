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
aemet_monthly_clim <- function(station = NULL,
                               year = as.integer(format(Sys.Date(), "%Y")),
                               verbose = FALSE,
                               return_sf = FALSE, extract_metadata = FALSE) {
  # Validate inputs----
  if (is.null(station)) {
    stop("Station can't be missing")
  }
  station <- as.character(station)
  if (isTRUE(extract_metadata)) station <- station[1]

  if (!is.numeric(year)) {
    stop("Year need to be numeric")
  }
  stopifnot(is.logical(verbose))
  stopifnot(is.logical(return_sf))

  # Call API----
  # Vectorize function
  final_result <- NULL

  for (i in seq_len(length(station))) {
    apidest <-
      paste0(
        "/api/valores/climatologicos/mensualesanuales/datos/anioini/",
        year,
        "/aniofin/",
        year,
        "/estacion/",
        station[i]
      )

    if (isTRUE(extract_metadata)) {
      final_result <- get_metadata_aemet(
        apidest = apidest,
        verbose = verbose
      )
    } else {
      final_result <-
        dplyr::bind_rows(final_result, get_data_aemet(apidest, verbose))
    }
  }

  final_result <- dplyr::distinct(final_result)
  if (isTRUE(extract_metadata)) {
    return(final_result)
  }

  # Guess formats
  final_result <-
    aemet_hlp_guess(final_result, "indicativo", dec_mark = ".")
  # Check spatial----
  if (return_sf) {
    # Coordinates from stations
    sf_stations <-
      aemet_stations(verbose, return_sf = FALSE)
    sf_stations <-
      sf_stations[c("indicativo", "latitud", "longitud")]

    final_result <-
      dplyr::left_join(final_result, sf_stations, by = "indicativo")
    final_result <-
      aemet_hlp_sf(final_result, "latitud", "longitud", verbose)
  }

  return(final_result)
}

#' @rdname aemet_monthly
#'
#' @param start Numeric value as start year (format: `YYYY`).
#'
#' @param end Numeric value as end year (format: `YYYY`).
#'
#' @export
aemet_monthly_period <- function(station = NULL,
                                 start = as.integer(
                                   format(Sys.Date(), "%Y")
                                 ),
                                 end = start, verbose = FALSE,
                                 return_sf = FALSE, extract_metadata = FALSE) {
  # Validate inputs----
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
  # Call API----
  # via aemet_monthly_clim
  for (y in seq(start, end, by = 1)) {
    this_y <- aemet_monthly_clim(
      station = station,
      year = y,
      verbose = verbose,
      return_sf = FALSE,
      extract_metadata = extract_metadata
    )

    final_result <- dplyr::bind_rows(final_result, this_y)
  }
  if (isTRUE(extract_metadata)) {
    return(final_result)
  }

  # Check spatial----
  if (return_sf) {
    # Coordinates from stations
    sf_stations <-
      aemet_stations(verbose, return_sf = FALSE)
    sf_stations <-
      sf_stations[c("indicativo", "latitud", "longitud")]

    final_result <-
      dplyr::left_join(final_result, sf_stations, by = "indicativo")
    final_result <-
      aemet_hlp_sf(final_result, "latitud", "longitud", verbose)
  }

  return(final_result)
}

#' @rdname aemet_monthly
#'
#' @export
aemet_monthly_period_all <- function(
    start = as.integer(format(Sys.Date(), "%Y")),
    end = start,
    verbose = FALSE, return_sf = FALSE,
    extract_metadata = FALSE) {
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
    stations <- aemet_stations(verbose = verbose)
  }
  if (verbose) {
    message("Requesting ", nrow(stations), " stations")
  }
  final_result <- NULL

  for (i in stations$indicativo) {
    if (verbose) {
      message("Station: ", i)
    }

    data_recover <- aemet_monthly_period(
      station = i,
      start = start,
      end = end,
      verbose = verbose,
      return_sf = FALSE,
      extract_metadata = extract_metadata
    )
    final_result <- dplyr::bind_rows(final_result, data_recover)
  }
  if (isTRUE(extract_metadata)) {
    return(final_result)
  }
  # Check spatial----
  if (return_sf) {
    # Coordinates from stations
    sf_stations <-
      aemet_stations(verbose, return_sf = FALSE)
    sf_stations <-
      sf_stations[c("indicativo", "latitud", "longitud")]

    final_result <-
      dplyr::left_join(final_result, sf_stations, by = "indicativo")
    final_result <-
      aemet_hlp_sf(final_result, "latitud", "longitud", verbose)
  }

  return(final_result)
}
