#' Extract values from forecasts
#'
#' `r lifecycle::badge("experimental")`
#' [aemet_forecast_vars_available()] lists the variables in output from
#' [aemet_forecast_daily()] or [aemet_forecast_hourly()].
#' [aemet_forecast_tidy()] extracts the forecast for `var` as a
#' [tibble][dplyr::tibble].
#'
#' @rdname aemet_forecast_utils
#' @param x A dataset extracted with [aemet_forecast_daily()] or
#'   [aemet_forecast_hourly()].
#'
#' @param var The name of the forecast variable to extract.
#'
#' @returns A character vector from [aemet_forecast_vars_available()] or a
#'   [tibble][dplyr::tibble] from [aemet_forecast_tidy()].
#'
#' @family forecasts
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' # Hourly values.
#' hourly <- aemet_forecast_hourly(c("15030", "28079"))
#'
#' # Variables available.
#' aemet_forecast_vars_available(hourly)
#'
#' # Get temperature.
#' temp <- aemet_forecast_tidy(hourly, "temperatura")
#'
#' library(dplyr)
#' # Create a forecast time and adjust its time zone.
#' temp_end <- temp |>
#'   mutate(
#'     forecast_time = lubridate::force_tz(
#'       as.POSIXct(fecha) + hora,
#'       tz = "Europe/Madrid"
#'     )
#'   )
#'
#' # Add sunset and sunrise.
#' suns <- temp_end |>
#'   select(nombre, fecha, orto, ocaso) |>
#'   distinct_all() |>
#'   group_by(nombre) |>
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
#'   ) |>
#'   tidyr::drop_na()
#'
#' # Plot.
#'
#' library(ggplot2)
#'
#' ggplot(temp_end) +
#'   geom_rect(data = suns, aes(
#'     xmin = ocaso_end, xmax = orto_lead,
#'     ymin = min(temp_end$temperatura),
#'     ymax = max(temp_end$temperatura)
#'   ), alpha = 0.4) +
#'   geom_line(aes(forecast_time, temperatura), color = "blue4") +
#'   facet_wrap(~nombre, nrow = 2) +
#'   scale_x_datetime(labels = scales::label_date_short()) +
#'   scale_y_continuous(labels = scales::label_number(suffix = "º")) +
#'   labs(
#'     x = "", y = "",
#'     title = "Forecast: temperature",
#'     subtitle = paste("Forecast produced on", format(temp_end$elaborado[1],
#'       usetz = TRUE
#'     ))
#'   )
aemet_forecast_tidy <- function(x, var) {
  # Normalize `elaborado` before unnesting.
  if (any(grepl("elaborado", names(x), fixed = TRUE))) {
    x$elaborado <- as.character(x$elaborado)
  }

  col_types <- get_col_first_class(x)
  keep_cols <- names(col_types[!col_types %in% c("list", "data.frame")])
  keep_cols <- keep_cols[!grepl("origen", keep_cols, fixed = TRUE)]
  if (!var %in% names(col_types)) {
    cli::cli_abort("Column {.field {var}} was not found in {.arg x}.")
  }

  # Recursively unnest nested columns.
  unnest_all <- function(.df) {
    lc <- vapply(
      .df,
      function(x) {
        res <- is.list(x) || is.data.frame(x)
        res
      },
      FUN.VALUE = logical(1)
    )
    lc <- names(lc[lc])

    if (length(lc) == 0) {
      return(.df)
    }
    unnest_all(tidyr::unnest(
      .df,
      cols = dplyr::all_of(lc),
      names_sep = "_",
      keep_empty = TRUE
    ))
  }

  master_ext <- x[unique(c(keep_cols, var))]
  unn <- unnest_all(master_ext)

  unn[!nzchar(unn)] <- NA

  if (any(grepl("elaborado", names(unn), fixed = TRUE))) {
    unn$elaborado <- as.POSIXct(unn$elaborado, tz = "Europe/Madrid")
  }
  unn <- aemet_hlp_guess(unn, preserve = c("id", "municipio"))

  # Check whether the forecast is daily or hourly.
  if (length(unique(unn$fecha)) == 3) {
    is_daily <- FALSE
  } else {
    is_daily <- TRUE
  }

  # Normalize the daily or hourly forecast structure.
  if (is_daily) {
    unn <- aemet_hlp_tidy_forc_daily(unn, var = var)
  } else {
    unn <- aemet_hlp_tidy_forc_hourly(unn, var = var)
  }

  unn
}

