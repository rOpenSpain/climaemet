#' Station climate stripes graph
#'
#' Plot climate stripes graph for a station.
#'
#' @family aemet_plots
#' @family stripes
#'
#' @rdname climatestripes_station
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @param with_labels Character string as yes/no. Indicates whether to use
#'   labels for the graph or not.
#'
#' @inheritDotParams ggstripes -data -plot_type -plot_title
#'
#' @inheritParams aemet_monthly_period
#'
#' @return A \CRANpkg{ggplot2} object
#'
#' @seealso [ggstripes()]
#'
#' @examplesIf aemet_detect_api_key()
#' \donttest{
#'
#' # Don't run example
#' if (FALSE) {
#'   # Data download may take a few minutes...
#'   climatestripes_station(
#'     "9434",
#'     start = 2020,
#'     end = 2024,
#'     with_labels = "yes",
#'     col_pal = "Inferno"
#'   )
#' }
#' }
#' @export
climatestripes_station <- function(
  station,
  start = 1950,
  end = 2020,
  with_labels = "yes",
  verbose = FALSE,
  ...
) {
  cli::cli_alert_info("Data download may take a few seconds ... please wait.")

  data_raw <- aemet_monthly_period(
    station,
    start = start,
    end = end,
    verbose = verbose
  )

  if (nrow(data_raw) == 0) {
    cli::cli_abort("No valid results from the API") # nocov
  }

  data <- data_raw[c("fecha", "indicativo", "tm_mes")]
  data <- data[!is.na(data$tm_mes), ]
  data <- data[grep("-13", data$fecha, fixed = TRUE), ]
  data <- dplyr::rename(data, year = "fecha", temp = "tm_mes")
  data <- dplyr::mutate(
    data,
    temp = as.numeric(data$temp),
    year = as.integer(gsub("-13", "", data$year, fixed = TRUE))
  )

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

  if (is.null(with_labels)) {
    with_labels <- "yes"
  }

  if (with_labels == "no") {
    ggstripes(data, plot_type = "background")
  } else {
    ggstripes(data, plot_type = "stripes", plot_title = title, ...)
  }
}

