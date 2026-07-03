#' Walter-Lieth climate diagram from climatological normals
#'
#' Plots a Walter-Lieth climate diagram from climatological normal values for a
#' station. The diagram summarizes local climate conditions for 1981–2010.
#'
#' @param labels A character string specifying the language for the x-axis
#'   month labels, such as `"en"` (English), `"es"` (Spanish) or `"fr"`
#'   (French).
#'
#' @param ggplot2 A logical value. If `TRUE`, the function uses
#'   [ggclimat_walter_lieth()]. If `FALSE`, it uses [`climatol::diagwl()`].
#'
#' @param ... Further arguments passed to
#'   [`climatol::diagwl()`] or [ggclimat_walter_lieth()], depending on the
#'   value of `ggplot2`.
#'
#' @inheritParams climatestripes_station
#'
#' @inheritSection aemet_api_key API key
#'
#' @returns A plot produced by [ggclimat_walter_lieth()] or
#'   [climatol::diagwl()], depending on `ggplot2`.
#'
#' @inherit climaemet-package references
#'
#' @seealso [climaemet_9434_climatogram].
#'
#' @family climatogram
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' climatogram_normal("9434")
climatogram_normal <- function(
  station,
  labels = "en",
  verbose = FALSE,
  ggplot2 = TRUE,
  ...
) {
  if (verbose) {
    cli::cli_alert_info("Downloading data. This may take a few seconds.")
  }

  data_raw <- aemet_normal_clim(station, verbose = verbose)

  if (nrow(data_raw) == 0) {
    cli::cli_abort("The AEMET OpenData API returned no valid results.")
  }

  data <- data_raw[c("mes", "p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min")]

  data$mes <- as.numeric(data$mes)
  data <- data[data$mes < 13, ]
  data <- tidyr::pivot_longer(data, 2:5)
  data <- tidyr::pivot_wider(data, names_from = "mes", values_from = "value")
  data <- dplyr::arrange(
    data,
    match("name", c("p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min"))
  )

  # Use row names because climatol expects matrix-like climate tables.
  data <- as.data.frame(data)
  rownames(data) <- data$name
  data <- data[, colnames(data) != "name"]

  stations <- aemet_stations(verbose = verbose)
  stations <- stations[stations$indicativo == station, ]

  if (is.null(labels)) {
    labels <- "en"
  }

  if (ggplot2) {
    ggclimat_walter_lieth(
      data,
      est = stations$nombre,
      alt = stations$altitud,
      per = "1981 - 2010",
      mlab = labels,
      ...
    )
  } else {
    # nocov start
    if (!requireNamespace("climatol", quietly = TRUE)) {
      cli::cli_abort(
        paste0(
          "{.pkg climatol} is required. ",
          "Run {.run install.packages(\"climatol\")}."
        )
      )
    }
    # nocov end

    data <- as.matrix(data)
    data <- unname(data)

    climatol::diagwl(
      data,
      stname = stations$nombre,
      alt = stations$altitud,
      per = "1981 - 2010",
      mlab = labels,
      cols = NULL,
      ...
    )
  }
}