#' @rdname aemet_forecast_utils
#' @export
#' @encoding UTF-8
aemet_forecast_vars_available <- function(x) {
  col_types <- get_col_first_class(x)
  var_cols <- names(col_types[col_types %in% c("list", "data.frame")])

  var_cols
}

# Parse forecast periods.

aemet_hlp_tidy_forc_hourly <- function(x, var) {
  # Identify period and value columns.

  period_hora <- names(x)[grepl("periodo|hora", names(x))]
  period_value <- names(x)[grepl("value", names(x), fixed = TRUE)]

  # Format hours.
  horas <- x[[period_hora]]

  if (max(nchar(horas), na.rm = TRUE) == 2) {
    horas <- paste0(horas, ":00")
  } else if (max(nchar(horas), na.rm = TRUE) == 4) {
    horas <- paste0(substr(horas, 1, 2), ":", substr(horas, 3, 4))
  }

  horas <- gsub("24:00", "23:59:59", horas, fixed = TRUE)

  end <- x

  end[[period_hora]] <- horas

  # Normalize period and value column names.
  newn <- names(end)
  newn <- gsub(period_hora, "hora", newn)
  newn <- gsub(period_value, var, newn)

  names(end) <- newn

  end_p <- aemet_hlp_guess(end, preserve = c("id", "municipio"))

  if (var == "vientoAndRachaMax") {
    cleancols <- c(
      "fecha",
      "municipio",
      "hora",
      "vientoAndRachaMax_direccion",
      "vientoAndRachaMax_velocidad"
    )

    cleandf <- end_p[, cleancols]
    cleandf <- tidyr::drop_na(
      cleandf,
      c("vientoAndRachaMax_direccion", "vientoAndRachaMax_velocidad")
    )

    # Build the master data frame.

    master <- end_p[
      ,
      !names(end_p) %in%
        c("vientoAndRachaMax_direccion", "vientoAndRachaMax_velocidad")
    ]
    master <- tidyr::drop_na(master, "vientoAndRachaMax")

    # Regenerate the output.
    tojoin <- intersect(names(master), names(cleandf))

    end_p <- dplyr::full_join(master, cleandf, by = tojoin)
  }

  end_p
}

