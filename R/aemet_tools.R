

#' Normal climatology values for a station
#'
#' Get normal climatology values for a station. Standard climatology from 1981 to 2010.
#'
#' @note Code modified from project https://github.com/SevillaR/aemet
#'
#' @inheritParams aemet_last_obs
#'
#' @return a tibble
#'
#' @examples
#' \dontrun{
#' aemet_normal_clim("9434", apikey)
#' }
#'
#' @export

aemet_normal_clim <- function(station, apikey) {
  if (missing(station)) {
    stop("Station can't be missing")
  }

  station <- as.character(station)

  apidest <- paste0("/api/valores/climatologicos/normales/estacion/", station)

  clim <- get_data_aemet(apidest, apikey)

  clim <- tibble::as_tibble(clim)
}

#' @title Monthly/annual climatology values for a station
#'
#' @description Get monthly/annual climatology values for a station.
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param year Numeric value as date (format: %Y).
#'
#' @return a data.frame.
#'
#' @importFrom methods missingArg
#'
#' @examples
#' \dontrun{
#' aemet_monthly_clim("9434", apikey, 2000)
#' }
#'
#' @export

aemet_monthly_clim <- function(station, apikey, year) {
  if (missingArg(station)) {
    stop("Station can't be missing")
  }

  if (missingArg(apikey)) {
    stop("API key can't be missing")
  }

  if (missingArg(year)) {
    stop("Year can't be missing")
  }

  if (!is.character(station)) {
    stop("Station need to be character string")
  }

  if (!is.character(apikey)) {
    stop("API key need to be character string")
  }

  if (!is.numeric(year)) {
    stop("Year need to be numeric")
  }

  apidest <- paste0("/api/valores/climatologicos/mensualesanuales/datos/anioini/", year, "/aniofin/", year, "/estacion/", station)

  clim <- get_data_aemet(apidest, apikey)
}

#' @title Extreme values for a station
#'
#' @description Get recorded extreme values for a station.
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param parameter Character string as temperature (T), precipitatation (P) or wind (W) parameter.
#'
#' @return a data.frame.
#'
#' @importFrom methods missingArg
#'
#' @examples
#' \dontrun{
#' aemet_extremes_clim("9434", apikey, "T")
#' }
#'
#' @export

aemet_extremes_clim <- function(station, apikey, parameter = c("T", "P", "V")) {
  if (missingArg(station)) {
    stop("Station can't be missing")
  }

  if (missingArg(apikey)) {
    stop("API key can't be missing")
  }

  if (missingArg(parameter)) {
    stop("Parameter can't be missing")
  }

  if (!is.character(station)) {
    stop("Station need to be character string")
  }

  if (!is.character(apikey)) {
    stop("API key need to be character string")
  }

  if (!is.character(parameter)) {
    stop("Parameter need to be character string")
  }

  apidest <- paste0("/api/valores/climatologicos/valoresextremos/parametro/", parameter, "/estacion/", station)

  clim <- as.data.frame(get_data_aemet(apidest, apikey))
}




#' @title Normal climatology values for all stations
#'
#' @description Get normal climatology values for all stations.
#'
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#'
#' @return a data.frame.
#'
#' @importFrom dplyr bind_rows
#' @importFrom methods missingArg
#'
#' @examples
#' \dontrun{
#' aemet_normal_clim_all(apikey)
#' }
#'
#' @export


aemet_normal_clim_all <- function(apikey) {
  if (missingArg(apikey)) {
    stop("API key can't be missing")
  }

  if (!is.character(apikey)) {
    stop("API key need to be character string")
  }

  stations <- aemet_stations(apikey)

  data_all <- data.frame()

  for (i in stations$indicativo) {
    tryCatch(
      {
        print(i)
        data <- aemet_normal_clim(i, apikey)
        df <- data.frame(data)
        data_all <- bind_rows(data_all, df)
      },
      error = function(e) {}
    )
  }

  return(data_all)
  gc()
}

#' @title Monthly climatology values of a station for a time period
#'
#' @description Get monthly climatology values for a period of years for a station.
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param start Numeric value as start year (format: %Y).
#' @param end a Numeric value as end year (format: %Y).
#'
#' @return a data.frame.
#'
#' @importFrom dplyr bind_rows
#' @importFrom methods missingArg
#'
#' @examples
#' \dontrun{
#' aemet_monthly_period("9434", apikey, 2000, 2010)
#' }
#'
#' @export


