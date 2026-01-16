#' Forecast database by municipality
#'
#' Get a database of daily or hourly weather forecasts for a given municipality.
#'
#' @family aemet_api_data
#' @family forecasts
#'
#' @param x A vector of municipality codes to extract. For convenience,
#'   \CRANpkg{climaemet} provides this data on the dataset [aemet_munic]
#'   (see `municipio` field) as of January 2024.
#' @param extract_metadata Logical `TRUE/FALSE`. On `TRUE` the output is
#'   a [`tibble`][tibble::tibble()] with the description of the fields. See also
#'   [get_metadata_aemet()].
#' @inheritParams get_data_aemet
#' @inheritParams aemet_last_obs
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @return A nested [`tibble`][tibble::tibble()]. Forecasted values can be
#' extracted with [aemet_forecast_tidy()]. See also **Details**.
#'
#' @export
#' @rdname aemet_forecast
#' @seealso
#' [aemet_munic] for municipality codes and \CRANpkg{mapSpain} package for
#' working with `sf` objects of municipalities (see
#' [mapSpain::esp_get_munic()] and **Examples**).
#'
#'
#' @details
#'
#' Forecasts format provided by the AEMET API have a complex structure.
#' Although \CRANpkg{climaemet} returns a [`tibble`][tibble::tibble()], each
#' forecasted value is provided as a nested [`tibble`][tibble::tibble()].
#' [aemet_forecast_tidy()] helper function can unnest these values an provide a
#' single unnested [`tibble`][tibble::tibble()] for the requested variable.
#'
#' If `extract_metadata = TRUE` a simple [`tibble`][tibble::tibble()] describing
#' the value of each field of the forecast is returned.
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
#' # Vars available
#' aemet_forecast_vars_available(daily)
#'
#'
#' # This is nested
#' daily |>
#'   select(municipio, fecha, nombre, temperatura)
#'
#' # Select and unnest
#' daily_temp <- aemet_forecast_tidy(daily, "temperatura")
#'
#' # This is not
#' daily_temp
#'
#' # Wrangle and plot
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
#'   # Join by LAU_CODE
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
aemet_forecast_hourly <- function(
  x,
  verbose = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. API call -----

  ## Metadata ----
  if (extract_metadata) {
    mun <- climaemet::aemet_munic
    x <- mun$municipio[1]

    meta <- get_metadata_aemet(
      apidest = paste0("/api/prediccion/especifica/municipio/horaria/", x),
      verbose = verbose
    )
    meta <- aemet_hlp_meta_forecast(meta)
    return(meta)
  }

  ## Normal call ----

  # Make calls on loop for progress bar
  final_result <- list() # Store results

  # Deactive progressbar if verbose
  if (verbose) {
    progress <- FALSE
  }
  if (!cli::is_dynamic_tty()) {
    progress <- FALSE
  }

  # nolint start
  # nocov start
  if (progress) {
    opts <- options()
    options(
      cli.progress_bar_style = "fillsquares",
      cli.progress_show_after = 3,
      cli.spinner = "clock"
    )

    cli::cli_progress_bar(
      format = paste0(
        "{cli::pb_spin} AEMET API ({cli::pb_current}/{cli::pb_total}) ",
        "| {cli::pb_bar} {cli::pb_percent}  ",
        "| ETA:{cli::pb_eta} [{cli::pb_elapsed}]"
      ),
      total = length(x),
      clear = FALSE
    )
  }

  # nocov end
  # nolint end

  for (id in x) {
    if (progress) {
      cli::cli_progress_update() # nocov
    }
    df <- try(
      aemet_forecast_hourly_single(id, verbose = verbose),
      silent = TRUE
    )
    if (inherits(df, "try-error")) {
      cli::cli_alert_warning(
        "AEMET API call for {.val {id}} returned an error."
      )
      cli::cli_alert_info("Return NULL for this query.")

      df <- NULL
    }

    final_result <- c(final_result, list(df))
  }

  # nolint start
  # nocov start
  if (progress) {
    cli::cli_progress_done()
    options(
      cli.progress_bar_style = opts$cli.progress_bar_style,
      cli.progress_show_after = opts$cli.progress_show_after,
      cli.spinner = opts$cli.spinner
    )
  }
  # nocov end
  # nolint end

  # Final tweaks
  final_result <- dplyr::bind_rows(final_result)
  # Preserve format
  final_result$id <- sprintf("%05d", as.numeric(final_result$id))
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(final_result, preserve = c("id", "municipio"))

  final_result
}

aemet_forecast_hourly_single <- function(x, verbose = FALSE) {
  if (is.numeric(x)) {
    x <- sprintf("%05d", x)
  }

  pred <- get_data_aemet(
    apidest = paste0(
      "/api/prediccion/especifica/municipio/horaria/",
      x
    ),
    verbose = verbose
  )

  pred$elaborado <- as.POSIXct(
    gsub("T", " ", pred$elaborado, fixed = TRUE),
    tz = "Europe/Madrid"
  )

  # Unnesting this dataset is complex
  col_types <- get_col_first_class(pred)
  vars <- names(col_types[col_types %in% c("list", "data.frame")])

  first_lev <- tidyr::unnest(
    pred,
    col = dplyr::all_of(vars),
    names_sep = "_",
    keep_empty = TRUE
  )

  # Extract prediccion dia
  pred_dia <- first_lev$prediccion_dia[[1]]
  pred_dia <- tibble::as_tibble(pred_dia)
  pred_dia$fecha <- as.Date(pred_dia$fecha)
  master <- first_lev[, names(first_lev) != "prediccion_dia"]
  master_end <- dplyr::bind_cols(master, pred_dia)

  # Add initial id
  master_end$municipio <- x
  master_end <- dplyr::relocate(
    master_end,
    dplyr::all_of("municipio"),
    .before = dplyr::all_of("nombre")
  )

  master_end
}
