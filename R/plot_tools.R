##############################################################################
# Author: Manuel Pizarro <m.pizarro@csic.es>
# Ecosystem Conservation, IPE (CSIC) <http://www.ipe.csic.es/conservacion-bio/>
# Version: 0.2.0
#############################################################################

#' Warming stripes graph
#'
#' @concept aemet_plots
#'
#' @description
#' Plot different "climate stripes" or "warming stripes" using \pkg{ggplot2}.
#' This graphics are visual representations of the change in temperature as
#' measured in each location over the past 70-100+ years. Each stripe
#' represents the temperature in that station averaged over a year.
#'
#' @section Palette selection:
#' Any of the sequential [hcl.pals()] colour palettes are recommended for
#' colour plots.
#'
#' @note "Warming stripes" charts are a conceptual idea of Professor Ed Hawkins
#' (University of Reading) and are specifically designed to be as simple as
#' possible and alert about risks of climate change. For more details see
#' [ShowYourStripes](https://showyourstripes.info/).
#'
#' @param data a data.frame with date(year) and temperature(temp) variables.
#' @param plot_type plot type (with labels, background, stripes with line
#'   trend and animation). Accepted values are "background", "stripes",
#'   "trend" or "animation".
#' @param plot_title character string to be used for the graph title.
#'
#' @param n_temp Numeric value as the number of colors of the palette.
#'   (default 11).
#'
#' @param col_pal Character string indicating the name of the
#'   [hcl.pals()] colour palette to be used for plotting, see
#'   **Palette selection**.
#' @param ... further arguments passed to \code{\link[ggplot2]{theme}}.
#'
#' @seealso [`ggplot2::theme()`] for more possible arguments to pass to
#'  `ggstripes`.
#'
#'
#' @return a `ggplot2` object
#'
#' @examples
#' \dontrun{
#' ggstripes(data, plot_type = "background")
#' }
#'
#' @export

