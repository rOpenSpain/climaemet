################################################################################################################
# Author: Manuel Pizarro <m.pizarro@csic.es>
# Ecosystem Conservation, IPE (CSIC) <http://www.ipe.csic.es/conservacion-bio/>
# Version: 0.2.0
################################################################################################################

#' @include aemet_tools.R
#' @include plot_tools.R
NULL

#' @title Station climate stripes graph
#'
#' @description Plot climate stripes graph for a station
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param with_labels Character string as yes/no. Indicates whether to use labels for the graph or not.
#' @param start Numeric value as start year (format: %Y).
#' @param end Numeric value as end year (format: %Y).
#'
#' @return a plot.
#'
#' @importFrom tidyr drop_na
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' climatestripes_station(station, apikey, with_labels = "yes")
#' }
#'
#' @export

climatestripes_station <- function(station, apikey, start = 1950, end = 2020,
                                   with_labels = c("yes, no")){

  message("Data download may take a few minutes ... please wait \n")

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

  if (missingArg(with_labels)) {

    with_labels = "yes"

  }

  if (with_labels == "no") {

    ggstripes(data, plot_type = "background")

  } else {

    ggstripes(data, plot_type = "stripes", plot_title = title)

  }

}

#' @title Walter & Lieth climatic diagram from normal climatology values
#'
#' @description Plot of a Walter & Lieth climatic diagram from normal climatology data for a station. This climatogram are great for showing a summary of climate conditions for a place over a time period ((1981-2010).
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param labels Character string as month labels for the X axis: "en" (english), "es" (spanish) or blank (numeric labels: 1-12).
#'
#' @note The code is based on code from the CRAN package "climatol" by Jose A. Guijarro <jguijarrop@aemet.es>.
#'
#' @seealso See more details in the "diagwl" function \code{\link[climatol]{diagwl}}.
#'
#' @references Walter, H. & Lieth, H (1960): Klimadiagramm Weltatlas. G. Fischer, Jena.
#'
#' @return a plot.
#'
#' @import dplyr
#' @import tidyr
#' @importFrom tibble column_to_rownames
#' @importFrom climatol diagwl
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' climatogram_normal(station, apikey, labels = "en")
#' }
#'
#' @export

climatogram_normal <- function(station, apikey,
                               labels = c("en", "es", "")){

  message("Data download may take a few seconds ... please wait \n")

  mes <- NULL
  p_mes_md <- NULL
  tm_max_md <- NULL
  tm_min_md <- NULL
  ta_min_min <- NULL
  indsinop <- NULL
  variable <- NULL
  value <- NULL
  indicativo <- NULL

  data <- aemet_normal_clim(station, apikey)

  data <- data %>% select (mes, p_mes_md, tm_max_md, tm_min_md, ta_min_min) %>%
    filter(mes < 13) %>% mutate_if(is.character, as.numeric) %>% gather(variable, value, 2:5) %>%
    spread(mes, value) %>% arrange(match(variable, c("p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min"))) %>%
    column_to_rownames(var = "variable")

  stations <- aemet_stations(apikey) %>% filter(indicativo == station) %>% select (-indsinop)

  data_na <- data %>% summarise(NAs = sum(is.na(.)))

  if (missingArg(labels)) {

    labels = "en"

  }

  if (data_na > 0) {

    message("Data with null values, unable to plot the diagram \n")

  } else {

  diagwl(data, est= stations$nombre, alt = stations$altitud, per= "1981-2010", mlab = labels)

  }

}

