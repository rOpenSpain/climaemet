################################################################################################################
# Author: Manuel Pizarro <m.pizarro@csic.es>
# Ecosystem Conservation, IPE (CSIC) <http://www.ipe.csic.es/conservacion-bio/>
# Version: 0.1.0
################################################################################################################

#' @include aemet_tools.R
#' @include plot_tools.R
NULL

#' @title Climate stripes graph
#' @description Plot climate stripes graph for a station
#'
#' @param station Station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param with_labels Indicates whether to use labels for the graph or not
#' @param start a start year (format: %Y)
#' @param end a end year (format: %Y)
#'
#' @return a ggplot image
#' @export
#'
#' @importFrom tidyr drop_na
#'
#' @examples \dontrun{
#' ggstripes_station(station, apikey, with_labels = "yes")
#' }

ggstripes_station <- function(station, apikey, start = 1920, end = 2020, with_labels = c("yes, no")){

  cat("Data download may take a few minutes ... please wait \n")

  fecha <- NULL
  indicativo <- NULL
  indsinop <- NULL
  temp <- NULL
  tm_mes <- NULL

  data <- aemet_monthly_period(station, apikey, start, end)

  data <- data %>% select(fecha, indicativo, tm_mes) %>% drop_na(tm_mes) %>%
    filter(str_detect(fecha, "-13")) %>% mutate(fecha = as.integer(str_replace(fecha, "-13", ""))) %>%
    rename(year = fecha,temp = tm_mes) %>% mutate(temp = as.numeric(temp))

  stations <- aemet_stations(apikey) %>% filter(indicativo == station) %>% select (-indsinop)

  title <- paste(stations$nombre, " - ", "Alt:", stations$altitud, " m.a.s.l.",
                 " / ", "Lat:", round(stations$latitud, 2), ", ", "Lon:", round(stations$longitud, 2))

  if (with_labels == "no") {

    ggstripes(data, plot_type = "background")

  } else {

    ggstripes(data, plot_type = "stripes", plot_title = title)

  }

}
