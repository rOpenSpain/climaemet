#' @rdname aemet_forecast
#' @export
#' @encoding UTF-8
aemet_forecast_daily <- function(
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
      apidest = aemet_endpoint_forecast("municipio/diaria", x),
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
        function(id) aemet_forecast_daily_single(id, verbose = verbose)
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

aemet_forecast_daily_single <- function(x, verbose = FALSE) {
  if (is.numeric(x)) {
    x <- aemet_hlp_pad_integer(x, 5)
  }

  pred <- get_data_aemet(
    apidest = aemet_endpoint_forecast("municipio/diaria", x),
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

  # Adjust forecast dates.
  pred_dia$fecha <- as.Date(pred_dia$fecha)
  pred_dia <- dplyr::as_tibble(pred_dia)

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

# Helper to return the first class of each column.

get_col_first_class <- function(df) {
  res <- vapply(
    df,
    function(x) {
      class(x)[1]
    },
    FUN.VALUE = character(1)
  )

  res
}