#' @title Walter & Lieth climatic diagram for a time period
#'
#' @description Plot of a Walter & Lieth climatic diagram from monthly climatology data for a station. This climatogram are great for showing a summary of climate conditions for a place over a specific time period.
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param start Numeric value as start year (format: %Y).
#' @param end Numeric value as end year (format: %Y).
#' @param labels Character string as month labels for the X axis: "en" (english), "es" (spanish) or blank (numeric labels, 1-12).
#'
#' @note The code is based on code from the CRAN package "climatol" by Jose A. Guijarro <jguijarrop@aemet.es>.
#'
#' @seealso See more details in the "diagwl" function \code{\link[climatol]{diagwl}}.
#'
#' @references Walter, H. & Lieth, H (1960): Klimadiagramm Weltatlas. G. Fischer, Jena.
#'
#' @return a plot.
#'
#' @import dplyr
#' @import tidyr
#' @importFrom lubridate parse_date_time month
#' @importFrom stringr str_detect
#' @importFrom climatol diagwl
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' climatogram_period(station, apikey, start = 1990, end = 2020, labels = "en")
#' }
#'
#' @export

climatogram_period <- function(station, apikey, start = 1990, end = 2020,
                               labels = c("en", "es", "")){

  message("Data download may take a few minutes ... please wait \n")

  fecha <- NULL
  p_mes <- NULL
  tm_max <- NULL
  tm_min <- NULL
  ta_min <- NULL
  mes <- NULL
  variable <- NULL
  value <- NULL
  indicativo <- NULL
  indsinop <- NULL

  data <- aemet_monthly_period(station, apikey, start, end)

  data <- data %>% select(fecha, p_mes, tm_max, tm_min, ta_min) %>%
    drop_na(p_mes, tm_max, tm_min, ta_min) %>%
    filter(!str_detect(fecha, "-13")) %>%
    mutate(ta_min = gsub("\\s*\\([^\\)]+\\)","",as.character(ta_min))) %>%
    mutate(fecha = parse_date_time(fecha, orders = "ym")) %>%
    mutate_if(is.character, as.numeric) %>%
    mutate(mes = month(fecha)) %>%
    select(-fecha) %>% group_by(mes) %>%
    summarise_all(mean) %>% gather(variable, value, 2:5) %>%
    spread(mes, value) %>% arrange(match(variable, c("p_mes", "tm_max", "tm_min", "ta_min"))) %>%
    column_to_rownames(var = "variable")

  stations <- aemet_stations(apikey) %>% filter(indicativo == station) %>% select (-indsinop)

  data_na <- data %>% summarise(NAs = sum(is.na(.)))

  if (missingArg(labels)) {

    labels = "en"

  }

  if (data_na > 0) {

    message("Data with null values, unable to plot the diagram \n")

  } else {

  diagwl(data, est= stations$nombre, alt = stations$altitud, per= paste(start, "-", end), mlab = labels)

  }
}

#' @title Windrose (speed/direction) diagram of a station over a days period
#'
#' @description Plot a windrose showing the wind speed and direction for a station over a days period.
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param start Character string as start date (format: %Y%m%d).
#' @param end Character string as end date (format: %Y%m%d).
#' @param n_directions Numeric value as number of direction bins to plot (default = 8).
#' @param n_speeds Numeric value as number of equally spaced wind speed bins to plot (default = 5).
#' @param speed_cuts Numeric vector containing the cut points for the wind speed intervals, or \code{NA} (default).
#' @param col_pal Character string indicating the name of the \code{\link[RColorBrewer]{brewer.pal.info}} colour palette to be used for plotting.
#' @param calm_wind Numeric value as the upper limit for wind speed that is considered calm (default = 0).
#' @param legend_title Character string to be used for the legend title.
#'
#' @seealso See more details in the "ggwindrose" function \code{\link{ggwindrose}}.
#'
#' @return a plot.
#'
#' @importFrom dplyr mutate select filter
#' @importFrom tidyr drop_na
#' @importFrom lubridate ymd
#'
#' @examples \dontrun{
#' windrose_days(station, apikey, start = "2000-01-01", end = "2000-12-31")
#' }
#'
#' @export

