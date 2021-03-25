#' Windrose (speed/direction) diagram of a station over a days period
#'
#' @description
#' Plot a windrose showing the wind speed and direction for a station over a days period.
#'
#' @concept aemet_plots
#'
#' @param start Character string as start date (format: %Y%m%d).
#' @param end Character string as end date (format: %Y%m%d).
#' @param n_directions Numeric value as number of direction bins to plot (default = 8).
#' @param n_speeds Numeric value as number of equally spaced wind speed bins to plot (default = 5).
#' @param speed_cuts Numeric vector containing the cut points for the wind speed intervals, or \code{NA} (default).
#' @param col_pal Character string indicating the name of the \code{\link[RColorBrewer]{brewer.pal.info}} colour palette to be used for plotting.
#' @param calm_wind Numeric value as the upper limit for wind speed that is considered calm (default = 0).
#' @param legend_title Character string to be used for the legend title.
#'
#' @inheritParams aemet_daily_clim
#'
#' @seealso [ggwindrose()].
#'
#' @return a plot.
#'
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#' apikey <- Sys.getenv("AEMET_API_KEY")
#' if (apikey != "") {
#'   windrose_days("9434", apikey, start = "2000-01-01", end = "2000-12-31", speed_cuts = 4)
#' }
#' @export

windrose_days <-
  function(station,
           apikey = NULL,
           start = "2000-12-01",
           end = "2000-12-31",
           n_directions = 8,
           n_speeds = 5,
           speed_cuts = NA,
           col_pal = "GnBu",
           calm_wind = 0,
           legend_title = "Wind Speed (m/s)",
           verbose = FALSE) {
    message("Data download may take a few seconds ... please wait \n")

    data_raw <- aemet_daily_clim(station = station, apikey = apikey, start = start, end = end, verbose = TRUE)

    data <- data_raw[c("fecha", "dir", "velmedia")]
    data <- tidyr::drop_na(data)
    data <- dplyr::mutate(data, dir = as.numeric(data[["dir"]]) * 10)
    data <- dplyr::filter(data, data[["dir"]] >= 0 & data[["dir"]] <= 360)

    speed <- data$velmedia
    direction <- data$dir

    stations <- aemet_stations(apikey, verbose = verbose)
    stations <- stations[stations$indicativo == station, ]

    title <- paste(
      stations$nombre,
      " - ",
      "Alt:",
      stations$altitud,
      " m.a.s.l.",
      " / ",
      "Lat:",
      round(stations$latitud, 2),
      ", ",
      "Lon:",
      round(stations$longitud, 2)
    )

    ggwindrose(
      speed,
      direction,
      n_directions,
      n_speeds,
      speed_cuts,
      col_pal,
      legend_title,
      plot_title = title,
      calm_wind
    )
  }

#' Windrose (speed/direction) diagram of a station over a time period
#'
#' @description
#' Plot a windrose showing the wind speed and direction for a station over a time period.
#'
#' @concept aemet_plots
#'
#' @param start Numeric value as start year (format: %Y).
#' @param end Numeric value as end year (format: %Y).
#'
#' @inheritParams windrose_days
#'
#' @seealso [ggwindrose()], [windrose_days()]
#'
#' @return a plot.
#'
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#' apikey <- Sys.getenv("AEMET_API_KEY")
#' if (apikey != "") {
#'   windrose_period("9434", start = 2000, end = 2010, speed_cuts = 4)
#' }
#' @export

windrose_period <-
  function(station,
           apikey = NULL,
           start = 2000,
           end = 2010,
           n_directions = 8,
           n_speeds = 5,
           speed_cuts = NA,
           col_pal = "GnBu",
           calm_wind = 0,
           legend_title = "Wind Speed (m/s)",
           verbose = FALSE) {
    message("Data download may take a few minutes ... please wait \n")

    data_raw <- aemet_daily_period(station,
      apikey = apikey, start, end,
      verbose = verbose
    )

    data <- data_raw[c("fecha", "dir", "velmedia")]
    data <- tidyr::drop_na(data)
    data <- dplyr::mutate(data, dir = as.numeric(data[["dir"]]) * 10)
    data <- dplyr::filter(data, data[["dir"]] >= 0 & data[["dir"]] <= 360)

    speed <- data$velmedia
    direction <- data$dir

    stations <- aemet_stations(apikey, verbose = verbose)
    stations <- stations[stations$indicativo == station, ]

    title <- paste(
      stations$nombre,
      " - ",
      "Alt:",
      stations$altitud,
      " m.a.s.l.",
      " / ",
      "Lat:",
      round(stations$latitud, 2),
      ", ",
      "Lon:",
      round(stations$longitud, 2)
    )

    ggwindrose(
      speed,
      direction,
      n_directions,
      n_speeds,
      speed_cuts,
      col_pal,
      legend_title,
      plot_title = title,
      calm_wind
    )
  }
