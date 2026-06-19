#' AEMET wildfire risk forecast
#'
#' @description
#' Retrieves daily wildfire risk levels as either tabular data or a
#' [`SpatRaster`][terra::rast()].
#'
#' @param area Forecast area: `"p"` for mainland Spain and the Balearic Islands
#'   or `"c"` for the Canary Islands.
#' @inheritParams get_data_aemet
#' @inheritParams aemet_daily
#'
#' @details
#' The `SpatRaster` provides six [factor()] levels: `"1"` for very low risk,
#' `"2"` for low risk, `"3"` for moderate risk, `"4"` for high risk, `"5"`
#' for very high risk and `"6"` for extreme risk.
#'
#' The resulting object has several layers, each representing one of the next
#' seven forecast days. It also has additional attributes provided by the
#' \CRANpkg{terra} package, such as [terra::time()] and [terra::coltab()].
#'
#' @returns A [tibble][dplyr::tibble] or a [`SpatRaster`][terra::rast()].
#'
#' @source <https://www.aemet.es/en/eltiempo/prediccion/incendios>.
#'
#' @family aemet_api_data
#' @family forecasts
#'
#' @export
#' @encoding UTF-8
#'
#' @examplesIf aemet_detect_api_key()
#' aemet_forecast_fires(extract_metadata = TRUE)
#'
#' # Extract alerts.
#' alerts <- aemet_forecast_fires()
#'
#' alerts
#'
#' # Plot the raster.
#' library(terra)
#' plot(alerts, all_levels = TRUE)
#'
#' # Zoom in on an area.
#' cyl <- mapSpain::esp_get_ccaa("Castilla y Leon", epsg = 4326)
#'
#' # SpatVector
#' cyl <- vect(cyl)
#'
#' fires_cyl <- crop(alerts, cyl)
#' title <- names(fires_cyl)[1]
#'
#' plot(fires_cyl[[1]], main = title, all_levels = TRUE)
#' plot(cyl, add = TRUE)
#'
aemet_forecast_fires <- function(
  area = c("p", "c"),
  verbose = FALSE,
  extract_metadata = FALSE
) {
  # 1. Validate inputs ----
  area <- rlang::arg_match(area)
  aemet_hlp_validate_logical(verbose, "verbose")

  # 2. Download ----

  ## Metadata ----
  if (extract_metadata) {
    apidest <- "/api/incendios/mapasriesgo/previsto/dia/1/area/p"
    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
    return(final_result)
  }

  feed_url <- "https://www.aemet.es/es/api-eltiempo/incendios/download"

  # Perform the request.

  tmp_tar <- tempfile(fileext = ".tar.gzip")
  req1 <- aemet_hlp_request(feed_url)
  # nolint start
  response <- httr2::req_perform(req1, path = tmp_tar)
  # nolint end
  untar(tmp_tar, exdir = file.path(tempdir(), "fires"))

  # Select files.
  all_tifs <- list.files(
    file.path(tempdir(), "fires"),
    pattern = ".tif$",
    full.names = TRUE
  )

  area_tifs <- all_tifs[grepl(paste0("_", area, "_"), all_tifs)]

  # Create a table with dates and related metadata.
  dbase <- dplyr::tibble(file = area_tifs)
  # Prediction date.
  date <- unlist(strsplit(basename(dbase$file[1]), "_"))[2]
  date <- as.Date(date, tryFormats = "%Y%m%d")
  dbase$base_date <- date

  # Offset.
  off_all <- lapply(area_tifs, function(x) {
    off <- unlist(strsplit(basename(x), "_"))[5]
    off <- as.integer(gsub("[^0-9]", "", off))
  })

  dbase$offset <- unlist(off_all)
  dbase$date <- dbase$base_date + dbase$offset

  # Create rasters.
  rrast <- terra::rast(dbase$file)
  # Convert to factors and replace NaN with NA.
  rrast <- terra::clamp(rrast, lower = 1, upper = 6, values = FALSE)
  rrast[is.nan(rrast)] <- NA

  # Prepare factors.
  fct <- data.frame(
    id = seq_len(6),
    risk = c("Very low", "Low", "Moderate", "High", "Very high", "Extreme")
  )

  fct_list <- lapply(seq_len(6), function(x) fct)
  levels(rrast) <- fct_list

  # Set the color table.
  ctab <- data.frame(
    value = seq_len(6),
    col = c("#4b96e3", "#51d1f6", "#57e520", "#f9fb2f", "#ef8504", "#f52300")
  )

  # Iterate over layers.
  it <- seq_len(terra::nlyr(rrast))

  for (i in it) {
    terra::coltab(rrast, layer = i) <- ctab
  }

  # Set time attributes.

  terra::time(rrast) <- dbase$date
  names(rrast) <- format(dbase$date, format = "%Y-%m-%d")

  rrast <- terra::combineLevels(rrast)

  rrast
}
