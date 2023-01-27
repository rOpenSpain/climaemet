#' Helper functions for extracting forecasts
#'
#' @description
#' Helpers for [aemet_forecast_daily()] and [aemet_forecast_hourly()]:
#'
#'  - [aemet_forecast_vars_available()] extracts the values available on
#'    the dataset.
#'  - [aemet_forecast_tidy()] produces a tidy `tibble` with the forecast
#'    for `var`.
#'    \if{html}{\figure{lifecycle-experimental.svg}{options: alt="[Experimental]"}}
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
#'   or a tibble ([aemet_forecast_tidy()]).
#'
#' @examplesIf aemet_detect_api_key()
#' # Hourly values
#' hourly <- aemet_forecast_hourly(c("15030", "28080"))
#'
#' # Vars available
#' aemet_forecast_vars_available(hourly)
#'
#' # Get temperature
#' temp <- aemet_forecast_tidy(hourly, "temperatura")
#'
#' library(dplyr)
#' # Make hour - Need lubridate to adjust timezones
#' temp_end <- temp %>%
#'   mutate(
#'     forecast_time = lubridate::force_tz(
#'       as.POSIXct(fecha) + hora,
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
#'     ymin = min(temp_end$temperatura),
#'     ymax = max(temp_end$temperatura)
#'   ), alpha = .4) +
#'   geom_line(aes(forecast_time, temperatura), color = "blue4") +
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
aemet_forecast_tidy <- function(x, var) {
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
    unnest_all(tidyr::unnest(.df,
      cols = dplyr::all_of(lc),
      names_sep = "_", keep_empty = TRUE
    ))
  }



  master_ext <- x[unique(c(keep_cols, var))]
  unn <- unnest_all(master_ext)

  unn[unn == ""] <- NA

  if (any(grepl("elaborado", names(unn)))) {
    unn$elaborado <- as.POSIXct(unn$elaborado, tz = "Europe/Madrid")
  }
  unn <- aemet_hlp_guess(unn, preserve = c("id", "municipio"))

  # Check if is daily or hourly
  if (length(unique(unn$fecha)) == 3) {
    is_daily <- FALSE
  } else {
    is_daily <- TRUE
  }

  # Tidy
  if (is_daily) {
    unn <- aemet_hlp_tidy_forc_daily(unn, var = var)
  } else {
    unn <- aemet_hlp_tidy_forc_hourly(unn, var = var)
  }

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

aemet_hlp_tidy_forc_hourly <- function(x, var) {
  # Format values

  period_hora <- names(x)[grepl("periodo|hora", names(x))]
  period_value <- names(x)[grepl("value", names(x))]

  # Format hour
  horas <- x[[period_hora]]

  if (max(nchar(horas), na.rm = TRUE) == 2) {
    horas <- paste0(horas, ":00")
  } else if (max(nchar(horas), na.rm = TRUE) == 4) {
    horas <- paste0(substr(horas, 1, 2), ":", substr(horas, 3, 4))
  }

  horas <- gsub("24:00", "23:59:59", horas)

  end <- x

  end[[period_hora]] <- horas

  # New names
  newn <- names(end)
  newn <- gsub(period_hora, "hora", newn)
  newn <- gsub(period_value, var, newn)

  names(end) <- newn

  end_p <- aemet_hlp_guess(end, preserve = c("id", "municipio"))


  if (var == "vientoAndRachaMax") {
    cleancols <- c("fecha", "municipio", "hora", "vientoAndRachaMax_direccion", "vientoAndRachaMax_velocidad")

    cleandf <- end_p[, cleancols]
    cleandf <- tidyr::drop_na(cleandf, c("vientoAndRachaMax_direccion", "vientoAndRachaMax_velocidad"))


    # Masterdf

    master <- end_p[, !names(end_p) %in% c("vientoAndRachaMax_direccion", "vientoAndRachaMax_velocidad")]
    master <- tidyr::drop_na(master, c("vientoAndRachaMax"))

    # Regenerate
    tojoin <- intersect(names(master), names(cleandf))


    end_p <- dplyr::full_join(master, cleandf, by = tojoin)
  }

  return(end_p)
}


aemet_hlp_tidy_forc_daily <- function(x, var) {
  period_hora <- names(x)[grepl("periodo|hora", names(x))]
  period_value <- names(x)[grepl("value", names(x))]

  if (var == "viento") {
    period_value <- names(x)[grepl("direccion", names(x))]
  }

  # Replace 00-24 for NA
  end <- x
  period <- end[[period_hora]]

  if (var %in% c("temperatura", "sensTermica", "humedadRelativa")) {
    period[is.na(period)] <- "00"
  }


  # Construct hours
  period[is.na(period)] <- "00-24"

  newlabs <- ifelse(period == "00-24", var, paste0(var, "_", period))

  # Different for this var
  if (var == "viento") {
    newlabs <- gsub(var, paste0(var, "_direccion"), newlabs)
  }

  newlabs <- gsub("-", "_", newlabs)

  end[[period_hora]] <- newlabs

  # Different for this var
  if (var == "estadoCielo") {
    period_desc <- names(x)[grepl("desc", names(x))]

    desc <- end[, c("fecha", "id", period_hora, period_desc)]
    end <- end[, names(end) != period_desc]
  }

  if (var == "viento") {
    period_desc <- names(x)[grepl("veloc", names(x))]

    desc <- end[, c("fecha", "id", period_hora, period_desc)]
    end <- end[, names(end) != period_desc]
  }

  # Wider
  end_w <- tidyr::pivot_wider(end,
    names_from = dplyr::all_of(period_hora),
    values_from = dplyr::all_of(period_value)
  )


  if (var == "estadoCielo") {
    newlabs2 <- gsub(var, paste0(var, "_descripcion"), newlabs)
    desc[[period_hora]] <- newlabs2

    desc_w <- tidyr::pivot_wider(desc,
      names_from = dplyr::all_of(period_hora),
      values_from = dplyr::all_of(period_desc)
    )

    final <- dplyr::left_join(end_w, desc_w, by = c("id", "fecha"))

    # Relocate
    toend <- names(final)[grepl("[0-9]$", names(final))]

    end_w <- dplyr::relocate(final, dplyr::all_of(toend),
      .after = dplyr::last_col()
    )
  }

  if (var == "viento") {
    newlabs2 <- gsub("direccion", "velocidad", newlabs)
    desc[[period_hora]] <- newlabs2

    desc_w <- tidyr::pivot_wider(desc,
      names_from = dplyr::all_of(period_hora),
      values_from = dplyr::all_of(period_desc)
    )

    final <- dplyr::left_join(end_w, desc_w, by = c("id", "fecha"))

    # Relocate
    toend <- names(final)[grepl("[0-9]$", names(final))]

    end_w <- dplyr::relocate(final, dplyr::all_of(toend),
      .after = dplyr::last_col()
    )
  }


  if (var %in% c("temperatura", "sensTermica", "humedadRelativa")) {
    end_w <- end_w[, !(names(end_w) == paste0(var, "_00"))]
  }

  return(end_w)
}
