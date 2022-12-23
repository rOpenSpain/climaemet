aemet_forecast_daily <- function(x, verbose = FALSE){

  single <- lapply(x, function(x){
    res <- aemet_forecast_daily_single(x, verbose = verbose)

  })
  bind <- dplyr::bind_rows(single)

  return(bind)

}

aemet_forecast_daily_single <- function(x, verbose = FALSE){
  pred <-
    get_data_aemet(
      apidest = paste0("/api/prediccion/especifica/municipio/diaria/", x),
      verbose = verbose
    )

  # Unnesting this dataset is complex
  col_types <- vapply(pred, class, FUN.VALUE = character(1))
  vars <- names(col_types[col_types %in% c("list", "data.frame")])

  first_lev <- tidyr::unnest(pred, col = dplyr::all_of(vars), names_sep = "_")

  # Extract prediccion dia
  pred_dia <- first_lev$prediccion_dia[[1]]
  master <- first_lev[, names(first_lev) != "prediccion_dia"]


  # Adjust
  pred_dia$fecha <- as.Date(pred_dia$fecha)
  pred_dia <- tibble::as_tibble(pred_dia)

  master_end <- dplyr::bind_cols(master, pred_dia)
  return(master_end)
}


