#' Forecast database by municipality
#'
#' Get a database of daily or hourly weather forecasts for a given municipality.
#'
#' @family aemet_api_data
#' @family forecasts
#'
#' @param x A vector of municipalities code to extract. For convenience,
#'   \pkg{climaemet} provides this data on the dataset [aemet_munic]
#'   (see `municipio` field).
#' @inheritParams get_data_aemet
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @return A nested `tibble`. Forecasted values can be extracted with
#'   [aemet_forecast_extract()]. See also **Details**
#'
#' @export
#' @rdname aemet_forecast
#'
#' @details
#'
#' Forecasts format provided by the AEMET API have a complex structure.
#' Although \pkg{climaemet} returns a `tibble`, each forecasted value is
#' provided as a nested `tibble`. [aemet_forecast_extract()] helper function can
#' unnest these values an provide a single unnested `tibble` for the requested
#' variable.
#'
#' @examplesIf aemet_detect_api_key()
#'
#' # Select a city
#' data("aemet_munic")
#' library(dplyr)
#' munis <- aemet_munic %>%
#'   filter(municipio_nombre %in% c(
#'     "Santiago de Compostela",
#'     "Lugo"
#'   )) %>%
#'   pull(municipio)
#'
#' daily <- aemet_forecast_daily(munis)
#'
#' # Vars available
#' aemet_forecast_vars_available(daily)
#'
#'
#' # This is nested
#' daily %>%
#'   select(id, probPrecipitacion)
#'
#' # Select and unnest
#' daily_prec <- aemet_forecast_extract(daily, "probPrecipitacion")
#'
#' # This is not
#' daily_prec
#'
#' # Wrangle and plot
#' daily_prec_end <- daily_prec %>%
#'   filter(probPrecipitacion_periodo == "00-24" | is.na(probPrecipitacion_periodo))
#'
#' # Plot
#' library(ggplot2)
#' ggplot(daily_prec_end) +
#'   geom_col(aes(fecha, probPrecipitacion_value), fill = "lightblue", alpha = 0.75) +
#'   facet_wrap(~nombre, ncol = 1) +
#'   scale_x_date(labels = scales::label_date_short()) +
#'   scale_y_continuous(
#'     limits = c(0, 100),
#'     labels = scales::label_comma(suffix = "%")
#'   ) +
#'   theme_minimal() +
#'   labs(
#'     x = "", y = "",
#'     title = "Forecast: Precipitation probability",
#'     subtitle = paste("Forecast produced on", format(daily_prec_end$elaborado[1], usetz = TRUE))
#'   )
aemet_forecast_hourly <- function(x, verbose = FALSE) {
  single <- lapply(x, function(x) {
    res <- try(aemet_forecast_hourly_single(x, verbose = verbose), silent = TRUE)
    if (inherits(res, "try-error")) {
      message(
        "\nAEMET API call for '", x, "' returned an error\n",
        "Return NULL for this query"
      )
      return(NULL)
    }
    return(res)
  })
  bind <- dplyr::bind_rows(single)
  # Preserve format
  bind$id <- sprintf("%05d", as.numeric(bind$id))
  bind <- aemet_hlp_guess(bind, preserve = "id")
  return(bind)
}

aemet_forecast_hourly_single <- function(x, verbose = FALSE) {
  pred <-
    get_data_aemet(
      apidest = paste0("/api/prediccion/especifica/municipio/horaria/", x),
      verbose = verbose
    )


  pred$elaborado <- as.POSIXct(gsub("T", " ", pred$elaborado),
    tz = "Europe/Madrid"
  )

  # Unnesting this dataset is complex
  col_types <- get_col_first_class(pred)
  vars <- names(col_types[col_types %in% c("list", "data.frame")])

  first_lev <- tidyr::unnest(pred, col = dplyr::all_of(vars), names_sep = "_")

  # Extract prediccion dia
  pred_dia <- first_lev$prediccion_dia[[1]]
  pred_dia <- tibble::as_tibble(pred_dia)
  pred_dia$fecha <- as.Date(pred_dia$fecha)
  master <- first_lev[, names(first_lev) != "prediccion_dia"]
  master_end <- dplyr::bind_cols(master, pred_dia)

  return(master_end)
}
