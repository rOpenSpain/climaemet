################################################################################################################
# Author: Manuel Pizarro <m.pizarro@csic.es>
# Ecosystem Conservation, IPE (CSIC) <http://www.ipe.csic.es/conservacion-bio/>
# Version: 0.2.0
################################################################################################################

#' @title Last observation values for a station
#'
#' @description Get last observation values for a station.
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#'
#' @return a data.frame.
#'
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' aemet_last_obs("9434", apikey)
#' }
#'
#' @export

aemet_last_obs <- function(station, apikey) {

  if (missingArg(station))
    stop("Station can't be missing")

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (!is.character(station))
    stop("Station need to be character string")

  if (!is.character(apikey))
    stop("API key need to be character string")

  apidest <- paste0("/api/observacion/convencional/datos/estacion/", station)

  clim <- get_data_aemet(apidest, apikey)

}

#' @title Normal climatology values for a station
#'
#' @description Get normal climatology values for a station. Standard climatology from 1981 to 2010.
#'
#' @note Code modified from project https://github.com/SevillaR/aemet
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#'
#' @return a data.frame.
#'
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' aemet_normal_clim("9434", apikey)
#' }
#'
#' @export

aemet_normal_clim <- function(station, apikey) {

  if (missingArg(station))
    stop("Station can't be missing")

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (!is.character(station))
    stop("Station need to be character string")

  if (!is.character(apikey))
    stop("API key need to be character string")

  apidest <- paste0("/api/valores/climatologicos/normales/estacion/", station)

  clim <- get_data_aemet(apidest, apikey)

}

#' @title Daily/annual climatology values for a station
#'
#' @description Get daily climatology values for a station for a maximum period of one year.
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param start Character string as start date (format: %Y%m%d).
#' @param end Character string as end date (format: %Y%m%d).
#'
#' @return a data.frame.
#'
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' aemet_daily_clim("9434", apikey, "2000-01-01", "2000-12-31")
#' }
#'
#' @export

