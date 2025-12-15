# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' AEMET stations
#'
#' Get AEMET stations.
#'
#' @family aemet_api_data
#'
#' @note Code modified from project <https://github.com/SevillaR/aemet>.
#'
#' @inheritParams aemet_daily_clim
#'
#' @inheritParams aemet_last_obs
#'
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object.
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @details
#' The first result of the API call on each session is (temporarily) cached in
#' the assigned [tempdir()] for avoiding unneeded API calls.
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

aemet_stations <- function(verbose = FALSE, return_sf = FALSE) {
  # Validate inputs----
  stopifnot(is.logical(verbose))
  stopifnot(is.logical(return_sf))

  cached_df <- file.path(tempdir(), "aemet_stations.rds")
  cached_date <- file.path(tempdir(), "aemet_stations_date.rds")

  if (file.exists(cached_df)) {
    df <- readRDS(cached_df)
    dat <- readRDS(cached_date)

    if (verbose) {
      message(
        "Loading stations from temporal cached file saved at ",
        format(dat, usetz = TRUE)
      )
    }
  } else {
    # Call API----
    stations <- get_data_aemet(
      apidest = paste0(
        "/api/valores/climatologicos/",
        "inventarioestaciones/todasestaciones"
      ),
      verbose = verbose
    )

    # Formats----
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

    # Cache on temp dir
    saveRDS(df, cached_df)
    saveRDS(Sys.time(), cached_date)
  }

  # Validate sf----
  if (return_sf) {
    df <- aemet_hlp_sf(df, "latitud", "longitud", verbose)
  }

  df
}
