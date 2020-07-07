################################################################################################################
# Author: Manuel Pizarro <m.pizarro@csic.es>
# Ecosystem Conservation, IPE (CSIC) <http://www.ipe.csic.es/conservacion-bio/>
# Version: 0.1.0
################################################################################################################

#' @title Warming stripes graph
#' @description Plots diferent "climate stripes" or "warming stripes" (whith labels, background, stripes with line trend and animation). This graphics are visual representations of the change in temperature as measured in each location over the past 70-100+ years. Each stripe represents the temperature in that station averaged over a year.
#'
#' @note "Warming stripes" charts are a conceptual idea of Professor Ed Hawkins (University of Reading) and are specifically designed to be as simple as possible and alert about risks of climate change. For more details see #ShowYourStripes: <https://showyourstripes.info/>
#'
#' @param data a data.frame
#' @param plot_type plot type
#' @param plot_title text
#'
#' @import dplyr
#' @import lubridate
#' @import stringr
#' @import scales
#' @import ggplot2
#' @import ggpubr
#' @import ggthemes
#' @import gtable
#' @import gganimate
#' @import RColorBrewer
#' @import jpeg
#'
#' @return a ggplot image
#' @export
#'
#' @examples \donttest{
#' ggstripes(data, plot_type = "background")
#' }

ggstripes <- function(data, plot_type = c("background", "stripes", "trend", "animation"),
                      plot_title = ""){

  temp <- NULL

  #missing values 999.9
  #summary(data)
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

  # Create pallete
  pal_strip <- brewer.pal(11, "RdBu")
  # brewer.pal.info

  if (plot_type == "stripes"){

    message("Climate stripes plotting ...")

    # Create climate stripes plot with labels
    striplotlab <- ggplot(data, aes(x = date, y = 1, fill = temp)) +
      geom_tile()+
      scale_x_date(date_breaks = "5 years", date_labels = "%Y", expand = c(0, 0),
                   limits = c(min(data$date), max(data$date))) +
      scale_y_continuous(expand = c(0, 0)) +
      scale_fill_gradientn(colors = rev(pal_strip)) +
      guides(fill = guide_colorbar(barwidth = 1)) +
      labs(title = plot_title,
           caption = "Source: Spanish Meteorological Agency (AEMET)") +
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
      labs(fill = "Temp. (C)",
           title = plot_title,
           caption = "Source: Spanish Meteorological Agency (AEMET)") +
      xlab("Date (Years)") + ylab("Temperature (C)") +
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
                   expand = c(0, 0))+
      scale_y_continuous(expand = c(0, 0))+
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
      scale_x_date(date_breaks = "5 years", date_minor_breaks = "5 years", date_labels = "%Y",
                   expand = c(0, 0)) +
      scale_y_continuous(sec.axis = dup_axis(labels = waiver(), name = " "), labels = NULL,
                         limits = c(28.70, 29.70), breaks = c(28.75, 29, 29.25, 29.50, 29.75)) +
      labs(title = plot_title,
           caption = "Source: Spanish Meteorological Agency (AEMET)") +
      xlab("Years") + ylab("Temperature (C)") +
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
