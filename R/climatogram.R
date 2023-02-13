#' Walter & Lieth climatic diagram from normal climatology values
#'
#' @description
#' Plot of a Walter & Lieth climatic diagram from normal climatology data for
#' a station. This climatogram are great for showing a summary of climate
#' conditions for a place over a time period (1981-2010).
#'
#' @family aemet_plots
#' @family climatogram
#'
#' @param labels Character string as month labels for the X axis: "en"
#' (english), "es" (spanish), "fr" (french), etc.
#'
#' @param ggplot2 `TRUE/FALSE`. On `TRUE` the function uses
#'   [ggclimat_walter_lieth()], if `FALSE` uses [`climatol::diagwl()`].
#'
#' @param ... Further arguments to
#'   [`climatol::diagwl()`] or [ggclimat_walter_lieth()], depending on the
#'   value of `ggplot2`
#'
#' @inheritParams climatestripes_station
#'
#' @inheritSection aemet_daily_clim API Key

#' @note The code is based on code from the CRAN package "climatol" by Jose A.
#' Guijarro <jguijarrop@aemet.es>.
#'
#'
#' @references
#' Walter, H. & Lieth, H (1960): Klimadiagramm Weltatlas. G. Fischer, Jena.
#'
#' @return A plot.
#'
#' @examplesIf aemet_detect_api_key()
#' climatogram_normal("9434")
#' @export
climatogram_normal <- function(station,
                               labels = "en",
                               verbose = FALSE,
                               ggplot2 = TRUE,
                               ...) {
  if (verbose) {
    message("Data download may take a few seconds ... please wait \n")
  }

  data_raw <-
    aemet_normal_clim(station, verbose = verbose)

  if (nrow(data_raw) == 0) {
    stop("No valid results from the API")
  }

  data <-
    data_raw[c("mes", "p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min")]

  data$mes <- as.numeric(data$mes)
  data <- data[data$mes < 13, ]
  data <- tidyr::pivot_longer(data, 2:5)
  data <-
    tidyr::pivot_wider(data, names_from = "mes", values_from = "value")
  data <-
    dplyr::arrange(data, match(
      "name",
      c("p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min")
    ))

  # Need a data frame with row names
  data <- as.data.frame(data)
  rownames(data) <- data$name
  data <- data[, colnames(data) != "name"]

  stations <- aemet_stations(verbose = verbose)
  stations <- stations[stations$indicativo == station, ]

  data_na <- as.integer(sum(is.na(data)))

  if (is.null(labels)) {
    labels <- "en"
  }

  if (data_na > 0) {
    message("Data with null values, unable to plot the diagram \n")
  } else if (ggplot2 == TRUE) {
    ggclimat_walter_lieth(
      data,
      est = stations$nombre,
      alt = stations$altitud,
      per = "1981-2010",
      mlab = labels,
      ...
    )
  } else {
    if (!requireNamespace("climatol", quietly = TRUE)) {
      stop("\n\npackage climatol required, please install it first")
    }

    climatol::diagwl(
      data,
      est = stations$nombre,
      alt = stations$altitud,
      per = "1981-2010",
      mlab = labels,
      ...
    )
  }
}

#' Walter & Lieth climatic diagram for a time period
#'
#' @description
#' Plot of a Walter & Lieth climatic diagram from monthly climatology data for
#' a station. This climatogram are great for showing a summary of climate
#' conditions for a place over a specific time period.
#'
#' @family aemet_plots
#' @family climatogram
#'
#' @inheritParams climatogram_normal
#' @inheritParams aemet_monthly_period
#'
#' @note
#' The code is based on code from the CRAN package "climatol" by Jose A.
#' Guijarro <jguijarrop@aemet.es>.
#'
#'
#' @references
#' Walter, H. & Lieth, H (1960): Klimadiagramm Weltatlas. G. Fischer, Jena.
#'
#' @return A plot.
#'
#'
#' @examplesIf aemet_detect_api_key()
#' \donttest{
#' climatogram_period("9434", start = 2015, end = 2020, labels = "en")
#' }
#' @inheritSection aemet_daily_clim API Key
#'
#' @export