#' Warming stripes graph
#'
#' @family aemet_plots
#' @family stripes
#'
#' @description
#' Plot different "climate stripes" or "warming stripes" using
#' \CRANpkg{ggplot2}. This graphics are visual representations of the change
#' in temperature as measured in each location over the past 70-100+ years. Each
#' stripe represents the temperature in that station averaged over a year.
#'
#' @note "Warming stripes" charts are a conceptual idea of Professor Ed Hawkins
#' (University of Reading) and are specifically designed to be as simple as
#' possible and alert about risks of climate change. For more details see
#' [ShowYourStripes](https://showyourstripes.info/).
#'
#' @param data a data.frame with date(`year`) and temperature(`temp`) variables.
#' @param plot_type plot type (with labels, background, stripes with line
#'   trend and animation). Accepted values are `"background"`, `"stripes"`,
#'   `"trend"` or `"animation"`.
#'
#' @param plot_title character string to be used for the graph title.
#'
#' @param n_temp Numeric value as the number of colors of the palette.
#'   (default `11`).
#'
#' @param col_pal Character string indicating the name of the
#'   [hcl.pals()] color palette to be used for plotting.
#'
#' @param ... further arguments passed to [ggplot2::theme()].
#'
#' @seealso [climatestripes_station()], [`ggplot2::theme()`] for more possible
#'  arguments to pass to `ggstripes`.
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @return A \CRANpkg{ggplot2} object
#'
#' @examples
#' \donttest{
#' library(ggplot2)
#'
#' data <- climaemet::climaemet_9434_temp
#'
#' ggstripes(data, plot_title = "Zaragoza Airport") +
#'   labs(subtitle = "(1950-2020)")
#'
#' ggstripes(data, plot_title = "Zaragoza Airport", plot_type = "trend") +
#'   labs(subtitle = "(1950-2020)")
#' }
#' @export
ggstripes <- function(
  data,
  plot_type = "stripes",
  plot_title = "",
  n_temp = 11,
  col_pal = "RdBu",
  ...
) {
  if (!is.numeric(n_temp)) {
    cli::cli_abort(
      "{.arg n_temp} needs to be numeric, not {.obj_type_friendly {n_temp}}."
    )
  }

  valid_types <- c("background", "stripes", "trend", "animation") # nolint
  if (!plot_type %in% c("background", "stripes", "trend", "animation")) {
    cli::cli_abort(
      paste0(
        "{.arg plot_type} should be one of {.val {valid_types}}, ",
        "not {.val {plot_type}}."
      )
    )
  }

  if (!col_pal %in% hcl.pals()) {
    cli::cli_abort(
      paste0(
        "{.arg col_pal} should be one of the palettes ",
        "defined on {.fn grDevices::hcl.pals}."
      )
    )
  }

  if (!"temp" %in% names(data) || !"year" %in% names(data)) {
    cli::cli_abort("{.arg data} must have  {.str year} and {.str temp} cols.")
  }

  # Missing values 999.9
  data <- dplyr::mutate(data, temp = ifelse(data$temp == 999.9, NA, data$temp))

  # Formatting dates
  data <- dplyr::mutate(data, date = as.Date(first_day_of_year(data$year)))

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
      plot.margin = ggplot2::margin(15, 15, 15, 15),
      plot.caption = element_text(margin = ggplot2::margin(3, 3, 3, 3))
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
        linewidth = 0.5,
        linetype = "solid",
        colour = "black"
      ),
      plot.caption = element_text(
        color = "black",
        face = "plain",
        size = 12,
        margin = ggplot2::margin(3, 3, 3, 3)
      ),
      plot.margin = ggplot2::margin(15, 15, 15, 15)
    )

  # Create palette
  pal_strip <- hcl.colors(n_temp, col_pal)

  if (plot_type == "stripes") {
    cli::cli_alert_info("Climate stripes plotting ...")

    # Create climate stripes plot with labels----
    striplotlab <- ggplot(
      data,
      aes(x = .data$date, y = 1, fill = .data$temp)
    ) +
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
    striplotlab

    # nocov start
  } else if (plot_type == "trend") {
    cli::cli_alert_info(
      "Climate stripes with temperature line trend plotting ..."
    )

    # Create climate stripes plot with line trend----
    stripbackground <- ggplot(
      data,
      aes(x = .data$date, y = 1, fill = .data$temp)
    ) +
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

    background <- jpeg::readJPEG(file.path(tempdir(), "stripbrackground.jpeg"))

    m <- mean(data$temp, na.rm = TRUE)

    striplotrend <- ggplot(data, aes(x = .data$date, y = .data$temp)) +
      ggplot2::geom_tile(aes(x = .data$date, y = m, fill = .data$temp)) +
      # Overwrite with jpeg
      ggplot2::annotation_raster(
        background,
        min(data$date),
        max(data$date),
        -Inf,
        Inf
      ) +
      geom_line(aes(y = .data$temp), color = "black", linewidth = 1) +
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
      ggplot2::labs(x = "Date (Year)", y = "Temperature (C)") +
      theme_striptrend

    # Draw plot
    striplotrend
  } else if (plot_type == "background") {
    cli::cli_alert_info("Climate stripes background plotting ...")

    # Create climate stripes background----
    stripbackground <- ggplot(
      data,
      aes(x = .data$date, y = 1, fill = .data$temp)
    ) +
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
    stripbackground
  } else {
    cli::cli_alert_info("Climate stripes animation ...")

    # Create climate stripes plot animation----
    # Create climate stripes background
    if (!requireNamespace("jpeg", quietly = TRUE)) {
      cli::cli_abort("package {.pkg jpeg} required, please install it first.")
    }

    if (!requireNamespace("gganimate", quietly = TRUE)) {
      cli::cli_abort(
        "package {.pkg gganimate} required, please install it first."
      )
    }

    stripbackground <- ggplot(
      data,
      aes(x = .data$date, y = 1, fill = .data$temp)
    ) +
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

    background <- jpeg::readJPEG(file.path(tempdir(), "stripbrackground.jpeg"))

    striplotanimation <- ggplot(data, aes(x = .data$date, y = .data$temp)) +
      ggplot2::annotation_raster(background, -Inf, Inf, -Inf, Inf) +
      geom_line(linewidth = 1.5, color = "yellow") +
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
      ggplot2::labs(x = "Year", y = "Temperature (C)") +
      theme_striptrend +
      gganimate::transition_reveal(date)

    cli::cli_alert_success("Done! See {.fn gganimate::anim_save} for save plot")

    # Draw plot
    striplotanimation
  }

  # nocov end
}

#' @export
#' @rdname climatestripes_station
#' @usage NULL
ggstripes_station <- climatestripes_station
