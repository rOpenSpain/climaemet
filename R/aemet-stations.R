# AEMET weather station endpoints.

#' AEMET stations
#'
#' Retrieves the weather stations available from the AEMET API.
#'
#' @inheritParams aemet_last_obs verbose return_sf
#'
#' @section Caching:
#'   The first result retrieved in each session is temporarily cached in
#'   [tempdir()] to avoid unnecessary requests.
#'
#' @inheritSection aemet_api_key API key
#'
#' @inherit aemet_last_obs return
#'
#' @note Code modified from project <https://github.com/SevillaR/aemet>.
#'
#' @concept locations
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' library(dplyr)
#' stations <- aemet_stations()
#' stations
#'
#' # Cached during this R session.
#' stations2 <- aemet_stations(verbose = TRUE)
#'
#' identical(stations, stations2)
#'
aemet_stations <- function(verbose = FALSE, return_sf = FALSE) {
  # Validate inputs ----
  aemet_hlp_validate_logical(verbose, "verbose")
  aemet_hlp_validate_logical(return_sf, "return_sf")

  cache <- aemet_hlp_cache_paths("aemet_stations")
  df <- aemet_hlp_read_cache(cache, "stations", verbose, readRDS)

  if (is.null(df)) {
    # Call the API ----
    stations <- get_data_aemet(
      apidest = paste0(
        "/api/valores/climatologicos/",
        "inventarioestaciones/todasestaciones"
      ),
      verbose = verbose
    )

    # Format data ----
    stations$longitud <- dms2decdegrees(stations$longitud)
    stations$latitud <- dms2decdegrees(stations$latitud)

    vnames <- c(
      "indicativo",
      "indsinop",
      "nombre",
      "provincia",
      "altitud",
      "longitud",
      "latitud"
    )

    df <- stations[vnames]

    df <- aemet_hlp_guess(df, c("indicativo", "indsinop"))

    # Cache in the temporary directory.
    aemet_hlp_write_cache(df, cache, saveRDS)
  }

  # Prepare spatial output ----
  if (return_sf) {
    df <- aemet_hlp_sf(df, "latitud", "longitud", verbose)
  }

  df
}
