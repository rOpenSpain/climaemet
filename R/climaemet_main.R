################################################################################
# Author: Manuel Pizarro <m.pizarro@csic.es>
# Ecosystem Conservation, IPE (CSIC) <http://www.ipe.csic.es/conservacion-bio/>
# Version: 0.2.0
################################################################################


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
#'   climatestripes_station("9434",
#'     start = 2010, end = 2020, with_labels = "yes"
#'   )
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
      dplyr::mutate(data,
        temp = as.numeric(data$temp),
        year = as.integer(gsub("-13", "", data$year))
      )


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
