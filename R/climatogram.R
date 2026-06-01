#' Walter & Lieth climatic diagram from normal climatology values
#'
#' @description
#' Plot a Walter & Lieth climatic diagram from normal climatology values for
#' a station. This climatogram is a great way to show a summary of climate
#' conditions for a place over a time period (1981-2010).
#'
#' @family aemet_plots
#' @family climatogram
#'
#' @param labels Character string with month labels for the x-axis: `"en"`
#'   (English), `"es"` (Spanish), `"fr"` (French), etc.
#'
#' @param ggplot2 Logical. If `TRUE`, the function uses
#'   [ggclimat_walter_lieth()]. If `FALSE`, it uses [`climatol::diagwl()`].
#'
#' @param ... Further arguments passed to
#'   [`climatol::diagwl()`] or [ggclimat_walter_lieth()], depending on the
#'   value of \CRANpkg{ggplot2}.
#'
#' @inheritParams climatestripes_station
#'
#' @inheritSection aemet_daily_clim API key
#' @return A plot.
#'
#' @references
#' - Walter, H. K., Harnickell, E., Lieth, F. H. H., & Rehder, H. (1967).
#'   *Klimadiagramm-weltatlas*. Jena: Fischer, 1967.
#' - Guijarro J. A. (2023).
#'   *climatol: Climate Tools (Series Homogenization and Derived Products)*. R
#'   package version 4.0.0, <https://climatol.eu>.
#'
#' @note
#' The code is based on code from the CRAN package \CRANpkg{climatol}.
#'
#' @examplesIf aemet_detect_api_key()
#' climatogram_normal("9434")
#' @export
#' @encoding UTF-8
climatogram_normal <- function(
  station,
  labels = "en",
  verbose = FALSE,
  ggplot2 = TRUE,
  ...
) {
  if (verbose) {
    cli::cli_alert_info("Downloading data, this may take a few seconds.")
  }

  data_raw <- aemet_normal_clim(station, verbose = verbose)

  if (nrow(data_raw) == 0) {
    cli::cli_abort("No valid results from the API.")
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
      cli::cli_abort("{.pkg climatol} is required. Please install it first.")
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

#' Walter & Lieth climatic diagram for a time period
#'
#' @description
#' Plot a Walter & Lieth climatic diagram from monthly climatology values for
#' a station. This climatogram is a great way to show a summary of climate
#' conditions for a place over a specific time period.
#'
#' @family aemet_plots
#' @family climatogram
#'
#' @inheritParams climatogram_normal
#' @inheritParams aemet_monthly_period
#' @inherit climatogram_normal return
#' @inherit climatogram_normal note
#' @inherit climatogram_normal references
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @examplesIf aemet_detect_api_key()
#' \donttest{
#' climatogram_period("9434", start = 2015, end = 2020, labels = "en")
#' }
#' @export
#' @encoding UTF-8

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
  data <- tibble::as_tibble(aggregate(. ~ mes, data, mean))
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
      cli::cli_abort("{.pkg climatol} is required. Please install it first.")
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

#' Walter & Lieth climatic diagram with \CRANpkg{ggplot2}
#'
#' @description
#' Plot a Walter & Lieth climatic diagram for a station. This function is an
#' updated version of [`climatol::diagwl()`], by Jose A. Guijarro.
#'
#' \if{html}{\figure{lifecycle-experimental.svg}{options: alt="[Experimental]"}}
#'
#' @family aemet_plots
#' @family climatogram
#'
#' @param dat Monthly climate data for which the diagram will be plotted.
#'
#' @param est Name of the climatological station.
#'
#' @param alt Altitude of the climatological station.
#'
#' @param per Period used to compute the averages.
#' @param mlab Month labels for the x-axis. Use a 2-digit language code
#'   (`"en"`, `"es"`, etc.). See [`readr::locale()`] for details.
#' @param pcol Color for precipitation.
#' @param tcol Color for temperature.
#' @param pfcol Fill color for probable frosts.
#' @param sfcol Fill color for sure frosts.
#' @param shem Set to `TRUE` for southern hemisphere stations.
#' @param p3line Set to `TRUE` to draw a supplementary precipitation line
#'   relative to three times the temperature (as suggested by Bogdan Rosca).
#' @param ... Further graphic arguments.
#'
#' @inherit climatogram_normal references
#' @inheritSection aemet_daily_clim API key
#'
#' @details
#' See the details in [`climatol::diagwl()`].
#'
#' Climate data must be passed as a 4 x 12 matrix or [data.frame] of monthly
#' data (January to December) in the following order:
#'   - Row 1: Mean precipitation.
#'   - Row 2: Mean maximum daily temperature.
#'   - Row 3: Mean minimum daily temperature.
#'   - Row 4: Absolute monthly minimum temperature.
#'
#' See [climaemet_9434_climatogram] for a sample dataset.
#'
#' @return A \CRANpkg{ggplot2} object. See `help("ggplot2")`.
#'
#' @seealso [`climatol::diagwl()`], [`readr::locale()`]
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
#' @export
#' @encoding UTF-8
#'
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
      "{.arg dat} must have {.code dim(dat)} 4 and 12. ",
      "Input dimensions are {dim(dat)}."
    ))
  }

  # Check for missing data.
  data_na <- as.integer(sum(is.na(dat)))
  if (data_na > 0) {
    cli::cli_abort("Data contains missing values. Unable to plot the diagram.")
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
  dat_long <- tibble::as_tibble(as.data.frame(t(dat)))
  # Normalize names to make them easier to handle.
  names(dat_long) <- c("p_mes", "tm_max", "tm_min", "ta_min")

  dat_long <- dplyr::bind_cols(label = mlab, dat_long)

  # Southern hemisphere
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
  # Number rows.
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
  dat_long_end <- tibble::as_tibble(dat_long_end)
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
    poly <- tibble::tibble(x = xres, y = yres)
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
    line <- tibble::tibble(x = xres, y = yres, ylim_res = ylim_res)
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
  probfreeze <- tibble::tibble(x = x, y = y)
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
  surefreeze <- tibble::tibble(x = x, y = y)

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
  if (max(dat_long_end$pm_reesc) > 50) {
    wandlplot <- wandlplot +
      ggplot2::geom_polygon(data = prep_max_poly, aes(x, y), fill = pcol)
  }

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