#' Walter-Lieth climate diagram for a time period
#'
#' Plots a Walter-Lieth climate diagram from monthly climatology values for a
#' station over a specified time period.
#'
#' @inheritParams climatogram_normal
#' @inheritParams aemet_monthly_period
#'
#' @inheritSection aemet_api_key API key
#'
#' @inherit climatogram_normal return references seealso
#'
#' @family climatogram
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' \donttest{
#' climatogram_period("9434", start = 2015, end = 2020, labels = "en")
#' }
climatogram_period <- function(
  station = NULL,
  start = 1990,
  end = 2020,
  labels = "en",
  verbose = FALSE,
  ggplot2 = TRUE,
  ...
) {
  data_raw <- aemet_monthly_period(
    station,
    start = start,
    end = end,
    verbose = verbose
  )

  data <- data_raw[c("fecha", "p_mes", "tm_max", "tm_min", "ta_min")]
  data <- tidyr::drop_na(data, c("p_mes", "tm_max", "tm_min", "ta_min"))
  data <- data[-grep("-13", data$fecha, fixed = TRUE), ]

  data$ta_min <- as.double(gsub(
    "\\s*\\([^\\)]+\\)",
    "",
    as.character(data$ta_min)
  ))

  data$fecha <- as.Date(paste0(data$fecha, "-01"), format = "%Y-%m-%d")
  data$mes <- as.integer(format(data$fecha, "%m"))
  data <- data[names(data) != "fecha"]
  data <- dplyr::as_tibble(aggregate(. ~ mes, data, mean))
  data <- tidyr::pivot_longer(data, 2:5)
  data <- tidyr::pivot_wider(data, names_from = "mes", values_from = "value")
  data <- dplyr::arrange(
    data,
    match("name", c("p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min"))
  )

  # Use row names because climatol expects matrix-like climate tables.
  data <- as.data.frame(data)
  rownames(data) <- data$name
  data <- data[, colnames(data) != "name"]

  stations <- aemet_stations(verbose = verbose)
  stations <- stations[stations$indicativo == station, ]

  if (is.null(labels)) {
    labels <- "en"
  }

  if (ggplot2) {
    ggclimat_walter_lieth(
      data,
      est = stations$nombre,
      alt = stations$altitud,
      per = paste(start, "-", end),
      mlab = labels,
      ...
    )
  } else {
    # nocov start
    if (!requireNamespace("climatol", quietly = TRUE)) {
      cli::cli_abort(
        paste0(
          "{.pkg climatol} is required. ",
          "Run {.run install.packages(\"climatol\")}."
        )
      )
    }
    # nocov end

    data <- as.matrix(data)
    data <- unname(data)

    climatol::diagwl(
      data,
      stname = stations$nombre,
      alt = stations$altitud,
      per = paste(start, "-", end),
      mlab = labels,
      cols = NULL,
      ...
    )
  }
}

