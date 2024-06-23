#' Forecast database for beaches
#'
#' Get a database of daily weather forecasts for a beach. Beach database can
#' be accessed with [aemet_beaches()].
#'
#' @family aemet_api_data
#' @family forecasts
#'
#' @param x A vector of beaches codes to extract. See [aemet_beaches()].
#' @inheritParams get_data_aemet
#' @inheritParams aemet_last_obs
#'
#' @inheritSection aemet_daily_clim API Key
#'
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object.
#'
#' @export
#' @seealso
#' [aemet_beaches()] for beaches codes.
#'
#'
#' @examplesIf aemet_detect_api_key()
#' # Forecast for beaches in Palma, Mallorca
#' library(dplyr)
#' library(ggplot2)
#'
#' palma_b <- aemet_beaches() %>%
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
#'     subtitle = "Forecast 3-days",
#'     x = "Date",
#'     y = "Temperature (Celsius)",
#'     color = "Beach"
#'   )
aemet_forecast_beaches <- function(x, verbose = FALSE, return_sf = FALSE,
                                   extract_metadata = FALSE, progress = TRUE) {
  # 1. API call -----

  ## Metadata ----
  if (extract_metadata) {
    mun <- aemet_beaches()
    x <- mun$ID_PLAYA[1]

    meta <- get_metadata_aemet(
      apidest = paste0("/api/prediccion/especifica/playa/", x),
      verbose = verbose
    )
    meta <- aemet_hlp_meta_forecast(meta)
    return(meta)
  }

  ## Normal call ----

  # Make calls on loop for progress bar
  final_result <- list() # Store results

  # Deactive progressbar if verbose
  if (verbose) progress <- FALSE
  if (!cli::is_dynamic_tty()) progress <- FALSE

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
      total = length(x), clear = FALSE
    )
  }

  # nocov end
  # nolint end

  for (id in x) {
    if (progress) cli::cli_progress_update() # nocov
    df <- try(aemet_forecast_beach_single(id, verbose = verbose), silent = TRUE)

    if (inherits(df, "try-error")) {
      message(
        "\nAEMET API call for '", id, "' returned an error\n",
        "Return NULL for this query"
      )

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
  final_result$id <- sprintf("%07d", as.numeric(final_result$id))
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(final_result,
    preserve = c("id", "localidad")
  )


  # Check spatial----
  if (return_sf) {
    # Coordinates from beaches
    sf_beaches <- aemet_beaches(verbose = verbose, return_sf = FALSE)
    sf_beaches <- sf_beaches[c("ID_PLAYA", "latitud", "longitud")]
    names(sf_beaches) <- c("id", "latitud", "longitud")
    final_result <- dplyr::left_join(final_result, sf_beaches,
      by = "id"
    )
    final_result <- aemet_hlp_sf(final_result, "latitud", "longitud", verbose)
  }

  final_result
}

aemet_forecast_beach_single <- function(x, verbose = FALSE) {
  if (is.numeric(x)) x <- sprintf("%07d", x)

  pred <- get_data_aemet(
    apidest = paste0("/api/prediccion/especifica/playa/", x),
    verbose = verbose
  )

  pred$elaborado <- as.POSIXct(gsub("T", " ", pred$elaborado),
    tz = "Europe/Madrid"
  )

  # Unnesting this dataset is complex
  col_types <- get_col_first_class(pred)
  vars <- names(col_types[col_types %in% c("list", "data.frame")])

  first_lev <- tidyr::unnest(pred,
    col = dplyr::all_of(vars), names_sep = "_",
    keep_empty = TRUE
  )

  # Extract prediccion dia
  pred_dia <- first_lev$prediccion_dia[[1]]
  master <- first_lev[, names(first_lev) != "prediccion_dia"]

  vars_prd <- names(pred_dia)
  pred_dia <- tidyr::unnest(pred_dia,
    col = dplyr::all_of(vars_prd),
    names_sep = "_",
    keep_empty = TRUE
  )

  # Adjust
  pred_dia$fecha <- as.Date(as.character(pred_dia$fecha),
    tryFormats = c("%Y-%m-%d", "%Y/%m/%d", "%Y%m%d")
  )
  pred_dia <- tibble::as_tibble(pred_dia)

  master_end <- dplyr::bind_cols(master, pred_dia)

  # Adjust ids
  master_end$id <- sprintf("%07d", master_end$id)
  master_end$localidad <- sprintf("%05d", master_end$localidad)
  master_end <- dplyr::relocate(master_end,
    dplyr::all_of(c("id", "localidad", "fecha")),
    .before = dplyr::all_of("nombre")
  )
  # clean up
  master_end <- master_end[!grepl("^origen", names(master_end))]


  return(master_end)
}
