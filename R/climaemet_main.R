################################################################################################################
# Author: Manuel Pizarro <m.pizarro@csic.es>
# Ecosystem Conservation, IPE (CSIC) <http://www.ipe.csic.es/conservacion-bio/>
# Version: 0.2.0
################################################################################################################


#' Station climate stripes graph
#'
#' Plot climate stripes graph for a station
#'
#' @concept aemet_plots
#'
#' @param station Character string as station identifier code
#'   (see [aemet_stations()]).
#'
#' @param with_labels Character string as yes/no. Indicates whether to use
#'   labels for the graph or not.
#'
#' @inheritParams aemet_monthly_period
#'
#' @return a plot.
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#' apikey <- Sys.getenv("AEMET_API_KEY")
#' if (apikey != "") {
#'   climatestripes_station("9434", start = 2010, end = 2020, with_labels = "yes")
#' }
#' @export
climatestripes_station <-
  function(station,
           apikey = NULL,
           start = 1950,
           end = 2020,
           with_labels = "yes",
           verbose = FALSE) {
    message("Data download may take a few minutes ... please wait \n")


    data_raw <-
      aemet_monthly_period(station, apikey, start, end, verbose)

    if (nrow(data_raw) == 0) stop("No valid results from the API")

    data <- data_raw[c("fecha", "indicativo", "tm_mes")]
    data <- data[!is.na(data$tm_mes), ]
    data <- data[grep("-13", data$fecha), ]
    data <- dplyr::rename(data, year = "fecha", temp = "tm_mes")
    data <-
      dplyr::mutate(data, temp = as.numeric(data$temp), year = as.integer(gsub("-13", "", data$year)))


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

    if (is.null(with_labels)) {
      with_labels <- "yes"
    }

    if (with_labels == "no") {
      ggstripes(data, plot_type = "background")
    } else {
      ggstripes(data, plot_type = "stripes", plot_title = title)
    }
  }

#' Walter & Lieth climatic diagram from normal climatology values
#'
#' @description
#' Plot of a Walter & Lieth climatic diagram from normal climatology data for
#' a station. This climatogram are great for showing a summary of climate
#' conditions for a place over a time period ((1981-2010).
#'
#' @concept aemet_plots
#'
#' @param labels Character string as month labels for the X axis: "en"
#' (english), "es" (spanish) or blank (numeric labels: 1-12).
#'
#' @inheritParams climatestripes_station
#'
#' @note The code is based on code from the CRAN package "climatol" by Jose A.
#' Guijarro <jguijarrop@aemet.es>.
#'
#' @seealso See more details in the [`climatol::diagwl()`] function.
#'
#' @references
#' Walter, H. & Lieth, H (1960): Klimadiagramm Weltatlas. G. Fischer, Jena.
#'
#' @return a plot.
#'
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#' apikey <- Sys.getenv("AEMET_API_KEY")
#' if (apikey != "") {
#'   climatogram_normal("9434")
#' }
#' @export
climatogram_normal <- function(station,
                               apikey = NULL,
                               labels = c("en", "es", ""),
                               verbose = FALSE) {
  if (verbose) {
    message("Data download may take a few seconds ... please wait \n")
  }

  data_raw <-
    aemet_normal_clim(station, apikey = apikey, verbose = verbose)

  if (nrow(data_raw) == 0) stop("No valid results from the API")

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

  stations <- aemet_stations(apikey, verbose = verbose)
  stations <- stations[stations$indicativo == station, ]

  data_na <- as.integer(sum(is.na(data)))

  if (is.null(labels)) {
    labels <- "en"
  }

  if (data_na > 0) {
    message("Data with null values, unable to plot the diagram \n")
  } else {
    climatol::diagwl(
      data,
      est = stations$nombre,
      alt = stations$altitud,
      per = "1981-2010",
      mlab = labels
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
#' @concept aemet_plots
#'
#' @inheritParams climatogram_normal
#' @inheritParams aemet_monthly_period
#'
#' @note
#' The code is based on code from the CRAN package "climatol" by Jose A.
#' Guijarro <jguijarrop@aemet.es>.
#'
#' @seealso See more details in the [`climatol::diagwl()`] function.
#'
#' @references
#' Walter, H. & Lieth, H (1960): Klimadiagramm Weltatlas. G. Fischer, Jena.
#'
#' @return a plot.
#'
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#' apikey <- Sys.getenv("AEMET_API_KEY")
#' if (apikey != "") {
#'   climatogram_period("9434", start = 2015, end = 2020, labels = "en")
#' }
#' @export

climatogram_period <-
  function(station = NULL,
           apikey = NULL,
           start = 1990,
           end = 2020,
           labels = c("en", "es", ""),
           verbose = FALSE) {
    message("Data download may take a few minutes ... please wait \n")

    data_raw <-
      aemet_monthly_period(station, apikey, start, end, verbose)

    if (nrow(data_raw) == 0) stop("No valid results from the API")

    data <-
      data_raw[c("fecha", "p_mes", "tm_max", "tm_min", "ta_min")]
    data <-
      tidyr::drop_na(data, c("p_mes", "tm_max", "tm_min", "ta_min"))
    data <- data[-grep("-13", data$fecha), ]
    data$ta_min <-
      as.double(gsub("\\s*\\([^\\)]+\\)", "", as.character(data$ta_min)))
    data$fecha <- as.Date(paste0(data$fecha, "-01"))
    data$mes <- lubridate::month(data$fecha)
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

    stations <- aemet_stations(apikey, verbose = verbose)
    stations <- stations[stations$indicativo == station, ]

    data_na <- as.integer(sum(is.na(data)))

    if (is.null(labels)) {
      labels <- "en"
    }

    if (data_na > 0) {
      message("Data with null values, unable to plot the diagram \n")
    } else {
      climatol::diagwl(
        data,
        est = stations$nombre,
        alt = stations$altitud,
        per = paste(start, "-", end),
        mlab = labels
      )
    }
  }
