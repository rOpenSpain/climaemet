################################################################################################################
# Author: Manuel Pizarro <m.pizarro@csic.es>
# Ecosystem Conservation, IPE (CSIC) <http://www.ipe.csic.es/conservacion-bio/>
# Version: 0.2.0
################################################################################################################

#' @title Warming stripes graph
#'
#' @description Plot diferent "climate stripes" or "warming stripes" using \pkg{ggplot2}. This graphics are visual representations of the change in temperature as measured in each location over the past 70-100+ years. Each stripe represents the temperature in that station averaged over a year.
#'
#' @note "Warming stripes" charts are a conceptual idea of Professor Ed Hawkins (University of Reading) and are specifically designed to be as simple as possible and alert about risks of climate change. For more details see #ShowYourStripes: <https://showyourstripes.info/>.
#'
#' @param data a data.frame with date(year) and temperature(temp) variables.
#' @param plot_type plot type (whith labels, background, stripes with line trend and animation)
#' @param plot_title character string to be used for the graph title.
#' @param ... further arguments passed to \code{\link[ggplot2]{theme}}.
#'
#' @seealso \code{\link[ggplot2]{theme}} for more possible arguments to pass to \code{ggstripes}.
#'
#' @import ggplot2
#' @import scales
#' @import ggpubr
#' @import ggthemes
#' @import gtable
#' @importFrom dplyr mutate
#' @importFrom lubridate ymd
#' @importFrom stringr str_c str_replace
#' @importFrom gganimate transition_reveal
#' @importFrom RColorBrewer brewer.pal
#' @importFrom jpeg readJPEG
#' @importFrom methods missingArg
#'
#' @return a \code{ggplot} object
#'
#' @examples \dontrun{
#' ggstripes(data, plot_type = "background")
#' }
#'
#' @export

