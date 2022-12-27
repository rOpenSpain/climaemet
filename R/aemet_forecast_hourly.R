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

  pred$elaborado <- as.POSIXlt(gsub("T", " ", pred$elaborado),
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
