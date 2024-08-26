aemet_forecast_fires <- function(area = c("p", "c"), verbose = FALSE) {
  # 1. Validate inputs----
  area <- match.arg(area)
  stopifnot(is.logical(verbose))
  verb <- ifelse(verbose, 3, 0)

  # 2. Download from feed ----

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
