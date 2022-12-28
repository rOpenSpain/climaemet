#' Helper functions for extracting forecasts
#'
#' @description
#' Helpers for [aemet_forecast_daily()] and [aemet_forecast_hourly()]:
#'
#'  - [aemet_forecast_vars_available()] extracts the values available on
#'    the dataset.
#'  - [aemet_forecast_extract()] produces a `tibble` with the forecast
#'    for `var`.
#'
#' @rdname aemet_forecast_utils
#' @family forecasts
#'
#' @param x A database extracted with [aemet_forecast_daily()] or
#'   [aemet_forecast_hourly()].
#'
#' @param var Name of the desired var to extract
#'
#' @return A vector of characters ([aemet_forecast_vars_available()])
#'   or a tibble ([aemet_forecast_extract()]).
#'
#' @examplesIf aemet_detect_api_key()
#'
#' # Hourly values
#' hourly <- aemet_forecast_hourly(c("15030", "38038"))
#'
#' # Vars available
#' aemet_forecast_vars_available(hourly)
#'
#' # Get temperature
#' temp <- aemet_forecast_extract(hourly, "temperatura")
#'
#' library(dplyr)
#' # Make hour: The approach differs depending on the metric
#' temp_end <- temp %>%
#'   mutate(
#'     hour = paste0(temperatura_periodo, ":00"),
#'     forecast_time = as.POSIXct(paste(fecha, hour, tz = "Europe/Madrid"))
#'   )
#'
#'
#' # Plot
#'
#' library(ggplot2)
#'
#' ggplot(temp_end) +
#'   geom_col(aes(forecast_time, temperatura_value), fill = "blue4") +
#'   facet_wrap(~nombre, nrow = 2) +
#'   scale_x_datetime(labels = scales::label_date_short()) +
#'   scale_y_continuous(labels = scales::label_number(suffix = "º")) +
#'   labs(
#'     x = "", y = "",
#'     title = "Forecast: Temperature",
#'     subtitle = paste("Forecast produced on", format(temp_end$elaborado[1], usetz = TRUE))
#'   )
#' @export
aemet_forecast_extract <- function(x, var) {
  # Work with elaborado
  if (any(grepl("elaborado", names(x)))) {
    x$elaborado <- as.character(x$elaborado)
  }

  col_types <- get_col_first_class(x)
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

  if (any(grepl("elaborado", names(unn)))) {
    unn$elaborado <- as.POSIXlt(unn$elaborado, tz = "Europe/Madrid")
  }
  unn <- aemet_hlp_guess(unn, preserve = "id")
  return(unn)
}


#' @rdname aemet_forecast_utils
#' @export
aemet_forecast_vars_available <- function(x) {
  col_types <- get_col_first_class(x)
  var_cols <- names(col_types[col_types %in% c("list", "data.frame")])
  return(var_cols)
}