ggstripes <- function(data, plot_type = c("background", "stripes", "trend", "animation"),
                      plot_title = "", ...){

  temp <- NULL

  # Missing values 999.9
  data <- mutate(data, temp = ifelse(data$temp == 999.9, NA, data$temp))

  # Formatting dates
  data <- mutate(data, date = str_c(year, "01-01", sep = "-") %>% ymd())

  # Create themes
  theme_strip <- theme_minimal() +
    theme(axis.text.y = element_blank(),
          axis.line.y = element_blank(),
          axis.title = element_blank(),
          panel.grid.major = element_blank(),
          legend.title = element_blank(),
          axis.text.x = element_text(vjust = 3),
          panel.grid.minor = element_blank(),
          plot.title = element_text(size = 14, face = "bold"))

  theme_striptrend <- theme_bw() +
    theme(axis.text.x = element_text(face="plain", color="black", size=11),
          axis.text.y = element_text(face="plain", color="black", size=11),
          axis.title.x = element_text(color="red", size=14, face="bold"),
          axis.title.y = element_text(color="red", size=14, face="bold", vjust = 1),
          plot.title = element_text(size = 14, face = "bold"),
          legend.background = element_rect(fill="white", size=0.5, linetype="solid", colour ="black"),
          plot.caption = element_text(color = "black", face = "plain", size = 12))

  # Create palette
  pal_strip <- brewer.pal(11, "RdBu")
  # brewer.pal.info

  if (plot_type == "stripes"){

    message("Climate stripes plotting ...")

    # Create climate stripes plot with labels
    striplotlab <- ggplot(data, aes(x = date, y = 1, fill = temp)) +
      geom_tile() +
      scale_x_date(date_breaks = "5 years", date_labels = "%Y", expand = c(0, 0),
                   limits = c(min(data$date), max(data$date))) +
      scale_y_continuous(expand = c(0, 0)) +
      scale_fill_gradientn(colors = rev(pal_strip)) +
      guides(fill = guide_colorbar(barwidth = 1)) +
      labs(title = plot_title, caption = "Source: Spanish Meteorological Agency (AEMET)") +
      theme_strip

    # Draw plot
    return(striplotlab)

  } else if (plot_type == "trend") {

    message("Climate stripes with temperature line trend plotting ...")

    # Create climate stripes plot with line trend
    striplotrend <- ggplot(data, aes(x = date, y = temp)) +
      geom_tile(mapping = aes(x = date, y = mean(temp), fill = temp),
                alpha = 1, height = max(data$temp)-min(data$temp) + 0.5) +
      geom_line(aes(y = temp), size = 1.7, color = "black", alpha = 1) +
      geom_smooth(method = "gam", formula = y ~ s(x), color = "yellow", size = 1.5, fill = "black") +
      scale_y_continuous(expand = c(0,0), limits = c(28.7, 29.7)) +
      scale_x_date(date_breaks = "5 years", date_labels = "%Y", expand = c(0, 0),
                   limits = c(min(data$date), max(data$date))) +
      scale_fill_gradientn(colors = rev(pal_strip)) +
      guides(fill = guide_colorbar(barwidth = 1)) +
      labs(fill = "Temp. (C)", title = plot_title,
           caption = "Source: Spanish Meteorological Agency (AEMET)") +
      xlab("Date (Year)") + ylab("Temperature (C)") +
      theme_striptrend

    # Draw plot
    return(striplotrend)

  } else if (plot_type == "background") {

    message("Climate stripes background plotting ...")

    # Create climate stripes background
    stripbackground <- ggplot(data, aes(x = date, y = 1, fill = temp)) +
      geom_tile(show.legend = FALSE) +
      scale_x_date(date_breaks = "5 years",
                   date_labels = "%Y",
                   expand = c(0, 0)) +
      scale_y_continuous(expand = c(0, 0)) +
      scale_fill_gradientn(colors = rev(pal_strip), na.value = "lightgrey") +
      guides(fill = guide_colorbar(barwidth = 1)) +
      theme_void()

    # Draw plot
    return(stripbackground)

  } else {

    message("Climate stripes animation ...")

    # Create climate stripes plot animation
    # Create climate stripes background
    stripbackground <- ggplot(data, aes(x = date, y = 1, fill = temp)) +
      geom_tile(show.legend = FALSE) +
      scale_x_date(date_breaks = "5 years",
                   date_labels = "%Y",
                   expand = c(0, 0))+
      scale_y_continuous(expand = c(0, 0))+
      scale_fill_gradientn(colors = rev(pal_strip), na.value = "lightgrey") +
      guides(fill = guide_colorbar(barwidth = 1)) +
      theme_void()

    # Save plot as image on temporary directory
    ggsave(plot = stripbackground, filename ="stripbrackground.jpeg", path = tempdir(), device = "jpeg", scale = 1,
           width = 210, height = 150, units = "mm", dpi = 150, limitsize = TRUE)

    # Read stripes plot for background
    backgroud <- readJPEG(file.path(tempdir(), "stripbrackground.jpeg"))

    striplotanimation <- ggplot(data, aes(x = date, y = temp)) +
      background_image(backgroud) + geom_line(size = 1.5, color = "yellow") +
      # geom_smooth(method = "gam", formula = y ~ s(x), color = "black", size = 1.5, fill = "white") +
      scale_x_date(date_breaks = "5 years", date_minor_breaks = "5 years", date_labels = "%Y", expand = c(0, 0)) +
      scale_y_continuous(sec.axis = dup_axis(labels = waiver(), name = " "), labels = NULL,
                         limits = c(28.70, 29.70), breaks = c(28.75, 29, 29.25, 29.50, 29.75)) +
      labs(title = plot_title,
           caption = "Source: Spanish Meteorological Agency (AEMET)") +
      xlab("Year") + ylab("Temperature (C)") +
      theme_strip +
      theme(axis.text.x = element_text(face="plain", color="black", size=11),
            axis.text.y = element_text(face="plain", color="black", size=11),
            axis.title.x = element_text(color="red", size=13, face="bold"),
            axis.title.y = element_text(color="red", size=13, face="bold"),
            plot.caption = element_text(color = "black", face = "plain", size = 12)) +
      transition_reveal(date)

    # # Save animation
    # animate(striplotanimation, nframes = 312, duration = 14, renderer = gifski_renderer("climate_stripes_animation.gif"),
    #         width = 420, height = 297, units = "mm", res = 60)

    # Draw plot
    return(striplotanimation)

    message("Done! ... Read gganimate::animate help for save plot")

  }

  # Clear environment except function
  rm(list = ls(all.names =TRUE))

}

