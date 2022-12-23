aemet_forecast_hourly <- function(x, verbose = FALSE) {
  single <- lapply(x, function(x) {
    res <- aemet_forecast_hourly_single(x, verbose = verbose)
  })
  bind <- dplyr::bind_rows(single)

  return(bind)
}

aemet_forecast_hourly_single <- function(x, verbose = FALSE) {
  pred <-
    get_data_aemet(
      apidest = paste0("/api/prediccion/especifica/municipio/horaria/", x),
      verbose = verbose
    )

  # Unnesting this dataset is complex
  col_types <- vapply(pred, class, FUN.VALUE = character(1))
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
