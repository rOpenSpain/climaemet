#' Beach forecast dataset
#'
#' Get daily weather forecasts for one or more beaches. Beach codes can be
#' accessed with [aemet_beaches()].
#'
#' @param x Character vector with beach codes to extract. See [aemet_beaches()].
#' @inheritParams get_data_aemet
#' @inheritParams aemet_last_obs
#' @inherit aemet_last_obs return
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @seealso
#' [aemet_beaches()] for beach codes.
#'
#' @family aemet_api_data
#' @family forecasts
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' # Forecast for beaches in Palma, Mallorca
#' library(dplyr)
#' library(ggplot2)
#'
#' palma_b <- aemet_beaches() |>
#'   filter(ID_MUNICIPIO == "07040")
#'
#' forecast_b <- aemet_forecast_beaches(palma_b$ID_PLAYA)
#' glimpse(forecast_b)
#'
#' ggplot(forecast_b) +
#'   geom_line(aes(fecha, tagua_valor1, color = nombre)) +
#'   facet_wrap(~nombre, ncol = 1) +
#'   labs(
#'     title = "Water temperature in beaches of Palma (ES)",
#'     subtitle = "3-day forecast",
#'     x = "Date",
#'     y = "Temperature (Celsius)",
#'     color = "Beach"
#'   )
aemet_forecast_beaches <- function(
  x,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. API call ----

  ## Metadata ----
  if (extract_metadata) {
    mun <- aemet_beaches()
    x <- mun$ID_PLAYA[1]

    meta <- get_metadata_aemet(
      apidest = aemet_endpoint_forecast("playa", x),
      verbose = verbose
    )
    meta <- aemet_hlp_meta_forecast(meta)
    return(meta)
  }

  ## Normal call ----

  final_result <- aemet_hlp_fetch_loop(
    x,
    function(id) {
      aemet_hlp_try_forecast(
        id,
        function(id) aemet_forecast_beach_single(id, verbose = verbose)
      )
    },
    progress = progress,
    verbose = verbose
  )

  final_result <- aemet_hlp_finalize_forecast(
    final_result,
    id_width = 7,
    preserve = c("id", "localidad")
  )

  # Check spatial output ----
  if (return_sf) {
    # Get coordinates from beaches.
    sf_beaches <- aemet_beaches(verbose = verbose, return_sf = FALSE)
    sf_beaches <- sf_beaches[c("ID_PLAYA", "latitud", "longitud")]
    names(sf_beaches) <- c("id", "latitud", "longitud")
    final_result <- dplyr::left_join(final_result, sf_beaches, by = "id")
    final_result <- aemet_hlp_sf(final_result, "latitud", "longitud", verbose)
  }

  final_result
}

aemet_forecast_beach_single <- function(x, verbose = FALSE) {
  if (is.numeric(x)) {
    x <- aemet_hlp_pad_integer(x, 7)
  }

  pred <- get_data_aemet(
    apidest = aemet_endpoint_forecast("playa", x),
    verbose = verbose
  )

  pred$elaborado <- as.POSIXct(
    gsub("T", " ", pred$elaborado, fixed = TRUE),
    tz = "Europe/Madrid"
  )

  # Unnesting this dataset is complex.
  col_types <- get_col_first_class(pred)
  vars <- names(col_types[col_types %in% c("list", "data.frame")])

  first_lev <- tidyr::unnest(
    pred,
    col = dplyr::all_of(vars),
    names_sep = "_",
    keep_empty = TRUE
  )

  # Extract forecast days.
  pred_dia <- first_lev$prediccion_dia[[1]]
  master <- first_lev[, names(first_lev) != "prediccion_dia"]

  vars_prd <- names(pred_dia)
  pred_dia <- tidyr::unnest(
    pred_dia,
    col = dplyr::all_of(vars_prd),
    names_sep = "_",
    keep_empty = TRUE
  )

  # Adjust forecast dates.
  pred_dia$fecha <- as.Date(
    as.character(pred_dia$fecha),
    tryFormats = c("%Y-%m-%d", "%Y/%m/%d", "%Y%m%d")
  )
  pred_dia <- dplyr::as_tibble(pred_dia)

  master_end <- dplyr::bind_cols(master, pred_dia)

  # Adjust ids.
  master_end$id <- aemet_hlp_pad_integer(master_end$id, 7)
  master_end$localidad <- aemet_hlp_pad_integer(master_end$localidad, 5)
  master_end <- dplyr::relocate(
    master_end,
    dplyr::all_of(c("id", "localidad", "fecha")),
    .before = dplyr::all_of("nombre")
  )
  # Clean up.
  master_end <- master_end[!grepl("^origen", names(master_end))]

  master_end
}
