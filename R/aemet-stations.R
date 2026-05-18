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
#' @return A [tibble][tibble::tbl_df] or a \CRANpkg{sf} object.
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @details
#' The first result of the API call in each session is temporarily cached in
#' [tempdir()] to avoid unnecessary API calls.
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
  stopifnot(is.logical(verbose))
  stopifnot(is.logical(return_sf))

  cached_df <- file.path(tempdir(), "aemet_stations.rds")
  cached_date <- file.path(tempdir(), "aemet_stations_date.rds")

  if (file.exists(cached_df)) {
    df <- readRDS(cached_df)
    dat <- readRDS(cached_date) # nolint

    if (verbose) {
      cli::cli_alert_info(paste0(
        "Loading stations from temporary cached file saved at ",
        "{format(dat, usetz = TRUE)}"
      ))
    }
  } else {
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
    saveRDS(df, cached_df)
    saveRDS(Sys.time(), cached_date)
  }

  # Validate sf output ----
  if (return_sf) {
    df <- aemet_hlp_sf(df, "latitud", "longitud", verbose)
  }

  df
}
