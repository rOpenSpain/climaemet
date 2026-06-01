#' Municipality forecast dataset
#'
#' Get daily or hourly weather forecasts for one or more municipalities.
#'
#' @rdname aemet_forecast
#' @family aemet_api_data
#' @family forecasts
#'
#' @param x Character vector with municipality codes to extract.
#'   For convenience, \CRANpkg{climaemet} provides these data in the
#'   [aemet_munic] dataset (see `municipio` field) as of January 2024.
#' @param extract_metadata Logical. If `TRUE`, the output is a
#'   [tibble][tibble::tbl_df] with the description of the fields. See also
#'   [get_metadata_aemet()].
#' @inheritParams get_data_aemet
#' @inheritParams aemet_last_obs
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @details
#'
#' Forecasts provided by the AEMET API have a complex structure.
#' Although \CRANpkg{climaemet} returns a [tibble][tibble::tbl_df], each
#' forecast value is provided as a nested [tibble][tibble::tbl_df].
#' The [aemet_forecast_tidy()] helper can unnest these values and provide a
#' single unnested [tibble][tibble::tbl_df] for the requested variable.
#'
#' If `extract_metadata = TRUE` a simple [tibble][tibble::tbl_df] describing
#' the value of each field of the forecast is returned.
#'
#' @return A nested [tibble][tibble::tbl_df]. Forecast values can be
#' extracted with [aemet_forecast_tidy()]. See also **Details**.
#'
#' @seealso
#' [aemet_munic] for municipality codes and \CRANpkg{mapSpain} package for
#' working with `sf` objects of municipalities (see
#' [mapSpain::esp_get_munic()] and **Examples**).
#'
#' @examplesIf aemet_detect_api_key()
#'
#' # Select a city
#' data("aemet_munic")
#' library(dplyr)
#' munis <- aemet_munic |>
#'   filter(municipio_nombre %in% c("Santiago de Compostela", "Lugo")) |>
#'   pull(municipio)
#'
#' daily <- aemet_forecast_daily(munis)
#'
#' # Metadata
#' meta <- aemet_forecast_daily(munis, extract_metadata = TRUE)
#' glimpse(meta$campos)
#'
#' # Variables available.
#' aemet_forecast_vars_available(daily)
#'
#' # This is nested.
#' daily |>
#'   select(municipio, fecha, nombre, temperatura)
#'
#' # Select and unnest.
#' daily_temp <- aemet_forecast_tidy(daily, "temperatura")
#'
#' # This is not nested.
#' daily_temp
#'
#' # Wrangle and plot.
#' daily_temp_end <- daily_temp |>
#'   select(
#'     elaborado, fecha, municipio, nombre, temperatura_minima,
#'     temperatura_maxima
#'   ) |>
#'   tidyr::pivot_longer(cols = contains("temperatura"))
#'
#' # Plot
#' library(ggplot2)
#' ggplot(daily_temp_end) +
#'   geom_line(aes(fecha, value, color = name)) +
#'   facet_wrap(~nombre, ncol = 1) +
#'   scale_color_manual(
#'     values = c("red", "blue"),
#'     labels = c("max", "min")
#'   ) +
#'   scale_x_date(
#'     labels = scales::label_date_short(),
#'     breaks = "day"
#'   ) +
#'   scale_y_continuous(
#'     labels = scales::label_comma(suffix = "º")
#'   ) +
#'   theme_minimal() +
#'   labs(
#'     x = "", y = "",
#'     color = "",
#'     title = "Forecast: 7-day temperature",
#'     subtitle = paste(
#'       "Forecast produced on",
#'       format(daily_temp_end$elaborado[1], usetz = TRUE)
#'     )
#'   )
#'
#' # Spatial with mapSpain
#' library(mapSpain)
#' library(sf)
#'
#' lugo_sf <- esp_get_munic(munic = "Lugo") |>
#'   select(LAU_CODE)
#'
#' daily_temp_end_lugo_sf <- daily_temp_end |>
#'   filter(nombre == "Lugo" & name == "temperatura_maxima") |>
#'   # Join by LAU_CODE.
#'   left_join(lugo_sf, by = c("municipio" = "LAU_CODE")) |>
#'   st_as_sf()
#'
#' ggplot(daily_temp_end_lugo_sf) +
#'   geom_sf(aes(fill = value)) +
#'   facet_wrap(~fecha) +
#'   scale_fill_gradientn(
#'     colors = c("blue", "red"),
#'     guide = guide_legend()
#'   ) +
#'   labs(
#'     main = "Forecast: 7-day max temperature",
#'     subtitle = "Lugo, ES"
#'   )
#' @export
#' @encoding UTF-8
aemet_forecast_hourly <- function(
  x,
  verbose = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. API call ----

  ## Metadata ----
  if (extract_metadata) {
    mun <- climaemet::aemet_munic
    x <- mun$municipio[1]

    meta <- get_metadata_aemet(
      apidest = aemet_endpoint_forecast("municipio/horaria", x),
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
        function(id) aemet_forecast_hourly_single(id, verbose = verbose)
      )
    },
    progress = progress,
    verbose = verbose
  )

  final_result <- aemet_hlp_finalize_forecast(
    final_result,
    id_width = 5,
    preserve = c("id", "municipio")
  )

  final_result
}

aemet_forecast_hourly_single <- function(x, verbose = FALSE) {
  if (is.numeric(x)) {
    x <- aemet_hlp_pad_integer(x, 5)
  }

  pred <- get_data_aemet(
    apidest = aemet_endpoint_forecast("municipio/horaria", x),
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
  pred_dia <- tibble::as_tibble(pred_dia)
  pred_dia$fecha <- as.Date(pred_dia$fecha)
  master <- first_lev[, names(first_lev) != "prediccion_dia"]
  master_end <- dplyr::bind_cols(master, pred_dia)

  # Add the initial id.
  master_end$municipio <- x
  master_end <- dplyr::relocate(
    master_end,
    dplyr::all_of("municipio"),
    .before = dplyr::all_of("nombre")
  )

  master_end
}
