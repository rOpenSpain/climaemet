#' AEMET alert zones
#'
#' Get AEMET alert zones.
#'
#' @family aemet_api_data
#'
#'
#' @inheritParams aemet_beaches
#'
#'
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object.
#'
#'
#' @seealso [aemet_alerts()]
#'
#' @details
#' The first result of the call on each session is (temporarily) cached in
#' the assigned [tempdir()] for avoiding unneeded API calls.
#'
#' @source
#'
#' <https://www.aemet.es/es/eltiempo/prediccion/avisos/ayuda>. See also
#' Annex 2 and Annex 3 docs, linked in this page.
#'
#'
#' @examplesIf aemet_detect_api_key()
#' library(tibble)
#' alert_zones <- aemet_alert_zones()
#' alert_zones
#'
#' # Cached during this R session
#' alert_zones2 <- aemet_alert_zones(verbose = TRUE)
#'
#' identical(alert_zones, alert_zones2)
#'
#' # Select an map beaches
#' library(dplyr)
#' library(ggplot2)
#'
#'
#' # Galicia
#' alert_zones_sf <- aemet_alert_zones(return_sf = TRUE) %>%
#'   filter(COD_CCAA == "71")
#'
#' # Coast zones are identified by a "C" in COD_Z
#' alert_zones_sf$type <- ifelse(grepl("C$", alert_zones_sf$COD_Z),
#'   "Coast", "Mainland"
#' )
#'
#'
#' ggplot(alert_zones_sf) +
#'   geom_sf(aes(fill = NOM_PROV)) +
#'   facet_wrap(~type) +
#'   scale_fill_brewer(palette = "Blues")
#'
#' @export
aemet_alert_zones <- function(verbose = FALSE, return_sf = FALSE) {
  # Validate inputs----
  stopifnot(is.logical(verbose))
  stopifnot(is.logical(return_sf))

  cached_sf <- file.path(tempdir(), "aemet_alert_zones.gpkg")
  cached_date <- file.path(tempdir(), "aemet_alert_zone_date.rds")

  if (file.exists(cached_sf)) {
    sf_areas <- sf::read_sf(cached_sf)
    dat <- readRDS(cached_date)

    if (verbose) {
      message(
        "Loading alert zones from temporal cached file saved at ",
        format(dat, usetz = TRUE)
      )
    }
  } else {
    # download beaches
    url <- paste0(
      "https://www.aemet.es/documentos/es/eltiempo/prediccion/",
      "avisos/plan_meteoalerta/",
      "AEMET-meteoalerta-delimitacion-zonas.zip"
    )
    r <- httr2::request(url)

    outdir <- file.path(tempdir(), "alertzones")
    outfile <- file.path(outdir, "alertzones.zip")
    if (!dir.exists(outdir)) dir.create(outdir, recursive = TRUE)

    r <- httr2::req_perform(r, path = outfile)

    # unzip
    unzip(outfile, exdir = outdir, junkpaths = TRUE)

    # Get shp files
    shpf <- list.files(outdir, pattern = ".shp$", full.names = TRUE)

    sf_areas <- lapply(shpf, sf::read_sf)
    sf_areas <- dplyr::bind_rows(sf_areas)
    sf_areas <- sf::st_make_valid(sf_areas)
    sf_areas <- sf::st_transform(sf_areas, 4326)


    # Cache on temp dir
    sf::st_write(sf_areas, cached_sf, quiet = TRUE)
    saveRDS(Sys.time(), cached_date)
  }

  # Validate sf----
  if (!return_sf) {
    sf_areas <- sf::st_drop_geometry(sf_areas)
    sf_areas <- dplyr::as_tibble(sf_areas)
  }

  sf_areas
}
