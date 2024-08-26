#' AEMET fires forecast
#'
#' @description
#'
#' Get a [`SpatRaster`][terra::rast()] as provided by \CRANpkg{terra} with the
#' daily meteorological risk level for wildfires.
#'
#' @family aemet_api_data
#' @family forecasts
#'
#' @param area The area, being:
#'   - `"p"` for Mainland Spain and Balearic Islands.
#'   - `"c"` for Canary Islands.
#' @inheritParams get_data_aemet
#' @inheritParams aemet_daily
#'
#' @source
#'
#' <https://www.aemet.es/en/eltiempo/prediccion/incendios>.
#'
#' @return A [`tibble`][tibble::tibble()] or a [`SpatRaster`][terra::rast()]
#' object.
#'
#' @details
#' The `SpatRaster` provides 5 [factor()] levels with the following meaning:
#'   - `"1"`: Low risk.
#'   - `"2"`: Moderate risk.
#'   - `"3"`: High risk.
#'   - `"4"`: Very high risk.
#'   - `"5"`: Extreme risk.
#'
#' The resulting object has several layers, each one representing the forecast
#' for the upcoming 7 days. It also has additional attributes provided by the
#' \CRANpkg{terra} package, such as [terra::time()] and [terra::coltab()].
#'
#'
#'
#' @export
#'
#' @examplesIf aemet_detect_api_key()
#' aemet_forecast_fires(extract_metadata = TRUE)
#'
#' # Extract alerts
#' alerts <- aemet_forecast_fires()
#'
#' alerts
#'
#' # Nice plotting
#' library(ggplot2)
#' library(tidyterra)
#'
#' ggplot() +
#'   geom_spatraster(data = alerts) +
#'   facet_wrap(~lyr, nrow = 2)
#'
#' # Zoom in an area
#' cyl <- mapSpain::esp_get_ccaa("Castilla y Leon", epsg = 4326)
#'
#' fires_cyl <- terra::crop(alerts, cyl)
#'
#' ggplot() +
#'   geom_spatraster(data = fires_cyl) +
#'   geom_sf(data = cyl, fill = NA, color = "black", linewidth = 0.5) +
#'   facet_wrap(~lyr, nrow = 2)
#'
#' @export
aemet_forecast_fires <- function(area = c("p", "c"), verbose = FALSE,
                                 extract_metadata = FALSE) {
  # 1. Validate inputs----
  area <- match.arg(area)
  stopifnot(is.logical(verbose))
  verb <- ifelse(verbose, 3, 0)



  # 2. Download ----

  ## Metadata ----
  if (extract_metadata) {
    apidest <- "/api/incendios/mapasriesgo/previsto/dia/1/area/p"
    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
    return(final_result)
  }

  feed_url <- "https://www.aemet.es/es/api-eltiempo/incendios/download"


  # Perform req

  tmp_tar <- tempfile(fileext = ".tar.gzip")
  req1 <- httr2::request(feed_url)
  # nolint start
  response <- httr2::req_perform(req1,
    path = tmp_tar,
    verbosity = verb
  )
  # nolint end
  untar(tmp_tar, exdir = file.path(tempdir(), "fires"))

  # Select files
  all_tifs <- list.files(file.path(tempdir(), "fires"),
    pattern = ".tif$",
    full.names = TRUE
  )

  area_tifs <- all_tifs[grepl(paste0("_", area, "_"), all_tifs)]

  # Create a table with dates, etc
  dbase <- dplyr::tibble(file = area_tifs)
  # Date of pred
  date <- unlist(strsplit(area_tifs[1], "_"))[5]
  date <- as.Date(date, "%d%m%Y")
  dbase$base_date <- date

  # offset
  off_all <- lapply(area_tifs, function(x) {
    off <- unlist(strsplit(x, "_"))[3]
    off <- as.integer(gsub("[^0-9]", "", off)) / 24
  })

  dbase$offset <- unlist(off_all)
  dbase$date <- dbase$base_date + dbase$offset

  # Now create rasters
  rrast <- lapply(dbase$file, terra::rast)
  rrast <- do.call("c", rrast)
  rrast <- terra::as.factor(rrast)
  ctab <- data.frame(value = seq_len(5), col = c(
    "#00f6f6", "#00ff00", "#ffff00",
    "#ff7f00", "#ff0000"
  ))
  for (i in seq_len(nrow(dbase))) {
    terra::coltab(rrast, layer = i) <- ctab
  }

  terra::time(rrast) <- dbase$date
  names(rrast) <- format(dbase$date, format = "%Y-%m-%d")

  rrast
}
