aemet_forecast_vars_available <- function(x) {
  col_types <- vapply(x, class, FUN.VALUE = character(1))
  var_cols <- names(col_types[col_types %in% c("list", "data.frame")])
  return(var_cols)
}


aemet_forecast_extract <- function(x, var) {
  col_types <- vapply(x, class, FUN.VALUE = character(1))
  keep_cols <- names(col_types[!col_types %in% c("list", "data.frame")])
  keep_cols <- keep_cols[!grepl("origen", keep_cols)]
  if (!var %in% names(col_types)) {
    stop(
      "Var '", var, "' not available in the ",
      "current dataset."
    )
  }


  # Helper fun
  unnest_all <- function(.df) {
    lc <- vapply(.df, function(x) {
      res <- is.list(x) || is.data.frame(x)
      return(res)
    }, FUN.VALUE = logical(1))
    lc <- names(lc[lc == TRUE])

    if (length(lc) == 0) {
      return(.df)
    }
    unnest_all(tidyr::unnest(.df, cols = dplyr::all_of(lc), names_sep = "_"))
  }

  master_ext <- x[unique(c(keep_cols, var))]
  unn <- unnest_all(master_ext)

  unn[unn == ""] <- NA
  return(unn)
}
