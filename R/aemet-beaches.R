# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' AEMET beaches
#'
#' Get AEMET beaches.
#'
#' @family aemet_api_data
#'
#' @inheritParams aemet_daily_clim
#'
#' @inheritParams aemet_last_obs
#'
#' @return A [tibble][tibble::tbl_df] or a \CRANpkg{sf} object.
#'
#' @inheritSection aemet_daily_clim API key
#' @inherit aemet_stations details
#'
#' @seealso [aemet_forecast_beaches()]
#'
#' @examplesIf aemet_detect_api_key()
#' library(tibble)
#' beaches <- aemet_beaches()
#' beaches
#'
#' # Cached during this R session
#' beaches2 <- aemet_beaches(verbose = TRUE)
#'
#' identical(beaches, beaches2)
#'
#' # Select and map beaches
#' library(dplyr)
#' library(ggplot2)
#' library(mapSpain)
#'
#' # Alicante / Alacant
#' beaches_sf <- aemet_beaches(return_sf = TRUE) |>
#'   filter(ID_PROVINCIA == "03")
#'
#' prov <- mapSpain::esp_get_prov("Alicante")
#'
#' ggplot(prov) +
#'   geom_sf() +
#'   geom_sf(
#'     data = beaches_sf, shape = 4, size = 2.5,
#'     color = "blue"
#'   )
#'
#' @export
#' @encoding UTF-8
aemet_beaches <- function(verbose = FALSE, return_sf = FALSE) {
  # Validate inputs ----
  stopifnot(is.logical(verbose))
  stopifnot(is.logical(return_sf))

  cached_df <- file.path(tempdir(), "aemet_beaches.rds")
  cached_date <- file.path(tempdir(), "aemet_beaches_date.rds")

  if (file.exists(cached_df)) {
    df <- readRDS(cached_df)
    dat <- readRDS(cached_date) # nolint

    if (verbose) {
      cli::cli_alert_info(paste0(
        "Loading beaches from temporary cached file saved at ",
        "{format(dat, usetz = TRUE)}"
      ))
    }
  } else {
    # Download beaches.
    url <- paste0(
      "https://www.aemet.es/documentos/es/eltiempo/",
      "prediccion/playas/Playas_codigos.csv"
    )
    r <- httr2::request(url)
    r <- httr2::req_perform(r)
    body <- httr2::resp_body_raw(r)
    df <- readr::read_delim(
      body,
      delim = ";",
      show_col_types = FALSE,
      locale = readr::locale(encoding = "ISO-8859-1"),
      trim_ws = TRUE
    )

    # Format outputs ----

    df$longitud <- vapply(df$LONGITUD, dms2decdegrees_2, FUN.VALUE = numeric(1))
    df$latitud <- vapply(df$LATITUD, dms2decdegrees_2, FUN.VALUE = numeric(1))

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