aemet_monthly_period <- function(station, apikey, start, end) {
  if (missingArg(station)) {
    stop("Station can't be missing")
  }

  if (missingArg(apikey)) {
    stop("API key can't be missing")
  }

  if (missingArg(start)) {
    stop("Start year can't be missing")
  }

  if (missingArg(end)) {
    stop("End year can't be missing")
  }

  if (!is.character(station)) {
    stop("Station need to be character string")
  }

  if (!is.character(apikey)) {
    stop("API key need to be character string")
  }

  if (!is.numeric(start)) {
    stop("Start year need to be numeric")
  }

  if (!is.numeric(end)) {
    stop("End year need to be numeric")
  }

  data_all <- data.frame()

  for (y in seq(start, end, by = 1)) {
    tryCatch(
      {
        year <- y
        print(year)
        data <- aemet_monthly_clim(station, apikey, year)
        df <- data.frame(data)
        data_all <- bind_rows(data_all, df)
      },
      error = function(e) {}
    )
  }

  return(data_all)
  gc()
}

#' @title Monthly climatology of all stations for a period of time
#'
#' @description Get monthly climatology values for a period of years for all stations.
#'
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param start Numeric value as start year (format: %Y).
#' @param end Numeric value as end year (format: %Y).
#'
#' @return a data.frame.
#'
#' @importFrom dplyr bind_rows
#' @importFrom methods missingArg
#'
#' @examples
#' \dontrun{
#' aemet_monthly_period_all(apikey, 2000, 2010)
#' }
#'
#' @export


aemet_monthly_period_all <- function(apikey, start, end) {
  if (missingArg(apikey)) {
    stop("API key can't be missing")
  }

  if (missingArg(start)) {
    stop("Start year can't be missing")
  }

  if (missingArg(end)) {
    stop("End year can't be missing")
  }

  if (!is.character(apikey)) {
    stop("API key need to be character string")
  }

  if (!is.numeric(start)) {
    stop("Start year need to be numeric")
  }

  if (!is.numeric(end)) {
    stop("End year need to be numeric")
  }

  stations <- aemet_stations(apikey)

  data_all <- data.frame()

  for (i in stations$indicativo) {
    print(i)

    tryCatch(
      {
        data <- aemet_monthly_period(station = i, apikey, start, end)
        df <- data.frame(data)
        data_all <- bind_rows(data_all, df)
      },
      error = function(e) {}
    )
  }

  return(data_all)
  gc()
}

## R CMD check: the .'s that appear in pipelines

if (getRversion() >= "2.15.1") utils::globalVariables(c("."))

#' @title First day of year
#'
#' @description Get first day of year.
#'
#' @param year Numeric value as year (format: %Y).
#'
#' @return Character string as date (format: %Y%m%d).
#'
#' @import dplyr
#' @import lubridate
#' @importFrom rlang .data
#' @importFrom methods missingArg
#'
#' @examples
#' \donttest{
#' first_day_of_year(2000)
#' }
#'
#' @export


first_day_of_year <- function(year) {
  if (missingArg(year)) {
    stop("Year can't be missing")
  }

  if (!is.numeric(year)) {
    stop("Year need to be numeric")
  }

  month <- 1

  date <- ymd(paste0(year, "-", month, "-1")) %>%
    ceiling_date(., "month") %>%
    {
      . - days(31)
    }

  date <- as.character(date)

  return(date)
}

#' @title Last day of year
#'
#' @description Get last day of year.
#'
#' @param year Numeric value as year (format: %Y).
#'
#' @return Character string as date (format: %Y%m%d).
#'
#' @import dplyr
#' @import lubridate
#' @importFrom rlang .data
#' @importFrom methods missingArg
#'
#' @examples
#' \donttest{
#' last_day_of_year(2000)
#' }
#'
#' @export


last_day_of_year <- function(year) {
  if (missingArg(year)) {
    stop("Year can't be missing")
  }

  if (!is.numeric(year)) {
    stop("Year need to be numeric")
  }

  month <- 12

  date <- ymd(paste0(year, "-", month, "-1")) %>%
    ceiling_date(., "month") %>%
    {
      . - days(1)
    }

  date <- as.character(date)

  return(date)
}
