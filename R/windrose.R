#' Windrose (speed/direction) diagram of a station over a days period
#'
#' @description
#' Plot a windrose showing the wind speed and direction for a station over a
#' days period.
#'
#' @family aemet_plots
#'
#' @param start Character string as start date (format: YYYY-MM-DD).
#' @param end Character string as end date (format: YYYY-MM-DD).
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @inheritParams aemet_daily_clim
#'
#' @inheritParams ggwindrose
#'
#' @seealso [aemet_daily_clim()]
#'
#' @return A `ggplot2` object
#'
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#'
#' if (aemet_detect_api_key()) {
#'   windrose_days("9434",
#'     start = "2000-12-01",
#'     end = "2000-12-31",
#'     speed_cuts = 4
#'   )
#' }
#' @export

windrose_days <-
  function(station,
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

    data_raw <-
      aemet_daily_clim(
        station = station,
        start = start,
        end = end,
        verbose = verbose
      )

    data <- data_raw[c("fecha", "dir", "velmedia")]
    data <- tidyr::drop_na(data)
    data <-
      dplyr::mutate(data, dir = as.numeric(data[["dir"]]) * 10)
    data <-
      dplyr::filter(data, data[["dir"]] >= 0 & data[["dir"]] <= 360)

    speed <- data$velmedia
    direction <- data$dir

    stations <- aemet_stations(verbose = verbose)
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
#' Plot a windrose showing the wind speed and direction for a station over a
#' time period.
#'
#' @family aemet_plots
#'
#' @param start Numeric value as start year (format: YYYY).
#' @param end Numeric value as end year (format: YYYY).
#'
#' @inheritParams windrose_days
#'
#' @seealso [aemet_daily_period()]
#'
#' @return A `ggplot2` object
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#'
#' if (aemet_detect_api_key()) {
#'   windrose_period("9434",
#'     start = 2000, end = 2010,
#'     speed_cuts = 4
#'   )
#' }
#' @export

windrose_period <-
  function(station,
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
      start, end,
      verbose = verbose
    )

    data <- data_raw[c("fecha", "dir", "velmedia")]
    data <- tidyr::drop_na(data)
    data <-
      dplyr::mutate(data, dir = as.numeric(data[["dir"]]) * 10)
    data <-
      dplyr::filter(data, data[["dir"]] >= 0 & data[["dir"]] <= 360)

    speed <- data$velmedia
    direction <- data$dir

    stations <- aemet_stations(verbose = verbose)
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


#' Windrose (speed/direction) diagram
#'
#' @description
#' Plot a windrose showing the wind speed and direction using **ggplot2**.
#'
#' @family aemet_plots
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @param speed Numeric vector of wind speeds.
#' @param direction Numeric vector of wind directions.
#' @param facet Character or factor vector of the facets used to plot the
#'   various windroses.
#' @param n_directions Numeric value as the number of direction bins to plot
#'   (petals on the rose). The number of directions defaults to 8.
#' @param n_speeds Numeric value as the number of equally spaced wind speed
#'   bins to plot. This is used if `speed_cuts` is `NA` (default 5).
#' @param speed_cuts Numeric vector containing the cut points for the wind
#'  speed intervals, or `NA` (default).
#' @param calm_wind Numeric value as the upper limit for wind speed that is
#'   considered calm (default 0).
#' @param legend_title Character string to be used for the legend title.
#' @param plot_title Character string to be used for the plot title.
#' @param col_pal Character string indicating the name of the
#'   [hcl.pals()] colour palette to be used for plotting.
#' @param n_col The number of columns of plots (default 1).
#' @param ... further arguments (ignored).
#'
#' @seealso [ggplot2::theme()] for more possible arguments to pass to
#'   `ggwindrose`.
#'
#' @return A `ggplot` object.
#'
#'
#' @example inst/examples/ggwindrose.R
#'
#' @export

ggwindrose <- function(speed,
                       direction,
                       n_directions = 8,
                       n_speeds = 5,
                       speed_cuts = NA,
                       col_pal = "GnBu",
                       legend_title = "Wind speed (m/s)",
                       calm_wind = 0,
                       n_col = 1,
                       facet = NULL,
                       plot_title = "",
                       ...) {
  if (missing(speed)) {
    stop("Speed can't be missing")
  }

  if (missing(direction)) {
    stop("Direction can't be missing")
  }

  include_facet <- !is.null(facet)

  if (include_facet) {
    if (!is.character(facet) && !is.factor(facet)) {
      stop("The facet variable needs to be character or factor")
    }

    if (length(facet) == 1) {
      facet <- rep(facet, length(speed))
    }

    if (length(facet) != length(speed)) {
      stop("The facet variable must be the same length as the wind speeds")
    }
  }

  if (!is.numeric(speed)) {
    stop("Wind speeds need to be numeric")
  }

  if (!is.numeric(direction)) {
    stop("Wind directions need to be numeric")
  }

  if (length(speed) != length(direction)) {
    stop("Wind speeds and directions must be the same length")
  }

  if (any((direction > 360 | direction < 0),
    na.rm = TRUE
  )) {
    stop("Wind directions can't be outside the interval [0, 360]")
  }

  if (!is.numeric(n_directions) || length(n_directions) != 1) {
    stop("n_directions must be a numeric vector of length 1")
  }

  if (!is.numeric(n_speeds) || length(n_speeds) != 1) {
    stop("n_speeds must be a numeric vector of length 1")
  }

  if (!is.numeric(calm_wind) || length(calm_wind) != 1) {
    stop("calm_wind must be a numeric vector of length 1")
  }

  # Substituting values below calm_wind for 0
  # Need to check with the creator of the package
  # calm_elements <- length(speed[speed <= calm_wind])
  # if (calm_elements > 0) {
  #   message(
  #     "Calm wind: ", calm_elements, " values below `calm_wind` ",
  #     "thresold. Replaced by zeroes"
  #   )
  # }

  # speed[speed <= calm_wind] <- 0

  if ((!is.character(legend_title) &&
    !is.expression(legend_title)) ||
    length(legend_title) != 1) {
    stop("Legend title must be a single character string or expression")
  }


  if (!col_pal %in% hcl.pals()) {
    stop("`col_pal` should be one of the palettes defined on `hc.pals()`")
  }

  if (any(!is.na(speed_cuts)) && !is.numeric(speed_cuts)) {
    stop("`speed_cuts` should be numeric or NA")
  }

  # speed_cuts <- sort(unique(speed_cuts))

  # if (!missing(speed_cuts) && length(speed_cuts) < 3) {
  #   warning("Using the minimum 3 speed cuts")
  #   speed_cuts <- 3
  # }

  optimal_n_dir <- c(4, 8, 16)

  if (is.na(match(n_directions, optimal_n_dir))) {
    n_directions <-
      optimal_n_dir[which.min(abs(n_directions - optimal_n_dir))]
    message(
      "Using the closest optimal number of wind directions (",
      n_directions,
      ")"
    )
  }

  dir_labels <- switch(as.character(n_directions),
    "4" = c("N", "E", "S", "W"),
    "8" = c("N", "NE", "E", "SE", "S", "SW", "W", "NW"),
    "16" = c(
      "N",
      "NNE",
      "NE",
      "ENE",
      "E",
      "ESE",
      "SE",
      "SSE",
      "S",
      "SSW",
      "SW",
      "WSW",
      "W",
      "WNW",
      "NW",
      "NNW"
    ),
  )

  # Factor variable for wind direction intervals
  dir_bin_width <- 360 / n_directions
  dir_bin_cuts <-
    seq(dir_bin_width / 2, 360 - dir_bin_width / 2, dir_bin_width)
  dir_intervals <-
    findInterval(c(direction, dir_bin_cuts), dir_bin_cuts)
  dir_intervals[dir_intervals == n_directions] <- 0
  factor_labs <-
    paste(c(tail(dir_bin_cuts, 1), head(dir_bin_cuts, -1)),
      dir_bin_cuts,
      sep = ", "
    )
  dir_bin <- head(factor(dir_intervals,
    labels = paste0("(", factor_labs, "]")
  ), -n_directions)

  # Factor variable for wind speed intervals

  if (is.numeric(speed_cuts)) {
    if (min(speed) < min(speed_cuts)) {
      speed_cuts <- c(min(speed), speed_cuts)
    }

    if (max(speed) > max(speed_cuts)) {
      speed_cuts <- c(speed_cuts, max(speed))
    }

    speed_cuts <- sort(unique(speed_cuts))

    spd_bin <- cut(speed, speed_cuts)
  } else {
    spd_bin <- ggplot2::cut_interval(speed, n_speeds)
  }

  # New palette
  spd_cols <-
    hcl.colors(length(levels(spd_bin)), col_pal, rev = TRUE)

  if (length(spd_cols) != length(levels(spd_bin))) {
    spd_bin <- ggplot2::cut_interval(speed, length(spd_cols))
  }

  # Dataframe suitable for plotting
  if (include_facet) {
    ggplot_df <- as.data.frame(table(dir_bin, spd_bin, facet))
    ggplot_df$proportion <- unlist(by(
      ggplot_df$Freq,
      ggplot_df$facet, function(x) {
        x / sum(x)
      }
    ),
    use.names = FALSE
    )
  } else {
    ggplot_df <- data.frame(table(dir_bin, spd_bin))
    ggplot_df$proportion <- ggplot_df$Freq / sum(ggplot_df$Freq)
  }

  ## Draw plot

  windrose_plot <- ggplot2::ggplot(
    data = ggplot_df,
    ggplot2::aes_string(
      x = "dir_bin",
      fill = "spd_bin",
      y = "proportion"
    )
  ) +
    ggplot2::geom_bar(stat = "identity") +
    ggplot2::scale_x_discrete(
      breaks = levels(ggplot_df$dir_bin)[seq(1, n_directions, 1)],
      labels = dir_labels,
      drop = FALSE
    ) +
    ggplot2::scale_fill_manual(name = legend_title, values = spd_cols) +
    ggplot2::coord_polar(start = 2 * pi - pi / n_directions) +
    ggplot2::scale_y_continuous(
      labels = function(values) {
        values <- sprintf("%0.1f %%", values * 100)
        return(values)
      }
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.title = ggplot2::element_blank()) +
    ggplot2::labs(title = plot_title)

  if (include_facet) {
    windrose_plot <-
      windrose_plot + ggplot2::facet_wrap(~facet, ncol = n_col)
  }

  return(windrose_plot)
}
