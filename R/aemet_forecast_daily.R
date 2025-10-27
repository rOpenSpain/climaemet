#' @export
#' @rdname aemet_forecast
aemet_forecast_daily <- function(x, verbose = FALSE, extract_metadata = FALSE,
                                 progress = TRUE) {
  # 1. API call -----

  ## Metadata ----
  if (extract_metadata) {
    mun <- climaemet::aemet_munic
    x <- mun$municipio[1]

    meta <- get_metadata_aemet(
      apidest = paste0("/api/prediccion/especifica/municipio/diaria/", x),
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
    df <- try(aemet_forecast_daily_single(id, verbose = verbose), silent = TRUE)

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
  final_result$id <- sprintf("%05d", as.numeric(final_result$id))
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(final_result,
    preserve = c("id", "municipio")
  )

  final_result
}

aemet_forecast_daily_single <- function(x, verbose = FALSE) {
  if (is.numeric(x)) x <- sprintf("%05d", x)

  pred <- get_data_aemet(
    apidest = paste0("/api/prediccion/especifica/municipio/diaria/", x),
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


  # Adjust
  pred_dia$fecha <- as.Date(pred_dia$fecha)
  pred_dia <- tibble::as_tibble(pred_dia)

  master_end <- dplyr::bind_cols(master, pred_dia)

  # Add initial id
  master_end$municipio <- x
  master_end <- dplyr::relocate(master_end, dplyr::all_of("municipio"),
    .before = dplyr::all_of("nombre")
  )


  return(master_end)
}


# Helper to return first class of column

get_col_first_class <- function(df) {
  res <- vapply(df, function(x) {
    return(class(x)[1])
  }, FUN.VALUE = character(1))

  return(res)
}