ggstripes <-
  function(data,
           plot_type = "stripes",
           plot_title = "",
           n_temp = 11,
           col_pal = "RdBu",
           ...) {
    if (!is.numeric(n_temp)) {
      stop("`n_temp` needs to be numeric")
    }

    if (!plot_type %in% c("background", "stripes", "trend", "animation")) {
      stop(
        "`plot_type` should be one of 'background', ",
        "'stripes', 'trend', 'animation'"
      )
    }

    if (!col_pal %in% hcl.pals()) {
      stop("`col_pal` should be one of the palettes defined on `hc.pals()`")
    }

    if (!"temp" %in% names(data) || !"year" %in% names(data)) {
      stop("`data` must have  `year` and `temp` cols. ")
    }


    # Missing values 999.9
    data <-
      dplyr::mutate(data, temp = ifelse(data$temp == 999.9, NA, data$temp))

    # Formatting dates
    data <-
      dplyr::mutate(data, date = as.Date(first_day_of_year(data$year)))

    # Create themes
    theme_strip <- ggplot2::theme_minimal() +
      ggplot2::theme(
        axis.text.y = element_blank(),
        axis.line.y = element_blank(),
        axis.title = element_blank(),
        panel.grid.major = element_blank(),
        legend.title = element_blank(),
        axis.text.x = element_text(vjust = 3),
        panel.grid.minor = element_blank(),
        plot.title = element_text(size = 14, face = "bold"),
        plot.margin = ggplot2::unit(rep(15, 4), "pt"),
        plot.caption = element_text(margin = ggplot2::unit(rep(3, 4), "pt"))
      )

    theme_striptrend <- ggplot2::theme_minimal() +
      ggplot2::theme(
        axis.text.x = element_text(
          face = "plain",
          color = "black",
          size = 11
        ),
        axis.text.y = element_text(
          face = "plain",
          color = "black",
        ),
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(
          face = "bold",
          vjust = 1
        ),
        plot.title = element_text(size = 14, face = "bold"),
        legend.background = element_rect(
          fill = "white",
          size = 0.5,
          linetype = "solid",
          colour = "black"
        ),
        plot.caption = element_text(
          color = "black",
          face = "plain",
          size = 12,
          margin = ggplot2::unit(rep(3, 4), "pt")
        ),
        plot.margin = ggplot2::unit(rep(15, 4), "pt")
      )

    # Create palette
    pal_strip <- hcl.colors(n_temp, col_pal)


    if (plot_type == "stripes") {
      message("Climate stripes plotting ...")

      # Create climate stripes plot with labels----
      striplotlab <-
        ggplot(data, aes(
          x = .data$date,
          y = 1,
          fill = .data$temp
        )) +
        ggplot2::geom_tile() +
        ggplot2::scale_x_date(
          date_breaks = "5 years",
          date_labels = "%Y",
          expand = c(0, 0),
          limits = c(min(data$date), max(data$date))
        ) +
        ggplot2::scale_y_continuous(expand = c(0, 0)) +
        ggplot2::scale_fill_gradientn(colors = rev(pal_strip)) +
        ggplot2::guides(fill = ggplot2::guide_colorbar(barwidth = 1)) +
        ggplot2::labs(
          title = plot_title,
          caption = "Source: Spanish Meteorological Agency (AEMET)"
        ) +
        theme_strip

      # Draw plot
      return(striplotlab)
    } else if (plot_type == "trend") {
      message("Climate stripes with temperature line trend plotting ...")

      # Create climate stripes plot with line trend----
      stripbackground <-
        ggplot(data, aes(
          x = .data$date,
          y = 1,
          fill = .data$temp
        )) +
        ggplot2::geom_tile(show.legend = FALSE) +
        ggplot2::scale_x_date(
          date_breaks = "5 years",
          date_labels = "%Y",
          expand = c(0, 0)
        ) +
        scale_y_continuous(expand = c(0, 0)) +
        ggplot2::scale_fill_gradientn(
          colors = rev(pal_strip),
          na.value = "lightgrey"
        ) +
        ggplot2::guides(fill = ggplot2::guide_colorbar(barwidth = 1)) +
        ggplot2::theme_void()

      # Save plot as image on temporary directory
      ggplot2::ggsave(
        plot = stripbackground,
        filename = "stripbrackground.jpeg",
        path = tempdir(),
        device = "jpeg",
        scale = 1,
        width = 210,
        height = 150,
        units = "mm",
        dpi = 150,
        limitsize = TRUE
      )
      # Read stripes plot for background

      background <-
        jpeg::readJPEG(file.path(tempdir(), "stripbrackground.jpeg"))

      m <- mean(data$temp, na.rm = TRUE)

      striplotrend <-
        ggplot(data, aes(x = date, y = .data$temp)) +
        ggplot2::geom_tile(aes(
          x = .data$date,
          y = m,
          fill = .data$temp
        )) +
        # Overwrite with jpeg
        ggplot2::annotation_raster(background, -Inf, Inf, -Inf, Inf) +
        geom_line(aes(y = .data$temp),
          color = "black",
          size = 1
        ) +
        ggplot2::geom_smooth(
          method = "gam",
          formula = y ~ s(x),
          color = "yellow",
          fill = "black"
        ) +
        scale_y_continuous(expand = c(0, 0)) +
        ggplot2::scale_x_date(
          date_breaks = "5 years",
          date_labels = "%Y",
          expand = c(0, 0),
          limits = c(min(data$date), max(data$date))
        ) +
        ggplot2::scale_fill_gradientn(colors = rev(pal_strip)) +
        ggplot2::guides(fill = ggplot2::guide_colorbar(barwidth = 1)) +
        ggplot2::labs(
          fill = "Temp. (C)",
          title = plot_title,
          caption = "Source: Spanish Meteorological Agency (AEMET)"
        ) +
        ggplot2::xlab("Date (Year)") +
        ggplot2::ylab("Temperature (C)") +
        theme_striptrend

      # Draw plot
      return(striplotrend)
    } else if (plot_type == "background") {
      message("Climate stripes background plotting ...")

      # Create climate stripes background----
      stripbackground <-
        ggplot(data, aes(
          x = .data$date,
          y = 1,
          fill = .data$temp
        )) +
        ggplot2::geom_tile(show.legend = FALSE) +
        ggplot2::scale_x_date(
          date_breaks = "5 years",
          date_labels = "%Y",
          expand = c(0, 0)
        ) +
        scale_y_continuous(expand = c(0, 0)) +
        ggplot2::scale_fill_gradientn(
          colors = rev(pal_strip),
          na.value = "lightgrey"
        ) +
        ggplot2::guides(fill = ggplot2::guide_colorbar(barwidth = 1)) +
        ggplot2::theme_void()

      # Draw plot
      return(stripbackground)
    } else {
      message("Climate stripes animation ...")

      # Create climate stripes plot animation----
      # Create climate stripes background
      if (!requireNamespace("jpeg", quietly = TRUE)) {
        stop("\n\npackage jpeg required, please install it first")
      }

      if (!requireNamespace("gganimate", quietly = TRUE)) {
        stop("\n\npackage gganimate required, please install it first")
      }


      stripbackground <-
        ggplot(data, aes(
          x = .data$date,
          y = 1,
          fill = .data$temp
        )) +
        ggplot2::geom_tile(show.legend = FALSE) +
        ggplot2::scale_x_date(
          date_breaks = "5 years",
          date_labels = "%Y",
          expand = c(0, 0)
        ) +
        scale_y_continuous(expand = c(0, 0)) +
        ggplot2::scale_fill_gradientn(
          colors = rev(pal_strip),
          na.value = "lightgrey"
        ) +
        ggplot2::guides(fill = ggplot2::guide_colorbar(barwidth = 1)) +
        ggplot2::theme_void()

      # Save plot as image on temporary directory
      ggplot2::ggsave(
        plot = stripbackground,
        filename = "stripbrackground.jpeg",
        path = tempdir(),
        device = "jpeg",
        scale = 1,
        width = 210,
        height = 150,
        units = "mm",
        dpi = 150,
        limitsize = TRUE
      )
      # Read stripes plot for background

      background <-
        jpeg::readJPEG(file.path(tempdir(), "stripbrackground.jpeg"))

      striplotanimation <-
        ggplot(data, aes(x = .data$date, y = .data$temp)) +
        ggplot2::annotation_raster(background, -Inf, Inf, -Inf, Inf) +
        geom_line(size = 1.5, color = "yellow") +
        ggplot2::scale_x_date(
          date_breaks = "5 years",
          date_minor_breaks = "5 years",
          date_labels = "%Y",
          expand = c(0, 0)
        ) +
        scale_y_continuous(
          sec.axis = dup_axis(labels = ggplot2::waiver(), name = " "),
          labels = NULL
        ) +
        ggplot2::labs(
          title = plot_title,
          caption = "Source: Spanish Meteorological Agency (AEMET)"
        ) +
        ggplot2::xlab("Year") +
        ggplot2::ylab("Temperature (C)") +
        theme_striptrend +
        gganimate::transition_reveal(date)

      # Draw plot
      return(striplotanimation)

      message("Done! ... Read gganimate::animate help for save plot")
    }

    # Clear environment except function
    rm(list = ls(all.names = TRUE))
  }