windrose_days <- function(station, apikey, start = "2000-12-31", end = "2000-12-31", n_directions = 8,
                          n_speeds = 5, speed_cuts = NA, col_pal = "GnBu", calm_wind = 0,
                          legend_title = "Wind Speed (m/s)"){

  message("Data download may take a few seconds ... please wait \n")

  fecha <- NULL
  dir <- NULL
  velmedia <- NULL
  indicativo <- NULL
  indsinop <- NULL

  data <- aemet_daily_clim(station, apikey, start, end)

  data <- data  %>%
    select(fecha, dir, velmedia) %>% drop_na() %>%
    mutate(fecha = lubridate::ymd(fecha)) %>%
    mutate(dir = as.numeric(dir) * 10) %>%
    filter(dir >= 0 & dir <= 360) %>%
    mutate(velmedia = as.numeric(gsub(",", ".", velmedia)))

  speed <- data$velmedia
  direction <- data$dir

  stations <- aemet_stations(apikey) %>% filter(indicativo == station) %>% select (-indsinop)

  title <- paste(stations$nombre, " - ", "Alt:", stations$altitud, " m.a.s.l.",
                 " / ", "Lat:", round(stations$latitud, 2), ", ", "Lon:", round(stations$longitud, 2))

    ggwindrose(speed, direction, n_directions, n_speeds, speed_cuts,
               col_pal, legend_title, plot_title = title, calm_wind)

}

#' @title Windrose (speed/direction) diagram of a station over a time period
#'
#' @description Plot a windrose showing the wind speed and direction for a station over a time period.
#'
#' @param station Character string as station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Character string as personal API key (see \url{https://opendata.aemet.es/centrodedescargas/obtencionAPIKey}).
#' @param start Numeric value as start year (format: %Y).
#' @param end Numeric value as end year (format: %Y).
#' @param n_directions Numeric value as number of direction bins to plot (default = 8).
#' @param n_speeds Numeric value as number of equally spaced wind speed bins to plot (default = 5).
#' @param speed_cuts Numeric vector containing the cut points for the wind speed intervals, or \code{NA} (default).
#' @param col_pal Character string indicating the name of the \code{\link[RColorBrewer]{brewer.pal.info}} colour palette to be used for plotting.
#' @param calm_wind Numeric value as the upper limit for wind speed that is considered calm (default = 0).
#' @param legend_title Character string to be used for the legend title.
#'
#' @seealso See more details in the "ggwindrose" function \code{\link{ggwindrose}}.
#'
#' @return a plot.
#'
#' @importFrom dplyr mutate select filter
#' @importFrom tidyr drop_na
#' @importFrom lubridate ymd
#'
#' @examples \dontrun{
#' windrose_period(station, apikey, start = 2000, end = 2010)
#' }
#'
#' @export

windrose_period <- function(station, apikey, start = 2000, end = 2010, n_directions = 8,
                n_speeds = 5, speed_cuts = NA, col_pal = "GnBu", calm_wind = 0,
                legend_title = "Wind Speed (m/s)"){

  message("Data download may take a few minutes ... please wait \n")

  fecha <- NULL
  dir <- NULL
  velmedia <- NULL
  indicativo <- NULL
  indsinop <- NULL

  data <- aemet_daily_period(station, apikey, start, end)

  data <- data  %>%
    select(fecha, dir, velmedia) %>% drop_na() %>%
    mutate(fecha = lubridate::ymd(fecha)) %>%
    mutate(dir = as.numeric(dir) * 10) %>%
    filter(dir >= 0 & dir <= 360) %>%
    mutate(velmedia = as.numeric(gsub(",", ".", velmedia)))

  speed <- data$velmedia
  direction <- data$dir

  stations <- aemet_stations(apikey) %>% filter(indicativo == station) %>% select (-indsinop)

  title <- paste(stations$nombre, " - ", "Alt:", stations$altitud, " m.a.s.l.",
                 " / ", "Lat:", round(stations$latitud, 2), ", ", "Lon:", round(stations$longitud, 2))

  ggwindrose(speed, direction, n_directions, n_speeds, speed_cuts,
             col_pal, legend_title, plot_title = title, calm_wind)

}