aemet_daily_clim <- function(station, apikey, start, end) {

  if (missingArg(station))
    stop("Station can't be missing")

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (missingArg(start))
    stop("Start year can't be missing")

  if (missingArg(end))
    stop("End year can't be missing")

  if (!is.character(station))
    stop("Station need to be character string")

  if (!is.character(apikey))
    stop("API key need to be character string")

  if (!is.character(start))
    stop("Start year need to be character string")

  if (!is.character(end))
    stop("End year need to be character string")

  apidest <- paste0("/api/valores/climatologicos/diarios/datos/fechaini/", start, "T00:00:00UTC/fechafin/", end, "T23:59:59UTC/estacion/", station)

  clim <- get_data_aemet(apidest, apikey)

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
#' @examples \dontrun{
#' aemet_monthly_clim("9434", apikey, 2000)
#' }
#'
#' @export

aemet_monthly_clim <- function(station, apikey, year) {

  if (missingArg(station))
    stop("Station can't be missing")

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (missingArg(year))
    stop("Year can't be missing")

  if (!is.character(station))
    stop("Station need to be character string")

  if (!is.character(apikey))
    stop("API key need to be character string")

  if (!is.numeric(year))
    stop("Year need to be numeric")

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
#' @examples \dontrun{
#' aemet_extremes_clim("9434", apikey, "T")
#' }
#'
#' @export

aemet_extremes_clim <- function(station, apikey, parameter = c("T", "P", "V")) {

  if (missingArg(station))
    stop("Station can't be missing")

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (missingArg(parameter))
    stop("Parameter can't be missing")

  if (!is.character(station))
    stop("Station need to be character string")

  if (!is.character(apikey))
    stop("API key need to be character string")

  if (!is.character(parameter))
    stop("Parameter need to be character string")

  apidest <- paste0("/api/valores/climatologicos/valoresextremos/parametro/", parameter, "/estacion/", station)

  clim <- as.data.frame(get_data_aemet(apidest, apikey))

}

#' @title AEMET stations
#'
#' @description Get AEMET stations.
#'
#' @note Code modified from project https://github.com/SevillaR/aemet
#'
#' @param apikey Character string as API key (https://opendata.aemet.es/centrodedescargas/obtencionAPIKey).
#'
#' @return a data.frame.
#'
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' stations <- aemet_stations(apikey)
#' }
#'
#' @export

aemet_stations <- function(apikey) {

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (!is.character(apikey))
    stop("API key need to be character string")

  stations <- get_data_aemet(apidest = "/api/valores/climatologicos/inventarioestaciones/todasestaciones", apikey)

  stations$longitud <- Vectorize(dms2decdegrees)(stations$longitud)
  stations$latitud <- Vectorize(dms2decdegrees)(stations$latitud)

  df <- stations[, c("indicativo", "indsinop", "nombre", "provincia", "altitud",
                     "longitud", "latitud")]

  return(df)

}

#' @title Client tool for AEMET API
#'
#' @description Client tool to get data from AEMET and convert json to data.frame.
#'
#' @note Code modified from project https://github.com/vegmod/meteoland
#'
#' @param apidest Character string as destination URL. See \url{https://opendata.aemet.es/dist/index.html}.
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param verbose True/False. Provides information about the flow of
#' information between the client and server
#'
#' @return a data.frame.
#'
#' @import httr
#' @importFrom jsonlite fromJSON
#' @importFrom methods missingArg
#'
#' @export


get_data_aemet <- function(apidest, apikey, verbose = FALSE) {

  url.base <- "https://opendata.aemet.es/opendata"

  url1 <- paste0(url.base, apidest)

  path1 <- httr::GET(url1, add_headers(api_key = apikey))

  urls.text <- httr::content(path1, as = "text")

  if(is.na(urls.text)) {

    cat("\n  The number of downloads per minute on the AEMET server is limited. Please wait.")
    for(t in 1:10){(Sys.sleep(6));cat(".");if(t == 10)cat("\n")}
    path1 <- httr::GET(url1, add_headers(api_key = apikey))
    urls.text <- httr::content(path1, as = "text")
  }

  urls <- jsonlite::fromJSON(urls.text)

  if(verbose) print(urls)

  if (urls$estado==401) {

    stop("Invalid API key. (API keys are valid for 3 months.)")

  } else if (urls$estado==404) { #"There is no data that meets those criteria"

    return(NULL)

  } else if (urls$estado==429) {

    cat("\n  The number of downloads per minute on the AEMET server is limited. Please wait.")
    for(t in 1:10){(Sys.sleep(6));cat(".");if(t == 10)cat("\n")}
    path1 <- httr::GET(url1, add_headers(api_key = apikey))
    urls.text <- httr::content(path1, as = "text")
    urls <- jsonlite::fromJSON(urls.text)
  }

  if(urls$estado==200) {

    path2 <- httr::GET(urls$datos)
    data.json <- httr::content(path2, as = "text")

    if(is.na(data.json)) {

      cat("\n  The number of downloads per minute on the AEMET server is limited. Please wait.")
      for(t in 1:10){(Sys.sleep(6));cat(".");if(t == 10)cat("\n")}
      path2 <- httr::GET(urls$datos)
      data.json <- httr::content(path2, as = "text")
    }
    datos <- jsonlite::fromJSON(data.json)

    return(datos)
  }
}

#' @title Converts dms to decimal degrees
#'
#' @description Converts degrees, minutes and seconds to decimal degrees.
#'
#' @note Code modified from project https://github.com/SevillaR/aemet
#'
#' @param input Character string as DMS coordinates.
#'
#' @return a numeric value.
#'
#' @importFrom methods missingArg
#'
#' @examples \donttest{
#' dms2decdegrees("055245W")
#' }
#'
#' @export

dms2decdegrees <- function(input) {

  if (missingArg(input))
    stop("Input can't be missing")

  if (!is.character(input))
    stop("Input need to be character string")

  deg <- as.numeric(substr(input, 0, 2))
  min <- as.numeric(substr(input, 3,4))
  sec <- as.numeric(substr(input, 5,6))
  x <- deg + min/60 + sec/3600
  x <- ifelse(substr(input, 7, 8) == "W", -x, x)

  return(x)

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
#' @examples \dontrun{
#' aemet_normal_clim_all(apikey)
#' }
#'
#' @export


aemet_normal_clim_all <- function(apikey) {

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (!is.character(apikey))
    stop("API key need to be character string")

  stations <- aemet_stations(apikey)

  data_all = data.frame()

  for (i in stations$indicativo) {

    tryCatch({
      print(i)
      data <- aemet_normal_clim(i, apikey)
      df <- data.frame(data)
      data_all <- bind_rows(data_all, df)
    }, error=function(e){})

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
#' @examples \dontrun{
#' aemet_monthly_period("9434", apikey, 2000, 2010)
#' }
#'
#' @export


aemet_monthly_period <- function(station, apikey, start, end) {

  if (missingArg(station))
    stop("Station can't be missing")

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (missingArg(start))
    stop("Start year can't be missing")

  if (missingArg(end))
    stop("End year can't be missing")

  if (!is.character(station))
    stop("Station need to be character string")

  if (!is.character(apikey))
    stop("API key need to be character string")

  if (!is.numeric(start))
    stop("Start year need to be numeric")

  if (!is.numeric(end))
    stop("End year need to be numeric")

  data_all = data.frame()

  for (y in seq(start, end, by = 1)) {

    tryCatch({
      year = y
      print(year)
      data <- aemet_monthly_clim(station, apikey, year)
      df <- data.frame(data)
      data_all <- bind_rows(data_all, df)
    }, error=function(e){})

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
#' @examples \dontrun{
#' aemet_monthly_period_all(apikey, 2000, 2010)
#' }
#'
#' @export


aemet_monthly_period_all <- function(apikey, start, end) {

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (missingArg(start))
    stop("Start year can't be missing")

  if (missingArg(end))
    stop("End year can't be missing")

  if (!is.character(apikey))
    stop("API key need to be character string")

  if (!is.numeric(start))
    stop("Start year need to be numeric")

  if (!is.numeric(end))
    stop("End year need to be numeric")

  stations <- aemet_stations(apikey)

  data_all = data.frame()

  for (i in stations$indicativo) {

    print(i)

    tryCatch({
      data <- aemet_monthly_period(station = i, apikey, start, end)
      df <- data.frame(data)
      data_all <- bind_rows(data_all,df)
    }, error=function(e){})

  }

  return(data_all)
  gc()
}

## R CMD check: the .'s that appear in pipelines

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))

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
#' @examples \donttest{
#' first_day_of_year(2000)
#' }
#'
#' @export


first_day_of_year <- function(year){

  if (missingArg(year))
    stop("Year can't be missing")

  if (!is.numeric(year))
    stop("Year need to be numeric")

  month = 1

  date <- ymd(paste0(year, "-", month, "-1")) %>%
  ceiling_date(., "month") %>% {.-days(31)}

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
#' @examples \donttest{
#' last_day_of_year(2000)
#' }
#'
#' @export


last_day_of_year <- function(year){

  if (missingArg(year))
    stop("Year can't be missing")

  if (!is.numeric(year))
    stop("Year need to be numeric")

  month = 12

  date <- ymd(paste0(year, "-", month, "-1")) %>%
  ceiling_date(., "month") %>% {.-days(1)}

  date <- as.character(date)

  return(date)

}

#' @title Daily climatology values of a station for a time period
#'
#' @description Get daily climatology values for a period of years for a station.
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param start Numeric value as start year (format: %Y).
#' @param end Numeric value as end year (format: %Y).
#'
#' @return a data.frame.
#'
#' @import lubridate
#' @importFrom dplyr bind_rows
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' aemet_daily_period("9434", apikey, 2000, 2010)
#' }
#'
#' @export


aemet_daily_period <- function(station, apikey, start, end) {

  if (missingArg(station))
    stop("Station can't be missing")

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (missingArg(start))
    stop("Start year can't be missing")

  if (missingArg(end))
    stop("End year can't be missing")

  if (!is.character(station))
    stop("Station need to be character string")

  if (!is.character(apikey))
    stop("API key need to be character string")

  if (!is.numeric(start))
    stop("Start year need to be numeric")

  if (!is.numeric(end))
    stop("End year need to be numeric")

  data_all = data.frame()

  for (y in seq(start, end, by = 1)) {

    tryCatch({
      year = y
      print(year)
      data <- aemet_daily_clim(station, apikey, first_day_of_year(year = y), last_day_of_year(year = y))
      df <- data.frame(data)
      data_all <- bind_rows(data_all, df)
    }, error=function(e){})

  }

  return(data_all)
  gc()

}

#' @title Daily climatology values of all stations for a time period
#'
#' @description Get daily climatology values for a period of years for all stations.
#'
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param start Numeric value as start year (format: %Y).
#' @param end Numeric value as end year (format: %Y).
#'
#' @return a data.frame.
#'
#' @import lubridate
#' @importFrom dplyr bind_rows
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' aemet_daily_period_all(apikey, 2000, 2010)
#' }
#'
#' @export

aemet_daily_period_all <- function(apikey, start, end) {

  if (missingArg(apikey))
    stop("API key can't be missing")

  if (missingArg(start))
    stop("Start year can't be missing")

  if (missingArg(end))
    stop("End year can't be missing")

  if (!is.character(apikey))
    stop("API key need to be character string")

  if (!is.numeric(start))
    stop("Start year need to be numeric")

  if (!is.numeric(end))
    stop("End year need to be numeric")

  stations <- aemet_stations(apikey)

  data_all = data.frame()

  for (i in stations$indicativo) {

    print(i)

    tryCatch({
      data <- aemet_daily_period(station = i, apikey, start, end)
      df <- data.frame(data)
      data_all <- bind_rows(data_all,df)
    }, error=function(e){})

  }

  return(data_all)
  gc()

}