climatogram_period <-
  function(station = NULL,
           start = 1990,
           end = 2020,
           labels = "en",
           verbose = FALSE,
           ggplot2 = TRUE,
           ...) {
    message("Data download may take a few minutes ... please wait \n")

    data_raw <-
      aemet_monthly_period(station,
        start = start,
        end = end,
        verbose = verbose
      )

    if (nrow(data_raw) == 0) {
      stop("No valid results from the API")
    }

    data <-
      data_raw[c("fecha", "p_mes", "tm_max", "tm_min", "ta_min")]
    data <-
      tidyr::drop_na(data, c("p_mes", "tm_max", "tm_min", "ta_min"))
    data <- data[-grep("-13", data$fecha), ]
    data$ta_min <-
      as.double(gsub("\\s*\\([^\\)]+\\)", "", as.character(data$ta_min)))
    data$fecha <- as.Date(paste0(data$fecha, "-01"))
    data$mes <- as.integer(format(data$fecha, "%m"))
    data <- data[names(data) != "fecha"]
    data <- tibble::as_tibble(aggregate(. ~ mes, data, mean))
    data <- tidyr::pivot_longer(data, 2:5)
    data <-
      tidyr::pivot_wider(data, names_from = "mes", values_from = "value")
    data <-
      dplyr::arrange(data, match(
        "name",
        c("p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min")
      ))

    # Need a data frame with row names
    data <- as.data.frame(data)
    rownames(data) <- data$name
    data <- data[, colnames(data) != "name"]

    stations <- aemet_stations(verbose = verbose)
    stations <- stations[stations$indicativo == station, ]

    data_na <- as.integer(sum(is.na(data)))

    if (is.null(labels)) {
      labels <- "en"
    }

    if (data_na > 0) {
      message("Data with null values, unable to plot the diagram \n")
    } else if (ggplot2) {
      ggclimat_walter_lieth(
        data,
        est = stations$nombre,
        alt = stations$altitud,
        per = paste(start, "-", end),
        mlab = labels,
        ...
      )
    } else {
      if (!requireNamespace("climatol", quietly = TRUE)) {
        stop("\n\npackage climatol required, please install it first")
      }

      climatol::diagwl(
        data,
        est = stations$nombre,
        alt = stations$altitud,
        per = paste(start, "-", end),
        mlab = labels,
        ...
      )
    }
  }




