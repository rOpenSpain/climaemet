# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' AEMET stations
#'
#' Get AEMET stations.
#'
#' @family aemet_api_data
#'
#' @inheritParams aemet_daily_clim
#'
#' @inheritParams aemet_last_obs
#' @inherit aemet_last_obs return
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @details
#' The first result of the API call in each session is temporarily cached in
#' [tempdir()] to avoid unnecessary API calls.
#'
#' @note Code modified from project <https://github.com/SevillaR/aemet>.
#'
#' @examplesIf aemet_detect_api_key()
#' library(tibble)
#' stations <- aemet_stations()
#' stations
#'
#' # Cached during this R session
#' stations2 <- aemet_stations(verbose = TRUE)
#'
#' identical(stations, stations2)
#'
#' @export
#' @encoding UTF-8

aemet_stations <- function(verbose = FALSE, return_sf = FALSE) {
  # Validate inputs ----
  aemet_hlp_validate_logical(verbose, "verbose")
  aemet_hlp_validate_logical(return_sf, "return_sf")

  cache <- aemet_hlp_cache_paths("aemet_stations")
  df <- aemet_hlp_read_cache(cache, "stations", verbose, readRDS)

  if (is.null(df)) {
    # Call API ----
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

  # Validate sf output ----
  if (return_sf) {
    df <- aemet_hlp_sf(df, "latitud", "longitud", verbose)
  }

  df
}