#' Walter-Lieth climate diagram with \CRANpkg{ggplot2}
#'
#' Plots a Walter-Lieth climate diagram for a station using
#' \CRANpkg{ggplot2}.
#'
#' \if{html}{\figure{lifecycle-experimental.svg}{options: alt="[Experimental]"}}
#'
#' @param dat A data frame containing monthly climatology data.
#'
#' @param est A character string with the climatological station name.
#'
#' @param alt A numeric value with the station altitude in meters.
#'
#' @param per A character string describing the averaging period.
#' @param mlab Month labels for the x-axis. Use a two-letter language code,
#'   such as `"en"` or `"es"`. See [`readr::locale()`] for details.
#' @param pcol A color for precipitation.
#' @param tcol A color for temperature.
#' @param pfcol A fill color for probable frosts.
#' @param sfcol A fill color for certain frosts.
#' @param shem A logical value. If `TRUE`, plots a Southern Hemisphere station.
#' @param p3line Set to `TRUE` to draw a supplementary precipitation line
#'   relative to three times the temperature (as suggested by Bogdan Rosca).
#' @param ... Further graphic arguments.
#'
#' @details
#' See the details in [`climatol::diagwl()`].
#'
#' Climatology data must be passed as a 4 by 12 matrix or data frame of monthly
#' data from January to December. Rows must contain mean precipitation, mean
#' maximum daily temperature, mean minimum daily temperature and absolute
#' monthly minimum temperature, in that order.
#'
#' See [climaemet_9434_climatogram] for a sample dataset.
#'
#' @returns A [ggplot2::ggplot()] object.
#'
#' @inherit climatogram_normal references seealso
#'
#' @seealso
#' - [climatol::diagwl()] provides the original diagram implementation.
#' - [readr::locale()] provides language-specific month labels.
#'
#' @family climatogram
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#'
#' library(ggplot2)
#'
#' wl <- ggclimat_walter_lieth(
#'   climaemet::climaemet_9434_climatogram,
#'   alt = "249",
#'   per = "1981-2010",
#'   est = "Zaragoza Airport"
#' )
#'
#' wl
#'
#' # Since it is a ggplot object, we can modify it.
#'
#' wl + theme(
#'   plot.background = element_rect(fill = "grey80"),
#'   panel.background = element_rect(fill = "grey70"),
#'   axis.text.y.left = element_text(
#'     colour = "black",
#'     face = "italic"
#'   ),
#'   axis.text.y.right = element_text(
#'     colour = "black",
#'     face = "bold"
#'   )
#' )
ggclimat_walter_lieth <- function(
  dat,
  est = "",
  alt = NA,
  per = NA,
  mlab = "es",
  pcol = "#002F70",
  tcol = "#ff0000",
  pfcol = "#9BAEE2",
  sfcol = "#3C6FC4",
  shem = FALSE,
  p3line = FALSE,
  ...
) {
  ## Validate inputs ----

  if (!all(dim(dat) == c(4, 12))) {
    cli::cli_abort(paste0(
      "{.arg dat} must have dimensions {.code 4 x 12}, ",
      "not {.code {paste(dim(dat), collapse = ' x ')}}."
    ))
  }

  # Check for missing data.
  data_na <- as.integer(sum(is.na(dat)))
  if (data_na > 0) {
    cli::cli_abort(
      "Cannot plot the diagram because {.arg dat} contains missing values."
    )
  }

  # Transform matrix inputs to data frames.
  if (is.matrix(dat)) {
    dat <- as.data.frame(
      dat,
      row.names = c("p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min"),
      col.names = paste0("m", seq_len(12))
    )
  }

  ## Transform data ----
  # Create month labels.
  mlab <- toupper(substr(readr::locale(mlab)$date_names$mon, 1, 1))

  # Pivot the table and create tidy data.
  dat_long <- dplyr::as_tibble(as.data.frame(t(dat)))
  # Normalize names to make them easier to handle.
  names(dat_long) <- c("p_mes", "tm_max", "tm_min", "ta_min")

  dat_long <- dplyr::bind_cols(label = mlab, dat_long)

  # Reorder months for the Southern Hemisphere.
  if (shem) {
    dat_long <- rbind(dat_long[7:12, ], dat_long[1:6, ])
  }

  # Calculate mean temperature.
  dat_long$tm <- (dat_long[[3]] + dat_long[[4]]) / 2

  # Rescale monthly precipitation.
  dat_long$pm_reesc <- ifelse(
    dat_long$p_mes < 100,
    dat_long$p_mes * 0.5,
    dat_long$p_mes * 0.05 + 45
  )

  # Add the supplementary precipitation line.
  dat_long$p3line <- dat_long$p_mes / 3

  # Add the first and last rows for plotting.
  dat_long <- dplyr::bind_rows(
    dat_long[nrow(dat_long), ],
    dat_long,
    dat_long[1, ]
  )

  dat_long[c(1, nrow(dat_long)), "label"] <- ""

  # Interpolate values to expand the x range.
  # Add row indices.
  dat_long <- cbind(indrow = seq(-0.5, 12.5, 1), dat_long)
  dat_long_int <- NULL

  for (j in seq(nrow(dat_long) - 1)) {
    intres <- NULL

    for (i in seq_len(ncol(dat_long))) {
      if (is.character(dat_long[j, i])) {
        # Do not interpolate character values.
        val <- as.data.frame(dat_long[j, i])
      } else {
        # Interpolate numeric values.
        interpol <- approx(
          x = dat_long[c(j, j + 1), 1],
          y = dat_long[c(j, j + 1), i],
          n = 50
        )
        val <- as.data.frame(interpol$y) # Keep only the interpolated value.
      }
      names(val) <- names(dat_long)[i]
      intres <- dplyr::bind_cols(intres, val)
    }

    dat_long_int <- dplyr::bind_rows(dat_long_int, intres)
  }

  # Regenerate and filter values.
  dat_long_int$interpolate <- TRUE
  dat_long_int$label <- ""
  dat_long$interpolate <- FALSE
  dat_long_int <- dat_long_int[!dat_long_int$indrow %in% dat_long$indrow, ]
  dat_long_end <- dplyr::bind_rows(dat_long, dat_long_int)
  dat_long_end <- dat_long_end[order(dat_long_end$indrow), ]
  dat_long_end <- dat_long_end[
    dat_long_end$indrow >= 0 & dat_long_end$indrow <= 12,
  ]
  dat_long_end <- dplyr::as_tibble(dat_long_end)
  # Final tibble with normalized and helper values.

  # Labels and axes ----

  ## Horizontal axis ----
  month_breaks <- dat_long_end[dat_long_end$label != "", ]$indrow
  month_labs <- dat_long_end[dat_long_end$label != "", ]$label

  ## Vertical axis range: temperature ----
  ymax <- max(60, 10 * floor(max(dat_long_end$pm_reesc) / 10) + 10)

  # Minimum range.
  ymin <- min(-3, min(dat_long_end$tm)) # min Temp
  range_tm <- seq(0, ymax, 10)

  if (ymin < -3) {
    ymin <- floor(ymin / 10) * 10 # Rounded minimum temperature.
    # Build labels.
    range_tm <- seq(ymin, ymax, 10)
  }

  # Build labels.
  templabs <- paste0(range_tm)
  templabs[range_tm > 50] <- ""

  # Vertical axis range: precipitation.
  range_prec <- range_tm * 2
  range_prec[range_tm > 50] <- range_tm[range_tm > 50] * 20 - 900
  preclabs <- paste0(range_prec)
  preclabs[range_tm < 0] <- ""

  ## Titles and additional labels ----
  title <- est

  if (!is.na(alt)) {
    title <- paste0(
      title,
      " (",
      prettyNum(alt, big.mark = ",", decimal.mark = "."),
      " m)"
    )
  }

  if (!is.na(per)) {
    title <- paste0(title, "\n", per)
  }

  # Build subtitles.
  sub <- paste(
    round(mean(dat_long_end[dat_long_end$interpolate == FALSE, ]$tm), 1),
    "C        ",
    prettyNum(
      round(sum(dat_long_end[dat_long_end$interpolate == FALSE, ]$p_mes)),
      big.mark = ","
    ),
    " mm",
    sep = ""
  )

  # Vertical tags.
  maxtm <- prettyNum(round(max(dat_long_end$tm_max), 1))
  mintm <- prettyNum(round(min(dat_long_end$tm_min), 1))

  tags <- paste0(
    paste0(rep(" \n", 6), collapse = ""),
    maxtm,
    paste0(rep(" \n", 10), collapse = ""),
    mintm
  )

  # Helper for ticks.

  ticks <- data.frame(x = seq(0, 12), ymin = -3, ymax = 0)

  # Lines and additional areas ----
  getpolymax <- function(x, y, y_lim) {
    initpoly <- FALSE
    yres <- NULL
    xres <- NULL

    # Determine where to draw polygons.
    # nocov start
    for (i in seq_along(y)) {
      lastobs <- i == length(x)

      # Start or continue a polygon when the value exceeds the limit.
      if (y[i] > y_lim[i]) {
        if (isFALSE(initpoly)) {
          # Initialise the polygon if needed.
          xres <- c(xres, x[i])
          yres <- c(yres, y_lim[i])
          initpoly <- TRUE
        }
        xres <- c(xres, x[i])
        yres <- c(yres, y[i])

        # Close the polygon on the last observation.
        if (lastobs) {
          xres <- c(xres, x[i], NA)
          yres <- c(yres, y_lim[i], NA)
        }
      } else {
        # Close the polygon.
        if (initpoly) {
          xres <- c(xres, x[i - 1], NA)
          yres <- c(yres, y_lim[i - 1], NA)
          initpoly <- FALSE
        }
      }
    }
    # nocov end
    poly <- dplyr::tibble(x = xres, y = yres)
    poly
  }

  getlines <- function(x, y, y_lim) {
    yres <- NULL
    xres <- NULL
    ylim_res <- NULL

    # Determine where to draw lines.
    for (i in seq_along(y)) {
      # Add points when the value exceeds the limit.
      if (y[i] > y_lim[i]) {
        xres <- c(xres, x[i])
        yres <- c(yres, y[i])
        ylim_res <- c(ylim_res, y_lim[i])
      }
    }
    line <- dplyr::tibble(x = xres, y = yres, ylim_res = ylim_res)
    line
  }

  prep_max_poly <- getpolymax(
    x = dat_long_end$indrow,
    y = pmax(dat_long_end$pm_reesc, 50),
    y_lim = rep(50, length(dat_long_end$indrow))
  )

  tm_max_line <- getlines(
    x = dat_long_end$indrow,
    y = dat_long_end$tm,
    y_lim = dat_long_end$pm_reesc
  )

  pm_max_line <- getlines(
    x = dat_long_end$indrow,
    y = pmin(dat_long_end$pm_reesc, 50),
    y_lim = dat_long_end$tm
  )

  # Probable frost.
  dat_real <- dat_long_end[!dat_long_end$interpolate, c("indrow", "ta_min")]
  x <- NULL
  y <- NULL
  for (i in seq_len(nrow(dat_real))) {
    if (dat_real[i, ]$ta_min < 0) {
      x <- c(
        x,
        NA,
        rep(dat_real[i, ]$indrow - 0.5, 2),
        rep(dat_real[i, ]$indrow + 0.5, 2),
        NA
      )
      y <- c(y, NA, -3, 0, 0, -3, NA)
    } else {
      x <- c(x, NA)
      y <- c(y, NA)
    }
  }
  probfreeze <- dplyr::tibble(x = x, y = y)
  rm(dat_real)
  # Definite frost.
  dat_real <- dat_long_end[!dat_long_end$interpolate, c("indrow", "tm_min")]

  x <- NULL
  y <- NULL
  for (i in seq_len(nrow(dat_real))) {
    if (dat_real[i, ]$tm_min < 0) {
      x <- c(
        x,
        NA,
        rep(dat_real[i, ]$indrow - 0.5, 2),
        rep(dat_real[i, ]$indrow + 0.5, 2),
        NA
      )
      y <- c(y, NA, -3, 0, 0, -3, NA)
    } else {
      x <- c(x, NA)
      y <- c(y, NA)
    }
  }
  surefreeze <- dplyr::tibble(x = x, y = y)

  # Start plotting ----
  # Add basic lines and segments.
  wandlplot <- ggplot2::ggplot() +
    ggplot2::geom_line(
      data = dat_long_end,
      aes(x = .data$indrow, y = .data$pm_reesc),
      color = pcol
    )

  # Probable frost.

  if (min(dat_long_end$ta_min) < 0) {
    wandlplot <- wandlplot +
      ggplot2::geom_polygon(
        data = probfreeze,
        aes(x = x, y = y),
        fill = pfcol,
        colour = "black"
      )
  }

  # Definite frost.

  if (min(dat_long_end$tm_min) < 0) {
    wandlplot <- wandlplot +
      geom_polygon(
        data = surefreeze,
        aes(x = x, y = y),
        fill = sfcol,
        colour = "black"
      )
  }
  wandlplot <- wandlplot +
    ggplot2::geom_line(
      data = dat_long_end,
      aes(x = .data$indrow, y = .data$tm),
      color = tcol
    )

  if (nrow(tm_max_line > 0)) {
    wandlplot <- wandlplot +
      ggplot2::geom_segment(
        aes(x = .data$x, y = .data$ylim_res, xend = .data$x, yend = .data$y),
        data = tm_max_line,
        color = tcol,
        alpha = 0.2
      )
  }

  if (nrow(pm_max_line > 0)) {
    wandlplot <- wandlplot +
      ggplot2::geom_segment(
        aes(x = .data$x, y = .data$ylim_res, xend = .data$x, yend = .data$y),
        data = pm_max_line,
        color = pcol,
        alpha = 0.2
      )
  }
  if (p3line) {
    wandlplot <- wandlplot +
      ggplot2::geom_line(
        data = dat_long_end,
        aes(x = .data$indrow, y = .data$p3line),
        color = pcol
      )
  }

  # Add polygons.

  # Maximum precipitation.
  # nocov start
  if (max(dat_long_end$pm_reesc) > 50) {
    wandlplot <- wandlplot +
      ggplot2::geom_polygon(data = prep_max_poly, aes(x, y), fill = pcol)
  }
  # nocov end

  # Add lines and scales to the chart.
  wandlplot <- wandlplot +
    geom_hline(yintercept = c(0, 50), linewidth = 0.5) +
    geom_segment(data = ticks, aes(x = x, xend = x, y = ymin, yend = ymax)) +
    scale_x_continuous(
      breaks = month_breaks,
      name = "",
      labels = month_labs,
      expand = c(0, 0)
    ) +
    scale_y_continuous(
      "C",
      limits = c(ymin, ymax),
      labels = templabs,
      breaks = range_tm,
      sec.axis = dup_axis(name = "mm", labels = preclabs)
    )

  # Add tags and theme.
  wandlplot <- wandlplot +
    ggplot2::labs(title = title, subtitle = sub, tag = tags) +
    ggplot2::theme_classic() +
    ggplot2::theme(
      plot.title = element_text(lineheight = 1, size = 14, face = "bold"),
      plot.subtitle = element_text(hjust = 1, vjust = 1, size = 14),
      plot.tag = element_text(size = 10),
      plot.tag.position = "left",
      axis.ticks.length.x.bottom = unit(0, "pt"),
      axis.line.x.bottom = element_blank(),
      axis.title.y.left = element_text(
        angle = 0,
        vjust = 0.9,
        size = 10,
        colour = tcol,
        margin = ggplot2::margin(10, 10, 10, 10)
      ),
      axis.text.x.bottom = element_text(size = 10),
      axis.text.y.left = element_text(colour = tcol, size = 10),
      axis.title.y.right = element_text(
        angle = 0,
        vjust = 0.9,
        size = 10,
        colour = pcol,
        margin = ggplot2::margin(10, 10, 10, 10)
      ),
      axis.text.y.right = element_text(colour = pcol, size = 10)
    )

  wandlplot
}
