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
#' # Hourly values
#' hourly <- aemet_forecast_hourly(c("15030", "28080"))
#'
#' # Vars available
#' aemet_forecast_vars_available(hourly)
#'
#' # Get temperature
#' temp <- aemet_forecast_extract(hourly, "temperatura")
#'
#' library(dplyr)
#' # Make hour - Need lubridate to adjust timezones
#' temp_end <- temp %>%
#'   mutate(
#'     forecast_time = lubridate::force_tz(
#'       as.POSIXct(fecha) + temperatura_periodo_parsed,
#'       tz = "Europe/Madrid"
#'     )
#'   )
#'
#' # Add also sunset and sunrise
#' suns <- temp_end %>%
#'   select(nombre, fecha, orto, ocaso) %>%
#'   distinct_all() %>%
#'   group_by(nombre) %>%
#'   mutate(
#'     ocaso_end = lubridate::force_tz(
#'       as.POSIXct(fecha) + ocaso,
#'       tz = "Europe/Madrid"
#'     ),
#'     orto_end = lubridate::force_tz(
#'       as.POSIXct(fecha) + orto,
#'       tz = "Europe/Madrid"
#'     ),
#'     orto_lead = lead(orto_end)
#'   ) %>%
#'   tidyr::drop_na()
#'
#'
#'
#' # Plot
#'
#' library(ggplot2)
#'
#' ggplot(temp_end) +
#'   geom_rect(data = suns, aes(
#'     xmin = ocaso_end, xmax = orto_lead,
#'     ymin = min(temp_end$temperatura_value),
#'     ymax = max(temp_end$temperatura_value)
#'   ), alpha = .4) +
#'   geom_line(aes(forecast_time, temperatura_value), color = "blue4") +
#'   facet_wrap(~nombre, nrow = 2) +
#'   scale_x_datetime(labels = scales::label_date_short()) +
#'   scale_y_continuous(labels = scales::label_number(suffix = "º")) +
#'   labs(
#'     x = "", y = "",
#'     title = "Forecast: Temperature",
#'     subtitle = paste("Forecast produced on", format(temp_end$elaborado[1],
#'       usetz = TRUE
#'     ))
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
    unnest_all(tidyr::unnest(.df, cols = dplyr::all_of(lc), names_sep = "_", keep_empty = TRUE))
  }



  master_ext <- x[unique(c(keep_cols, var))]
  unn <- unnest_all(master_ext)

  unn[unn == ""] <- NA

  if (any(grepl("elaborado", names(unn)))) {
    unn$elaborado <- as.POSIXlt(unn$elaborado, tz = "Europe/Madrid")
  }
  unn <- aemet_hlp_guess(unn, preserve = c("id", "municipio"))


  unn <- aemet_hlp_forecast_periods(unn)
  return(unn)
}


#' @rdname aemet_forecast_utils
#' @export
aemet_forecast_vars_available <- function(x) {
  col_types <- get_col_first_class(x)
  var_cols <- names(col_types[col_types %in% c("list", "data.frame")])
  return(var_cols)
}


# Helper, parse periods

aemet_hlp_forecast_periods <- function(x) {
  # Get names
  period_var <- names(x)[grepl("periodo", names(x))]
  period_hora <- names(x)[grepl("hora", names(x))]

  if (length(period_var) == 1) {
    # Check if it is a 00.24 period and then recheck
    is_00_24 <- any(grepl("00-24", x[[period_var]]))

    if (isFALSE(is_00_24)) period_hora <- period_var
  }


  if (length(period_hora) == 1) {
    # Create formatted hour
    hours <- x[[period_hora]]
    end <- x

    # Guess hour format
    if (max(nchar(hours), na.rm = TRUE) == 4) {
      hours_format <- paste0(substr(hours, 1, 2), ":", substr(hours, 3, 4))
    } else {
      hours_format <- paste0(hours, ":00")
      hours_format <- gsub("24:00", "23:59", hours_format)
      hours_format[is.na(hours)] <- NA
    }

    end$parsed <- hours_format

    end <- aemet_hlp_guess(end, preserve = c("id", "municipio"))

    # New names
    newn <- gsub("parsed", paste0(period_hora, "_parsed"), names(end))

    names(end) <- newn
    return(end)
  } else {
    # Convert 00-24

    parsed <- lapply(seq_len(nrow(x)), function(y) {
      d <- x[y, ]

      hours <- unlist(strsplit(d[[period_var]], "-"))

      if (length(hours) < 2) hours <- c("00", "24")

      # Make hours
      sp <- paste0(hours, ":00:00")

      d$init <- sp[1]
      d$end <- sp[2]



      return(d)
    })

    end <- dplyr::bind_rows(parsed)
    end <- aemet_hlp_guess(end, preserve = c("id", "municipio"))

    # Open left interval
    end$end <- end$end - 1
    class(end$end) <- class(end$init)


    # New names
    oldn <- names(end)
    newn <- oldn
    newinit <- paste0(period_var, "_inicio")
    newend <- paste0(period_var, "_final")

    newn <- gsub("init", newinit, newn)
    newn <- gsub("end", newend, newn)

    names(end) <- newn

    return(end)
  }
}