#' @title Windrose (speed/direction) diagram
#'
#' @description  Plot a windrose showing the wind speed and direction using \pkg{ggplot2}.
#'
#' @section Palette selection:
#' Any of the sequential \code{\link[RColorBrewer]{brewer.pal.info}} colour palettes are recommended for colour plots.
#'
#' @param speed Numeric vector of wind speeds.
#' @param direction Numeric vector of wind directions.
#' @param facet Character or factor vector of the facets used to plot the various windroses.
#' @param n_directions Numeric value as the number of direction bins to plot (petals on the rose).
#'                     The number of directions defaults to 8.
#' @param n_speeds Numeric value as the number of equally spaced wind speed bins to plot. This is
#'                 used if \code{speed_cuts} is \code{NA} (default 5).
#' @param speed_cuts Numeric vector containing the cut points for the wind speed
#'                 intervals, or \code{NA} (default).
#' @param calm_wind Numeric value as the upper limit for wind speed that is considered calm (default 0).
#' @param legend_title Character string to be used for the legend title.
#' @param plot_title Character string to be used for the plot title.
#' @param col_pal Character string indicating the name of the
#'                \code{\link[RColorBrewer]{brewer.pal.info}} colour palette to be
#'                used for plotting, see 'Palette selection' below.
#' @param n_col The number of columns of plots (default 1).
#' @param ... further arguments passed to \code{\link[ggplot2]{theme}}.
#'
#' @seealso \code{\link[ggplot2]{theme}} for more possible arguments to pass to \code{ggwindrose}.
#'
#' @return a \code{ggplot} object.
#'
#' @import ggplot2
#' @importFrom RColorBrewer brewer.pal
#' @importFrom scales percent_format
#' @importFrom methods missingArg
#'
#' @examples \dontrun{
#' ggwindrose(speed, direction, n_directions = 16,
#' n_speeds = 7, col_pal = "GnBu", legend_title = "Wind speed (m/s)",
#' calm_wind = 0, n_col = 1)
#' }
#'
#' @export