aemet_hlp_tidy_forc_daily <- function(x, var) {
  period_hora <- names(x)[grepl("periodo|hora", names(x))]
  period_value <- names(x)[grepl("value", names(x), fixed = TRUE)]

  if (var == "viento") {
    period_value <- names(x)[grepl("direccion", names(x), fixed = TRUE)]
  }

  # Replace 00-24 with NA.
  end <- x
  period <- end[[period_hora]]

  if (var %in% c("temperatura", "sensTermica", "humedadRelativa")) {
    period[is.na(period)] <- "00"
  }

  # Construct hour labels.
  period[is.na(period)] <- "00-24"

  newlabs <- ifelse(period == "00-24", var, paste0(var, "_", period))

  # Handle this variable separately.
  if (var == "viento") {
    newlabs <- gsub(var, paste0(var, "_direccion"), newlabs)
  }

  newlabs <- gsub("-", "_", newlabs, fixed = TRUE)

  end[[period_hora]] <- newlabs

  # Handle this variable separately.
  if (var == "estadoCielo") {
    period_desc <- names(x)[grepl("desc", names(x), fixed = TRUE)]

    desc <- end[, c("fecha", "id", period_hora, period_desc)]
    end <- end[, names(end) != period_desc]
  }

  if (var == "viento") {
    period_desc <- names(x)[grepl("veloc", names(x), fixed = TRUE)]

    desc <- end[, c("fecha", "id", period_hora, period_desc)]
    end <- end[, names(end) != period_desc]
  }

  # Convert to wider format.
  end_w <- tidyr::pivot_wider(
    end,
    names_from = dplyr::all_of(period_hora),
    values_from = dplyr::all_of(period_value)
  )

  if (var == "estadoCielo") {
    newlabs2 <- gsub(var, paste0(var, "_descripcion"), newlabs)
    desc[[period_hora]] <- newlabs2

    desc_w <- tidyr::pivot_wider(
      desc,
      names_from = dplyr::all_of(period_hora),
      values_from = dplyr::all_of(period_desc)
    )

    final <- dplyr::left_join(end_w, desc_w, by = c("id", "fecha"))

    # Relocate period columns.
    toend <- names(final)[grepl("[0-9]$", names(final))]

    end_w <- dplyr::relocate(
      final,
      dplyr::all_of(toend),
      .after = dplyr::last_col()
    )
  }

  if (var == "viento") {
    newlabs2 <- gsub("direccion", "velocidad", newlabs, fixed = TRUE)
    desc[[period_hora]] <- newlabs2

    desc_w <- tidyr::pivot_wider(
      desc,
      names_from = dplyr::all_of(period_hora),
      values_from = dplyr::all_of(period_desc)
    )

    final <- dplyr::left_join(end_w, desc_w, by = c("id", "fecha"))

    # Relocate period columns.
    toend <- names(final)[grepl("[0-9]$", names(final))]

    end_w <- dplyr::relocate(
      final,
      dplyr::all_of(toend),
      .after = dplyr::last_col()
    )
  }

  if (var %in% c("temperatura", "sensTermica", "humedadRelativa")) {
    end_w <- end_w[, names(end_w) != paste0(var, "_00")]
  }

  end_w
}

# Extract forecast metadata.
aemet_hlp_meta_forecast <- function(meta) {
  keepcols <- get_col_first_class(meta)

  keep <- meta[keepcols == "list"]$campos[[1]]

  # Build cumulative metadata.
  base_df <- tidyr::drop_na(keep[, c(
    "id",
    "descripcion",
    "tipo_datos",
    "requerido"
  )])
  base_df <- dplyr::as_tibble(base_df)

  # Extract field data.
  pr <- keep$prediccion
  pr <- pr[lapply(pr, length) > 0]
  pr <- pr[[1]][[1]][[1]]

  # Add prediction fields to the cumulative metadata.
  base_df <- dplyr::bind_rows(base_df, pr[, names(base_df)])
  base_df <- tidyr::drop_na(base_df)

  # Process the rest of the fields.
  rst <- setdiff(names(pr), names(base_df))

  others <- lapply(rst, function(x) {
    dd <- pr[[x]]
    dd <- dd[lapply(dd, length) > 0][[1]]

    if ("dato" %in% names(dd)) {
      dat <- dd$dato
      dat <- dat[lapply(dat, length) > 0][[1]]
      dd <- dplyr::bind_rows(dd, dat)[, setdiff(names(dd), "dato")]
    }

    dd$id <- paste0(x, "_", dd$id)
    tidyr::drop_na(dd)
  })
  others_df <- dplyr::bind_rows(others)

  end <- dplyr::bind_rows(base_df, others_df)
  end$id <- gsub("_value$", "", end$id)

  # Use the same format as the rest of the functions.
  end <- as.data.frame(end)
  base_top <- meta[keepcols != "list"]

  base_top <- base_top[rep(1, nrow(end)), ]
  base_top$campos <- end
  base_top
}
