# AEMET beach data endpoints.

#' AEMET beaches
#'
#' Retrieves the beaches available from the AEMET API.
#'
#' @inheritParams aemet_daily_clim
#'
#' @inheritParams aemet_last_obs
#'
#' @inherit aemet_stations details
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @inherit aemet_last_obs return
#'
#' @seealso [aemet_forecast_beaches()].
#'
#' @family observations
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' library(dplyr)
#' beaches <- aemet_beaches()
#' beaches
#'
#' # Cached during this R session.
#' beaches2 <- aemet_beaches(verbose = TRUE)
#'
#' identical(beaches, beaches2)
#'
#' # Select and map beaches.
#' library(ggplot2)
#' library(mapSpain)
#'
#' # Alicante / Alacant.
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

  # Prepare spatial output ----
  if (return_sf) {
    df <- aemet_hlp_sf(df, "latitud", "longitud", verbose)
  }

  df
}
