##############################################################################
# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/
##############################################################################

#' Daily/annual climatology values for a station
#'
#' Get daily climatology values for a station for a maximum period of one year.
#'
#' @concept aemet_valores
#'
#' @param start Character string as start date (format: %Y%m%d).
#'
#' @param end Character string as end date (format: %Y%m%d).
#'
#' @inheritParams aemet_last_obs
#'
#' @return a tibble
#'
#' @note
#' The API has some limits on large periods (31 days for "all" and
#' one year for individual stations). For larger period consider use
#' [aemet_daily_period()]/[aemet_daily_period_all()], that are optimized for
#' batch downloading.
#'
#' @seealso [aemet_daily_period()], [aemet_daily_period_all()]
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#' apikey <- Sys.getenv("AEMET_API_KEY")
#' if (apikey != "") {
#'   library(tibble)
#'   obs <- aemet_daily_clim("9434", apikey, "2021-01-07", "2021-01-10")
#'   glimpse(obs)
#' }
#' @export
aemet_daily_clim <-
  function(station = "all",
           apikey = NULL,
           start = Sys.Date() - lubridate::days(7),
           end = Sys.Date(),
           verbose = FALSE) {
    if (is.na(station) || is.null(station)) {
      stop("Station can't be missing")
    }
    station <- as.character(station)

    start_conv <- lubridate::as_datetime(start)
    end_conv <- lubridate::as_datetime(end)

    if (is.na(start_conv) || is.na(end_conv)) {
      stop("Error parsing start/end dates.Use YYYY-MM-DD format")
    }

    # Format dates

    start_api <- as.character(format(start_conv, "%Y-%m-%d"))
    end_api <- as.character(format(end_conv, "%Y-%m-%d"))

    apidest <-
      paste0(
        "/api/valores/climatologicos/diarios/datos/fechaini/",
        start_api,
        "T00:00:00UTC/fechafin/",
        end_api,
        "T23:59:59UTC/"
      )
    if ("all" %in% tolower(station)) {
      apidest <- paste0(apidest, "todasestaciones")

      final_result <- get_data_aemet(apidest, apikey, verbose)
    } else {
      # Vectorize function
      final_result <- NULL

      for (i in seq_len(length(station))) {
        apidest_est <-
          paste0(
            apidest,
            "estacion/",
            station[i]
          )

        final_result <-
          dplyr::bind_rows(
            final_result,
            get_data_aemet(apidest_est, apikey, verbose)
          )
      }
    }

    # Reorder columns
    if ("apidest_error" %in% names(final_result)) {
      final_result <-
        dplyr::bind_cols(
          final_result[!names(final_result) %in% c("apidest_error", "error_message")],
          final_result[c("apidest_error", "error_message")]
        )
    }

    # Format dates
    if ("fecha" %in% names(final_result)) {
      final_result["fecha"] <-
        lubridate::as_date(final_result$fecha)
    }

    final_result <- aemet_hlp_guess(final_result, "indicativo")

    return(final_result)
  }


#' Daily climatology values of a station for a time period
#'
#' @description
#' Get daily climatology values for a period of years for a station.
#'
#' @concept aemet_valores
#'
#' @param station Character string as station identifier code
#'   (see [aemet_stations()]).
#'
#' @param start Numeric value as start year (format: %Y).
#'
#' @param end Numeric value as end year (format: %Y).
#'
#' @inheritParams aemet_daily_clim
#'
#' @seealso [aemet_daily_clim()]
#'
#' @return a tibble
#'
#' @examples
#' \dontrun{
#' aemet_daily_period("9434", apikey, 2000, 2010)
#' }
#'
#' @export

aemet_daily_period <-
  function(station,
           apikey = NULL,
           start = 2020,
           end = 2020,
           verbose = FALSE) {
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

    data_all <- NULL

    for (y in seq(start, end, by = 1)) {
      year <- y
      if (verbose) {
        message("Downloading year ", year)
      }

      fdoy <- paste0(year, "-01-01")
      ldoy <- paste0(year, "-12-31")

      data <- aemet_daily_clim(station, apikey, fdoy, ldoy, verbose)
      data_all <- bind_rows(data_all, data)
    }

    return(data_all)
  }

#' Daily climatology values of all stations for a time period
#'
#' Get daily climatology values for a period of years for all stations.
#'
#' @concept aemet_valores
#'
#' @inheritParams aemet_daily_period
#'
#' @seealso [aemet_daily_clim()]
#'
#' @return a tibble
#'
#' @examples
#' \dontrun{
#' aemet_daily_period_all(apikey, 2000, 2010)
#' }
#'
#' @export

aemet_daily_period_all <-
  function(apikey = NULL,
           start = 2020,
           end = 2020,
           verbose = FALSE) {
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

    data_all <- NULL

    fdoy <- lubridate::as_date(paste0(start, "-01-01"))
    ldoy <- lubridate::as_date(paste0(end, "-12-31"))

    init <- fdoy
    ldom <- init

    while (ldom < ldoy) {
      fdom <- lubridate::floor_date(init, "month")
      ldom <- lubridate::ceiling_date(fdom, "month") - days(1)
      if (verbose) {
        message("Downloading from ", fdom, " until ", ldom)
      }

      data <-
        aemet_daily_clim(station = "all", apikey, fdom, ldom, verbose)
      data_all <- bind_rows(data_all, data)

      init <- ldom + days(1)
    }

    data_all <- dplyr::distinct(data_all)

    return(data_all)
  }


#' AEMET stations
#'
#' Get AEMET stations.
#'
#' @concept aemet_valores
#'
#' @note Code modified from project <https://github.com/SevillaR/aemet>
#'
#' @inheritParams aemet_daily_clim
#'
#' @return A tibble
#'
#'
#' @examples
#' # Run this example only if AEMET_API_KEY is set
#' apikey <- Sys.getenv("AEMET_API_KEY")
#' if (apikey != "") {
#'   library(tibble)
#'   stations <- aemet_stations(apikey)
#'   glimpse(stations)
#' }
#' @export

aemet_stations <- function(apikey = NULL, verbose = FALSE) {
  stations <-
    get_data_aemet(apidest = "/api/valores/climatologicos/inventarioestaciones/todasestaciones", apikey, verbose = verbose)

  stations$longitud <- dms2decdegrees(stations$longitud)
  stations$latitud <- dms2decdegrees(stations$latitud)

  df <- stations[c(
    "indicativo",
    "indsinop",
    "nombre",
    "provincia",
    "altitud",
    "longitud",
    "latitud"
  )]

  df <- aemet_hlp_guess(df, c(
    "indicativo",
    "indsinop"
  ))

  return(df)
}
