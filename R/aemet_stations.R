# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' AEMET stations
#'
#' Get AEMET stations.
#'
#' @concept aemet_api_data
#'
#' @note Code modified from project <https://github.com/SevillaR/aemet>
#'
#' @inheritParams aemet_daily_clim
#'
#' @inheritParams aemet_last_obs
#'
#' @return a tibble or a `sf` object
#'
#'
#' @examples
#' # Run this example only if AEMET_API_KEY is set
#'
#' if (aemet_detect_api_key()) {
#'   library(tibble)
#'   stations <- aemet_stations()
#'   stations
#' }
#' @export

aemet_stations <-
  function(apikey = NULL,
           verbose = FALSE,
           return_sf = FALSE) {

    # Validate inputs----
    stopifnot(is.logical(verbose))
    stopifnot(is.logical(return_sf))

    # Call API----
    stations <-
      get_data_aemet(apidest = "/api/valores/climatologicos/inventarioestaciones/todasestaciones", apikey, verbose = verbose)

    # Formats----
    stations$longitud <- dms2decdegrees(stations$longitud)
    stations$latitud <- dms2decdegrees(stations$latitud)

    df <- stations[c(
      "indicativo",
      "indsinop",
      "nombre",
      "provincia",
      "altitud",
      "longitud",
      "latitud"
    )]

    df <- aemet_hlp_guess(df, c(
      "indicativo",
      "indsinop"
    ))

    # Validate sf----
    if (return_sf) {
      df <- aemet_hlp_sf(df, "latitud", "longitud", verbose)
    }

    return(df)
  }