#' Walter and Lieth climatic diagram on `ggplot2`
#'
#' @description
#' Plot of a Walter and Lieth climatic diagram of a station. This function is
#' an updated version of [`climatol::diagwl()`], by Jose A. Guijarro.
#'
#' \if{html}{\figure{lifecycle-experimental.svg}{options: alt="[Experimental]"}}
#'
#' @export
#'
#' @family aemet_plots
#' @family climatogram
#'
#' @param dat	Monthly climatic data for which the diagram will be plotted.
#'
#' @param est	Name of the climatological station
#'
#' @param alt Altitude of the climatological station
#'
#' @param per	Period on which the averages have been computed
#' @param mlab Month labels for the X axis. Use 2-digit language code ("en",
#'    "es", etc.). See [`readr::locale()`] for info.
#' @param pcol	Color pen for precipitation.
#' @param tcol Color pen for temperature.
#' @param pfcol	Fill color for probable frosts.
#' @param sfcol	Fill color for sure frosts.
#' @param shem Set to `TRUE` for southern hemisphere stations.
#' @param p3line Set to `TRUE` to draw a supplementary precipitation line
#'   referenced to three times the temperature (as suggested by Bogdan Rosca).
#' @param ...	Other graphic parameters
#'
#' @seealso [`climatol::diagwl()`], [`readr::locale()`]
#'
#' @return A `ggplot2` object. See `help("ggplot2")`.
#'
#' @references Walter, H., and Lieth, H. 1960. *Klimadiagramm-Weltatlas.*
#' G. Fischer.
#'
#' @details
#' See Details on [`climatol::diagwl()`].
#'
#' Climatic data must be passed as a 4x12 matrix or `data.frame` of monthly
#' (January to December) data, in the following order:
#'   - Row 1: Mean precipitation.
#'   - Row 2: Mean maximum daily temperature.
#'   - Row 3: Mean minimum daily temperature.
#'   - Row 4: Absolute monthly minimum temperature.
#'
#' See [climaemet_9434_climatogram] for a sample dataset.
#'
#' @inheritSection aemet_daily_clim API Key
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
#' # As it is a ggplot object we can modify it
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
ggclimat_walter_lieth <- function(dat,
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
                                  ...) {
  ## Validate inputs----

  if (!all(dim(dat) == c(4, 12))) {
    stop(
      "`dat` should have 4 rows and 12 colums. Your inputs has ",
      nrow(dat), " rows and ", ncol(dat), " columns."
    )
  }

  # NULL data
  data_na <- as.integer(sum(is.na(dat)))
  if (data_na > 0) {
    stop("Data with null values, unable to plot the diagram \n")
  }

  # If matrix transform to data frame
  if (is.matrix(dat)) {
    dat <- as.data.frame(dat,
      row.names = c(
        "p_mes_md", "tm_max_md", "tm_min_md",
        "ta_min_min"
      ),
      col.names = paste0("m", seq_len(12))
    )
  }

  ## Transform data----
  # Months label
  mlab <- toupper(substr(readr::locale(mlab)$date_names$mon, 1, 1))

  # Pivot table and tidydata
  dat_long <- tibble::as_tibble(t(dat))
  # Easier to handle, normalize names
  names(dat_long) <- c("p_mes", "tm_max", "tm_min", "ta_min")

  dat_long <- dplyr::bind_cols(label = mlab, dat_long)

  # Southern hemisphere
  if (shem) {
    dat_long <- rbind(dat_long[7:12, ], dat_long[1:6, ])
  }

  # Mean temp
  dat_long$tm <- (dat_long[[3]] + dat_long[[4]]) / 2

  # Reescalate p_mes
  dat_long$pm_reesc <- ifelse(dat_long$p_mes < 100,
    dat_long$p_mes * 0.5,
    dat_long$p_mes * 0.05 + 45
  )

  # Add p3line

  dat_long$p3line <- dat_long$p_mes / 3

  # Add first and last row for plotting properly
  dat_long <- dplyr::bind_rows(
    dat_long[nrow(dat_long), ],
    dat_long,
    dat_long[1, ]
  )

  dat_long[c(1, nrow(dat_long)), "label"] <- ""

  # Interpolate values to expand x range
  # Number rows
  dat_long <- cbind(indrow = seq(-0.5, 12.5, 1), dat_long)
  dat_long_int <- NULL

  for (j in seq(nrow(dat_long) - 1)) {
    intres <- NULL

    for (i in seq_len(ncol(dat_long))) {
      if (is.character(dat_long[j, i])) {
        # On character don't interpolate
        val <- as.data.frame(dat_long[j, i])
      } else {
        # Interpolate
        interpol <- approx(
          x = dat_long[c(j, j + 1), 1],
          y = dat_long[c(j, j + 1), i],
          n = 50
        )
        val <-
          as.data.frame(interpol$y) # Just the interpolated value
      }
      names(val) <- names(dat_long)[i]
      intres <- dplyr::bind_cols(intres, val)
    }

    dat_long_int <- dplyr::bind_rows(dat_long_int, intres)
  }

  # Regenerate and filter values
  dat_long_int$interpolate <- TRUE
  dat_long_int$label <- ""
  dat_long$interpolate <- FALSE
  dat_long_int <-
    dat_long_int[!dat_long_int$indrow %in% dat_long$indrow, ]
  dat_long_end <- dplyr::bind_rows(dat_long, dat_long_int)
  dat_long_end <- dat_long_end[order(dat_long_end$indrow), ]
  dat_long_end <-
    dat_long_end[dat_long_end$indrow >= 0 &
      dat_long_end$indrow <= 12, ]
  dat_long_end <- tibble::as_tibble(dat_long_end)
  # Final tibble with normalized and helper values



  # Labels and axis----

  ## Horizontal axis ----
  month_breaks <- dat_long_end[dat_long_end$label != "", ]$indrow
  month_labs <- dat_long_end[dat_long_end$label != "", ]$label

  ## Vert. Axis range - temp ----
  ymax <- max(60, 10 * floor(max(dat_long_end$pm_reesc) / 10) + 10)

  # Min range
  ymin <- min(-3, min(dat_long_end$tm)) # min Temp
  range_tm <- seq(0, ymax, 10)

  if (ymin < -3) {
    ymin <- floor(ymin / 10) * 10 # min Temp rounded
    # Labels
    range_tm <- seq(ymin, ymax, 10)
  }

  # Labels
  templabs <- paste0(range_tm)
  templabs[range_tm > 50] <- ""

  # Vert. Axis range - prec
  range_prec <- range_tm * 2
  range_prec[range_tm > 50] <- range_tm[range_tm > 50] * 20 - 900
  preclabs <- paste0(range_prec)
  preclabs[range_tm < 0] <- ""

  ## Titles and additional labels----
  title <- est

  if (!is.na(alt)) {
    title <- paste0(
      title,
      " (",
      prettyNum(alt,
        big.mark = ",",
        decimal.mark = "."
      ),
      " m)"
    )
  }

  if (!is.na(per)) {
    title <- paste0(title, "\n", per)
  }

  # Subtitles
  sub <-
    paste(round(mean(dat_long_end[dat_long_end$interpolate == FALSE, ]$tm), 1),
      "C        ",
      prettyNum(
        round(sum(
          dat_long_end[dat_long_end$interpolate == FALSE, ]$p_mes
        )),
        big.mark = ","
      ),
      " mm",
      sep = ""
    )

  # Vertical tags
  maxtm <- prettyNum(round(max(dat_long_end$tm_max), 1))
  mintm <- prettyNum(round(min(dat_long_end$tm_min), 1))

  tags <- paste0(
    paste0(rep(" \n", 6), collapse = ""),
    maxtm,
    paste0(rep(" \n", 10), collapse = ""),
    mintm
  )

  # Helper for ticks

  ticks <- data.frame(
    x = seq(0, 12),
    ymin = -3,
    ymax = 0
  )




  # Lines and additional areas----
  getpolymax <- function(x, y, y_lim) {
    initpoly <- FALSE
    yres <- NULL
    xres <- NULL

    # Check
    for (i in seq_len(length(y))) {
      lastobs <- i == length(x)

      # If conditions to plot polygon
      if (y[i] > y_lim[i]) {
        if (isFALSE(initpoly)) {
          # Initialise polygon if not already initialise
          xres <- c(xres, x[i])
          yres <- c(yres, y_lim[i])
          initpoly <- TRUE
        }
        xres <- c(xres, x[i])
        yres <- c(yres, y[i])

        # On lastobs we need to close the polygon
        if (lastobs) {
          xres <- c(xres, x[i], NA)
          yres <- c(yres, y_lim[i], NA)
        }
      } else {
        # Close polygon
        if (initpoly) {
          xres <- c(xres, x[i - 1], NA)
          yres <- c(yres, y_lim[i - 1], NA)
          initpoly <- FALSE
        }
      }
    }
    poly <- tibble::tibble(x = xres, y = yres)
    return(poly)
  }


  getlines <- function(x, y, y_lim) {
    yres <- NULL
    xres <- NULL
    ylim_res <- NULL

    # Check
    for (i in seq_len(length(y))) {
      # If conditions to line
      if (y[i] > y_lim[i]) {
        xres <- c(xres, x[i])
        yres <- c(yres, y[i])
        ylim_res <- c(ylim_res, y_lim[i])
      }
    }
    line <- tibble::tibble(
      x = xres,
      y = yres,
      ylim_res = ylim_res
    )
    return(line)
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

  # Prob freeze
  dat_real <-
    dat_long_end[dat_long_end$interpolate == FALSE, c("indrow", "ta_min")]
  x <- NULL
  y <- NULL
  for (i in seq_len(nrow(dat_real))) {
    if (dat_real[i, ]$ta_min < 0) {
      x <-
        c(
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
  # Sure freeze
  dat_real <-
    dat_long_end[dat_long_end$interpolate == FALSE, c("indrow", "tm_min")]

  x <- NULL
  y <- NULL
  for (i in seq_len(nrow(dat_real))) {
    if (dat_real[i, ]$tm_min < 0) {
      x <-
        c(
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

  # Start plotting----
  # Basic lines and segments
  wandlplot <- ggplot2::ggplot() +
    ggplot2::geom_line(
      data = dat_long_end,
      aes(x = .data$indrow, y = .data$pm_reesc),
      color = pcol
    ) +
    ggplot2::geom_line(
      data = dat_long_end,
      aes(x = .data$indrow, y = .data$tm),
      color = tcol
    ) +
    ggplot2::geom_segment(
      aes(
        x = .data$x,
        y = .data$ylim_res,
        xend = .data$x,
        yend = .data$y
      ),
      data = tm_max_line,
      color = tcol,
      alpha = 0.2
    ) +
    ggplot2::geom_segment(
      aes(
        x = .data$x,
        y = .data$ylim_res,
        xend = .data$x,
        yend = .data$y
      ),
      data = pm_max_line,
      color = pcol,
      alpha = 0.2
    )
  if (p3line) {
    wandlplot <- wandlplot +
      ggplot2::geom_line(
        data = dat_long_end,
        aes(
          x = .data$indrow,
          y = .data$p3line
        ),
        color = pcol
      )
  }

  # Add polygons

  # Max precip
  if (max(dat_long_end$pm_reesc) > 50) {
    wandlplot <- wandlplot +
      ggplot2::geom_polygon(
        data = prep_max_poly,
        aes(x, y), fill = pcol
      )
  }


  # Probable freeze

  if (min(dat_long_end$ta_min) < 0) {
    wandlplot <- wandlplot +
      ggplot2::geom_polygon(
        data = probfreeze,
        aes(x = x, y = y),
        fill = pfcol,
        colour = "black"
      )
  }

  # Sure freeze

  if (min(dat_long_end$tm_min) < 0) {
    wandlplot <- wandlplot +
      geom_polygon(
        data = surefreeze,
        aes(x = x, y = y),
        fill = sfcol,
        colour = "black"
      )
  }


  # Add lines and scales to chart
  wandlplot <- wandlplot +
    geom_hline(yintercept = c(0, 50), size = 0.5) +
    geom_segment(data = ticks, aes(
      x = x,
      xend = x,
      y = ymin,
      yend = ymax
    )) +
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
      sec.axis = dup_axis(
        name = "mm",
        labels = preclabs
      )
    )


  # Add tags and theme
  wandlplot <- wandlplot +
    ggplot2::labs(
      title = title,
      subtitle = sub,
      tag = tags
    ) +
    ggplot2::theme_classic() +
    ggplot2::theme(
      plot.title = element_text(
        lineheight = 1,
        size = 14,
        face = "bold"
      ),
      plot.subtitle = element_text(
        hjust = 1,
        vjust = 1,
        size = 14
      ),
      plot.tag = element_text(size = 10),
      plot.tag.position = "left",
      axis.ticks.length.x.bottom = unit(0, "pt"),
      axis.line.x.bottom = element_blank(),
      axis.title.y.left = element_text(
        angle = 0,
        vjust = 0.9,
        size = 10,
        colour = tcol,
        margin = unit(rep(10, 4), "pt")
      ),
      axis.text.x.bottom = element_text(size = 10),
      axis.text.y.left = element_text(colour = tcol, size = 10),
      axis.title.y.right = element_text(
        angle = 0,
        vjust = 0.9,
        size = 10,
        colour = pcol,
        margin = unit(rep(10, 4), "pt")
      ),
      axis.text.y.right = element_text(colour = pcol, size = 10)
    )


  return(wandlplot)
}
