#' Wind rose for a range of days
#'
#' Plots a wind rose showing wind speed and direction at a station over a
#' period of days.
#'
#' @param start A character string containing the start date in `YYYY-MM-DD`
#'   format.
#' @param end A character string containing the end date in `YYYY-MM-DD` format.
#'
#' @inheritParams aemet_daily_clim
#' @inheritParams ggwindrose
#'
#' @inheritSection aemet_api_key API key
#'
#' @inherit ggwindrose return
#'
#' @seealso
#' - [aemet_daily_clim()] retrieves daily climatology data.
#' - [climaemet_9434_wind] provides example wind observations.
#'
#' @family wind
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' windrose_days("9434",
#'   start = "2000-12-01",
#'   end = "2000-12-31",
#'   speed_cuts = 4
#' )
windrose_days <- function(
  station,
  start = "2000-12-01",
  end = "2000-12-31",
  n_directions = 8,
  n_speeds = 5,
  speed_cuts = NA,
  col_pal = "GnBu",
  calm_wind = 0,
  legend_title = "Wind speed (m/s)",
  verbose = FALSE
) {
  cli::cli_alert_info("Downloading data. This may take a few seconds.")

  data_raw <- aemet_daily_clim(
    station = station,
    start = start,
    end = end,
    verbose = verbose
  )

  data <- data_raw[c("fecha", "dir", "velmedia")]
  data <- tidyr::drop_na(data)
  data <- dplyr::mutate(data, dir = as.numeric(data[["dir"]]) * 10)
  data <- dplyr::filter(data, data[["dir"]] >= 0 & data[["dir"]] <= 360)

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

#' Wind rose for a range of years
#'
#' Plots a wind rose showing wind speed and direction at a station over a
#' time period.
#'
#' @inheritParams aemet_monthly_period
#' @inheritParams ggwindrose
#'
#' @inheritSection aemet_api_key API key
#'
#' @inherit windrose_days return
#'
#' @seealso
#' - [aemet_daily_period()] retrieves daily climatology data by period.
#' - [climaemet_9434_wind] provides example wind observations.
#'
#' @family wind
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' \donttest{
#' # Do not run this example.
#' if (FALSE) {
#'   # Downloading data may take a few minutes.
#'   windrose_period("9434",
#'     start = 2000, end = 2010,
#'     speed_cuts = 4
#'   )
#' }
#' }
windrose_period <- function(
  station,
  start = 2000,
  end = 2010,
  n_directions = 8,
  n_speeds = 5,
  speed_cuts = NA,
  col_pal = "GnBu",
  calm_wind = 0,
  legend_title = "Wind speed (m/s)",
  verbose = FALSE
) {
  cli::cli_alert_info("Downloading data. This may take a few seconds.")

  data_raw <- aemet_daily_period(station, start, end, verbose = verbose)

  data <- data_raw[c("fecha", "dir", "velmedia")]
  data <- tidyr::drop_na(data)
  data <- dplyr::mutate(data, dir = as.numeric(data[["dir"]]) * 10)
  data <- dplyr::filter(data, data[["dir"]] >= 0 & data[["dir"]] <= 360)

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

#' Plot a wind rose
#'
#' Plots a wind rose showing wind speed and direction with \CRANpkg{ggplot2}.
#'
#' @param speed A numeric vector of wind speeds.
#' @param direction A numeric vector of wind directions.
#' @param facet A character or factor vector of facets used to plot wind roses.
#' @param n_directions The number of direction bins (petals) to plot. Valid
#'   values are `4`, `8` or `16`.
#' @param n_speeds The number of equally spaced wind speed bins to plot when
#'   `speed_cuts` is `NA`. Defaults to `5`.
#' @param speed_cuts A numeric vector with the cut points for the wind speed
#'   intervals or `NA` (default).
#' @param calm_wind The upper wind speed limit considered calm. Defaults to `0`.
#' @param legend_title A character string or expression for the legend title.
#' @param plot_title A character string for the plot title.
#' @param col_pal A character string specifying an [hcl.pals()] color palette.
#' @param n_col The number of plot columns. Defaults to `1`.
#' @param stack_reverse A logical value. If `TRUE`, reverses the stack order of
#'   speed cuts. See **Examples**.
#' @param ... Further arguments (ignored).
#'
#' @inherit ggclimat_walter_lieth return
#'
#' @seealso [ggplot2::theme()] for additional arguments to pass to
#'   `ggwindrose()` and [climaemet_9434_wind].
#'
#' @family wind
#'
#' @export
#' @encoding UTF-8
#' @examples
#' library(ggplot2)
#'
#' speed <- climaemet::climaemet_9434_wind$velmedia
#' direction <- climaemet::climaemet_9434_wind$dir
#'
#' rose <- ggwindrose(
#'   speed = speed,
#'   direction = direction,
#'   speed_cuts = seq(0, 16, 4),
#'   legend_title = "Wind speed (m/s)",
#'   calm_wind = 0,
#'   n_col = 1,
#'   plot_title = "Zaragoza Airport"
#' )
#' rose + labs(
#'   subtitle = "2000-2020",
#'   caption = "Source: AEMET"
#' )
#'
#' # Reverse the stack.
#'
#' ggwindrose(
#'   speed = speed,
#'   direction = direction,
#'   speed_cuts = seq(0, 16, 4),
#'   legend_title = "Wind speed (m/s)",
#'   calm_wind = 0,
#'   n_col = 1,
#'   plot_title = "Zaragoza Airport",
#'   stack_reverse = TRUE
#' ) +
#'   labs(
#'     subtitle = "2000-2020",
#'     caption = "Source: AEMET"
#'   )
#'
ggwindrose <- function(
  speed,
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
  stack_reverse = FALSE,
  ...
) {
  if (any(missing(speed), !is.numeric(speed))) {
    cli::cli_abort(paste0(
      "{.arg speed} must be numeric, ",
      "not {.obj_type_friendly {speed}}."
    ))
  }

  if (any(missing(direction), !is.numeric(direction))) {
    cli::cli_abort(paste0(
      "{.arg direction} must be numeric, ",
      "not {.obj_type_friendly {direction}}."
    ))
  }

  if (length(speed) != length(direction)) {
    cli::cli_abort(paste0(
      "{.arg direction} and {.arg speed} must have the same ",
      "length ({.val {length(direction)}} vs. {.val {length(speed)}})."
    ))
  }

  if (any((direction > 360 | direction < 0), na.rm = TRUE)) {
    cli::cli_abort(
      "{.arg direction} must be between 0 and 360, not {.val {direction}}."
    )
  }

  if (!is.logical(stack_reverse)) {
    cli::cli_abort(paste0(
      "{.arg stack_reverse} must be logical, ",
      "not {.obj_type_friendly {stack_reverse}}."
    ))
  }

  include_facet <- !is.null(facet)

  if (include_facet) {
    if (!any(is.character(facet), is.factor(facet))) {
      cli::cli_abort(paste0(
        "{.arg facet} must be a character or factor vector, ",
        "not {.obj_type_friendly {facet}}."
      ))
    }

    if (length(facet) == 1) {
      facet <- rep(facet, length(speed))
    }

    if (length(facet) != length(speed)) {
      cli::cli_abort(paste0(
        "{.arg facet} and {.arg speed} must have the same ",
        "length ({.val {length(facet)}} vs. {.val {length(speed)}})."
      ))
    }
  }

  if (!is.numeric(n_directions) || length(n_directions) != 1) {
    cli::cli_abort(paste0(
      "{.arg n_directions} must be a numeric vector of length 1, not ",
      "{.obj_type_friendly {n_directions}} of length ",
      "{.val {length(n_directions)}}."
    ))
  }

  if (!is.numeric(n_speeds) || length(n_speeds) != 1) {
    cli::cli_abort(paste0(
      "{.arg n_speeds} must be a numeric vector of length 1, not ",
      "{.obj_type_friendly {n_speeds}} of length {.val {length(n_speeds)}}."
    ))
  }

  if (!is.numeric(calm_wind) || length(calm_wind) != 1) {
    cli::cli_abort(paste0(
      "{.arg calm_wind} must be a numeric vector of length 1, not ",
      "{.obj_type_friendly {calm_wind}} of length {.val {length(calm_wind)}}."
    ))
  }

  if (
    (!is.character(legend_title) && !is.expression(legend_title)) ||
      length(legend_title) != 1
  ) {
    cli::cli_abort(paste0(
      "{.arg legend_title} must be a single character string or expression, ",
      "not {.obj_type_friendly {legend_title}}."
    ))
  }

  if (!col_pal %in% hcl.pals()) {
    cli::cli_abort(paste0(
      "{.arg col_pal} must be one of the palettes ",
      "returned by {.fn grDevices::hcl.pals}."
    ))
  }

  if (!all(is.na(speed_cuts)) && !is.numeric(speed_cuts)) {
    cli::cli_abort(paste0(
      "{.arg speed_cuts} must be numeric or {.val NA}, ",
      "not {.obj_type_friendly {speed_cuts}}."
    ))
  }

  optimal_n_dir <- c(4, 8, 16)

  if (is.na(match(n_directions, optimal_n_dir))) {
    n_directions <- optimal_n_dir[which.min(abs(n_directions - optimal_n_dir))]
    cli::cli_alert_info(paste0(
      "Using the closest optimal number of wind directions ",
      "({.val {n_directions}})."
    ))
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
    )
  )

  # Create a factor variable for wind direction intervals.
  dir_bin_width <- 360 / n_directions
  dir_bin_cuts <- seq(dir_bin_width / 2, 360 - dir_bin_width / 2, dir_bin_width)
  dir_intervals <- findInterval(c(direction, dir_bin_cuts), dir_bin_cuts)
  dir_intervals[dir_intervals == n_directions] <- 0
  factor_labs <- paste(
    c(tail(dir_bin_cuts, 1), head(dir_bin_cuts, -1)),
    dir_bin_cuts,
    sep = ", "
  )
  dir_bin <- head(
    factor(dir_intervals, labels = paste0("(", factor_labs, "]")),
    -n_directions
  )

  # Create a factor variable for wind speed intervals.

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

  # Reverse the speed factors when requested.
  if (stack_reverse) {
    spd_bin <- factor(spd_bin, levels = rev(levels(spd_bin)))
  }

  # Create a new palette.
  spd_cols <- hcl.colors(nlevels(spd_bin), col_pal, rev = !stack_reverse)

  if (length(spd_cols) != nlevels(spd_bin)) {
    spd_bin <- ggplot2::cut_interval(speed, length(spd_cols)) # nocov
  }

  # Create a data frame suitable for plotting.
  if (include_facet) {
    ggplot_df <- as.data.frame(table(dir_bin, spd_bin, facet))
    ggplot_df$proportion <- unlist(
      by(ggplot_df$Freq, ggplot_df$facet, function(x) {
        x / sum(x)
      }),
      use.names = FALSE
    )
  } else {
    ggplot_df <- data.frame(table(dir_bin, spd_bin))
    ggplot_df$proportion <- ggplot_df$Freq / sum(ggplot_df$Freq)
  }

  ## Draw plot.

  windrose_plot <- ggplot2::ggplot(
    data = ggplot_df,
    ggplot2::aes(x = .data$dir_bin, fill = .data$spd_bin, y = .data$proportion)
  ) +
    ggplot2::geom_bar(stat = "identity") +
    ggplot2::scale_x_discrete(
      breaks = levels(ggplot_df$dir_bin)[seq(1, n_directions, 1)],
      labels = dir_labels,
      drop = FALSE
    ) +
    ggplot2::scale_fill_manual(name = legend_title, values = spd_cols) +
    ggplot2::coord_radial(start = 2 * pi - pi / n_directions, expand = FALSE) +
    ggplot2::scale_y_continuous(
      # nocov start
      labels = function(values) {
        values <- sprintf("%0.1f %%", values * 100)
        values
      }
      # nocov end
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      axis.title = ggplot2::element_blank(),
      # Do not display the x-axis. See
      # https://github.com/rOpenSpain/climaemet/issues/72
      axis.line.x = ggplot2::element_blank()
    ) +
    ggplot2::labs(title = plot_title)

  if (stack_reverse) {
    windrose_plot <- windrose_plot +
      ggplot2::guides(fill = ggplot2::guide_legend(reverse = TRUE))
  }

  if (include_facet) {
    windrose_plot <- windrose_plot + ggplot2::facet_wrap(~facet, ncol = n_col)
  }

  windrose_plot
}
