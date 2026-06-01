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
#' @inherit aemet_stations details
#' @inherit aemet_last_obs return
#'
#' @inheritSection aemet_daily_clim API key
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
  aemet_hlp_validate_logical(verbose, "verbose")
  aemet_hlp_validate_logical(return_sf, "return_sf")

  cache <- aemet_hlp_cache_paths("aemet_beaches")
  df <- aemet_hlp_read_cache(cache, "beaches", verbose, readRDS)

  if (is.null(df)) {
    # Download beaches.
    url <- paste0(
      "https://www.aemet.es/documentos/es/eltiempo/",
      "prediccion/playas/Playas_codigos.csv"
    )
    r <- aemet_hlp_request(url)
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
    aemet_hlp_write_cache(df, cache, saveRDS)
  }

  # Validate sf output ----
  if (return_sf) {
    df <- aemet_hlp_sf(df, "latitud", "longitud", verbose)
  }

  df
}
