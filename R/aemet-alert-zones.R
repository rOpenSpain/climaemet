#' AEMET alert zones
#'
#' Retrieves the AEMET geographical zones used for meteorological alerts.
#'
#' @inheritParams aemet_beaches
#' @details
#' The first result of each call per session is temporarily cached in
#' [tempdir()] to avoid unnecessary API calls.
#'
#' @inherit aemet_last_obs return
#'
#' @source
#' <https://www.aemet.es/es/eltiempo/prediccion/avisos/ayuda>. See also
#' Annex 2 and Annex 3 documents, linked from that page.
#'
#' @seealso [aemet_alerts()]
#'
#' @family aemet_api_data
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' library(dplyr)
#' alert_zones <- aemet_alert_zones()
#' alert_zones
#'
#' # Cached during this R session.
#' alert_zones2 <- aemet_alert_zones(verbose = TRUE)
#'
#' identical(alert_zones, alert_zones2)
#'
#' # Select and map alert zones.
#' library(ggplot2)
#'
#' # Galicia.
#' alert_zones_sf <- aemet_alert_zones(return_sf = TRUE) |>
#'   filter(COD_CCAA == "71")
#'
#' # Coast zones have codes ending in "C".
#' alert_zones_sf$type <- ifelse(grepl("C$", alert_zones_sf$COD_Z),
#'   "Coast", "Mainland"
#' )
#'
#' ggplot(alert_zones_sf) +
#'   geom_sf(aes(fill = NOM_PROV)) +
#'   facet_wrap(~type) +
#'   scale_fill_brewer(palette = "Blues")
#'
aemet_alert_zones <- function(verbose = FALSE, return_sf = FALSE) {
  # Validate inputs ----
  aemet_hlp_validate_logical(verbose, "verbose")
  aemet_hlp_validate_logical(return_sf, "return_sf")

  cache <- aemet_hlp_cache_paths(
    "aemet_alert_zones",
    "gpkg",
    "aemet_alert_zone"
  )
  sf_areas <- aemet_hlp_read_cache(
    cache,
    "alert zones",
    verbose,
    sf::read_sf
  )

  if (is.null(sf_areas)) {
    # Download alert zones.
    url <- paste0(
      "https://www.aemet.es/documentos/es/eltiempo/prediccion/",
      "avisos/plan_meteoalerta/",
      "AEMET-meteoalerta-delimitacion-zonas.zip"
    )
    r <- aemet_hlp_request(url)

    outdir <- file.path(tempdir(), "alertzones")
    outfile <- file.path(outdir, "alertzones.zip")
    if (!dir.exists(outdir)) {
      dir.create(outdir, recursive = TRUE)
    }

    r <- httr2::req_perform(r, path = outfile)

    # Unzip the downloaded file.
    unzip(outfile, exdir = outdir, junkpaths = TRUE)

    # Get shapefiles.
    shpf <- list.files(outdir, pattern = ".shp$", full.names = TRUE)

    sf_areas <- lapply(shpf, sf::read_sf)
    sf_areas <- dplyr::bind_rows(sf_areas)
    sf_areas <- sf::st_make_valid(sf_areas)
    sf_areas <- sf::st_transform(sf_areas, 4326)

    # Cache in the temporary directory.
    aemet_hlp_write_cache(
      sf_areas,
      cache,
      function(x, path) sf::st_write(x, path, quiet = TRUE)
    )
  }

  # Validate sf output ----
  if (!return_sf) {
    sf_areas <- sf::st_drop_geometry(sf_areas)
    sf_areas <- dplyr::as_tibble(sf_areas)
  }

  sf_areas
}
