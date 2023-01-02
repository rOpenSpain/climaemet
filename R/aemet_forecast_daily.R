#' @export
#' @rdname aemet_forecast
aemet_forecast_daily <- function(x, verbose = FALSE) {
  single <- lapply(x, function(x) {
    res <- try(aemet_forecast_daily_single(x, verbose = verbose), silent = TRUE)
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
  bind <- aemet_hlp_guess(bind, preserve = c("id", "municipio"))

  return(bind)
}

aemet_forecast_daily_single <- function(x, verbose = FALSE) {
  if (is.numeric(x)) x <- sprintf("%05d", x)

  pred <-
    get_data_aemet(
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