ggwindrose = function(speed, direction, n_directions = 8,
                      n_speeds = 5, speed_cuts = NA, col_pal = "GnBu",
                      legend_title = "Wind speed (m/s)", calm_wind = 0,
                      n_col = 1, facet, plot_title = "", ...){

  not_variable <- NULL
  tail <- NULL
  head <- NULL

  if (missingArg(speed))
    stop("Speed can't be missing")

  if (missingArg(direction))
    stop("Direction can't be missing")

  include_facet = !missingArg(facet)

  if (include_facet){

    if (!is.character(facet) && !is.factor(facet))
      stop("The facet variable needs to be character or factor")

    if (length(facet) == 1)
      facet = rep(facet, length(speed))

    if (length(facet) != length(speed))
      stop("The facet variable must be the same length as the wind speeds")
  }

  if (!is.numeric(speed))
    stop("Wind speeds need to be numeric")

  if (!is.numeric(direction))
    stop("Wind directions need to be numeric")

  if (length(speed) != length(direction))
    stop("Wind speeds and directions must be the same length")

  if (any(
    (direction > 360 | direction < 0),
    na.rm = TRUE)
  )
    stop("Wind directions can't be outside the interval [0, 360]")

  if (!is.numeric(n_directions) || length(n_directions) != 1)
    stop("n_directions must be a numeric vector of length 1")

  if (!is.numeric(n_speeds) || length(n_speeds) != 1)
    stop("n_speeds must be a numeric vector of length 1")

  if (!is.numeric(calm_wind) || length(calm_wind) != 1)
    stop("calm_wind must be a numeric vector of length 1")

  if ((!is.character(legend_title) && !is.expression(legend_title)) || length(legend_title) != 1)
    stop("Legend title must be a single character string or expression")

  # Directions labels
  if (n_directions < 4){

    n_directions = 4
    dir_break = seq(1, n_directions, n_directions / 4)
    dir_labels = c("N", "E", "S", "W")
    warning("Using the minimum number of wind directions: 4")

  } else if (n_directions == 4){

    n_directions = 4
    dir_break = seq(1, n_directions, 1)
    dir_labels = c("N", "E", "S", "W")

  } else if (n_directions == 8){

    n_directions = 8
    dir_break = seq(1, n_directions, 1)
    dir_labels = c("N", "NE", "E", "SE",
                   "S", "SW", "W", "NW")

  } else if (n_directions == 16){

    n_directions = 16
    dir_break = seq(1, n_directions, 1)
    dir_labels = c("N", "NNE", "NE", "ENE",
                   "E", "ESE", "SE", "SSE",
                   "S", "SSW", "SW", "WSW",
                   "W", "WNW", "NW", "NNW")

  } else {

    n_directions = 8
    dir_labels = c("N", "NE", "E", "SE",
                   "S", "SW", "W", "NW")
    warning("Using number of wind directions: 8")

  }

  if (n_directions > 16){

    n_directions = 16
    warning("Using the maximum number of wind directions: 16")

  }


  if (!missing(speed_cuts) && length(speed_cuts) < 3){

    warning("Using the minimum 3 speed cuts")
    speed_cuts = 3

  }

  # Values for n_directions so that bins center
  # Geometrical sequence function
  geomSeq <- function(start,ratio,begin,end){
    begin=begin-1
    end=end-1
    start*ratio**(begin:end)
  }

  optimal_n_dir = geomSeq(1, 2, 3, 5)

  if (is.na(match(n_directions, optimal_n_dir))){

    n_directions = optimal_n_dir[which.min(abs(n_directions - optimal_n_dir))]
    message("Using the closest optimal number of wind directions (", n_directions, ")")
  }

  if (include_facet)
    facet = facet[not_variable]

  # Factor variable for wind direction intervals
  dir_bin_width = 360 / n_directions
  dir_bin_cuts = seq(dir_bin_width / 2, 360 - dir_bin_width / 2, dir_bin_width)
  dir_intervals = findInterval(c(direction, dir_bin_cuts), dir_bin_cuts)
  dir_intervals[dir_intervals == n_directions] = 0
  factor_labs = paste(c(tail(dir_bin_cuts, 1), head(dir_bin_cuts, -1)), dir_bin_cuts, sep = ", ")
  dir_bin = head(factor(dir_intervals, labels = paste0("(", factor_labs, "]")), -n_directions)

  # Factor variable for wind speed intervals
  if (!missing(speed_cuts)){

    if (speed_cuts[1] > min(speed, na.rm = TRUE))

      speed_cuts = c(0, speed_cuts)

    if (tail(speed_cuts, 1) < max(speed, na.rm = TRUE))

      speed_cuts = c(speed_cuts, max(speed, na.rm = TRUE))

    spd_bin = cut(speed, speed_cuts)

  } else
    spd_bin = cut_interval(speed, n_speeds)

  spd_cols = brewer.pal(length(levels(spd_bin)), col_pal)

  if (length(spd_cols) != length(levels(spd_bin)))

    spd_bin = cut_interval(speed, length(spd_cols))

  # Dataframe suitable for plotting
  if (include_facet){

    ggplot_df = as.data.frame(table(dir_bin, spd_bin, facet))
    ggplot_df$proportion = unlist(by(ggplot_df$Freq, ggplot_df$facet, function(x) x / sum(x)), use.names = FALSE)

  } else {

    ggplot_df = data.frame(table(dir_bin, spd_bin))
    ggplot_df$proportion = ggplot_df$Freq / sum(ggplot_df$Freq)

  }

  ## Draw plot
  windrose_plot = ggplot(data = ggplot_df, aes_string(x = "dir_bin", fill = "spd_bin", y = "proportion")) +
    geom_bar(stat = "identity") +
    scale_x_discrete(breaks = levels(ggplot_df$dir_bin)[seq(1, n_directions, 1)],
                     labels = dir_labels, drop = FALSE) +
    scale_fill_manual(name = legend_title, values = spd_cols) +
    coord_polar(start = 2 * pi - pi / n_directions) +
    scale_y_continuous(labels = percent_format()) +
    theme_minimal() +
    theme(axis.title = element_blank()) +
    labs(title = plot_title)

  if (include_facet)

    windrose_plot = windrose_plot + facet_wrap(~facet, ncol = n_col)

  return(windrose_plot)

}
