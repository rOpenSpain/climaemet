#' Convert DMS coordinates to decimal degrees
#'
#' Converts degrees, minutes and seconds to decimal degrees.
#'
#' @rdname dms2decdegrees
#'
#' @param input A character string containing DMS coordinates.
#'
#' @returns A numeric value.
#'
#' @note Code for `dms2decdegrees()` was modified from the project at
#' <https://github.com/SevillaR/aemet>.
#'
#' @family helpers
#'
#' @export
#' @encoding UTF-8
#' @examples
#' dms2decdegrees("055245W")
dms2decdegrees <- function(input = NULL) {
  if (any(is.null(input), !is.character(input))) {
    cli::cli_abort(paste0(
      "{.arg input} must be a character string, ",
      "not {.obj_type_friendly {input}}."
    ))
  }

  deg <- as.numeric(substr(input, 0, 2))
  min <- as.numeric(substr(input, 3, 4))
  sec <- as.numeric(substr(input, 5, 6))
  x <- deg + min / 60 + sec / 3600
  x <- ifelse(substr(input, 7, 8) == "W", -x, x)
  x <- ifelse(substr(input, 7, 8) == "S", -x, x)

  x
}

#' @rdname dms2decdegrees
#' @export
#' @encoding UTF-8
#' @examples
#' dms2decdegrees_2("-3º 40' 37\"")
dms2decdegrees_2 <- function(input = NULL) {
  input_2 <- iconv(input, "latin1", "ASCII", sub = " ")
  minus <- ifelse(grepl("^-", input_2), -1, 1)
  # Remove nonnumeric signs.
  input_3 <- gsub("[^0-9]", " ", input_2)

  pieces <- unlist(strsplit(input_3, split = " "))
  pieces <- as.double(pieces[nzchar(pieces)])

  # Validate coordinate pieces.
  if (length(pieces) != 3) {
    cli::cli_abort("Cannot parse coordinate pieces from {.arg input}.")
  }

  # Convert pieces and sign.
  dec <- minus * sum(pieces / c(1, 60, 60^2))

  dec
}

#' First and last day of a year
#'
#' Returns the first or last calendar day of a year.
#'
#' @rdname day_of_year
#'
#' @param year A numeric year in `YYYY` format.
#'
#' @returns A character string containing a date in `YYYY-MM-DD` format.
#'
#' @family helpers
#'
#' @export
#' @encoding UTF-8
#' @examples
#' first_day_of_year(2000)
#' last_day_of_year(2020)
first_day_of_year <- function(year = NULL) {
  if (any(is.null(year), !is.numeric(year))) {
    cli::cli_abort(paste0(
      "{.arg year} must be numeric, ",
      "not {.obj_type_friendly {year}}."
    ))
  }

  date <- as.character(paste0(year, "-01-01"))

  date
}

#' @rdname day_of_year
#' @export
#' @encoding UTF-8
last_day_of_year <- function(year = NULL) {
  if (any(is.null(year), !is.numeric(year))) {
    cli::cli_abort(paste0(
      "{.arg year} must be numeric, ",
      "not {.obj_type_friendly {year}}."
    ))
  }

  date <- as.character(paste0(year, "-12-31"))

  date
}

aemet_hlp_order_monthly <- function(x) {
  if (is.null(x)) {
    return(NULL)
  }

  x$fecha <- sub("-(\\d)$", "-0\\1", x$fecha)
  x[order(x$fecha), ]
}

aemet_hlp_check_year_range <- function(start, end, call = rlang::caller_env()) {
  if (is.null(start)) {
    cli::cli_abort(
      "{.arg start} cannot be {.obj_type_friendly {start}}.",
      call = call
    )
  }
  if (is.null(end)) {
    cli::cli_abort(
      "{.arg end} cannot be {.obj_type_friendly {end}}.",
      call = call
    )
  }
  if (!is.numeric(start)) {
    cli::cli_abort(
      "{.arg start} must be numeric, not {.obj_type_friendly {start}}.",
      call = call
    )
  }
  if (!is.numeric(end)) {
    cli::cli_abort(
      "{.arg end} must be numeric, not {.obj_type_friendly {end}}.",
      call = call
    )
  }

  invisible(TRUE)
}

aemet_hlp_validate_logical <- function(
  x,
  arg_name,
  call = rlang::caller_env()
) {
  if (!is.logical(x) || length(x) != 1) {
    cli::cli_abort(
      paste0(
        "{.arg {arg_name}} must be a single logical value, not ",
        "{.obj_type_friendly {x}}."
      ),
      call = call
    )
  }
  invisible(TRUE)
}

aemet_hlp_station_sf <- function(x, verbose) {
  sf_stations <- aemet_stations(verbose = verbose, return_sf = FALSE)
  sf_stations <- sf_stations[c("indicativo", "latitud", "longitud")]

  x <- dplyr::left_join(x, sf_stations, by = "indicativo")
  aemet_hlp_sf(x, "latitud", "longitud", verbose)
}

aemet_hlp_pad_integer <- function(x, width) {
  sprintf(paste0("%0", width, "d"), as.numeric(x))
}

aemet_hlp_api_key_name <- function(x) {
  if (x == 1) {
    return("AEMET_API_KEY")
  }

  paste0("AEMET_API_KEY", aemet_hlp_pad_integer(x - 1, 2))
}

aemet_hlp_finalize <- function(
  x,
  preserve = "",
  dec_mark = ",",
  group_mark = ""
) {
  x <- dplyr::bind_rows(x)
  x <- dplyr::as_tibble(x)
  x <- dplyr::distinct(x)

  aemet_hlp_guess(
    x,
    preserve = preserve,
    dec_mark = dec_mark,
    group_mark = group_mark
  )
}

aemet_hlp_finalize_forecast <- function(x, id_width, preserve) {
  x <- dplyr::bind_rows(x)
  x$id <- aemet_hlp_pad_integer(x$id, id_width)
  x <- dplyr::as_tibble(x)
  x <- dplyr::distinct(x)
  aemet_hlp_guess(x, preserve = preserve)
}

aemet_endpoint_forecast <- function(type, id) {
  paste0("/api/prediccion/especifica/", type, "/", id)
}

aemet_endpoint_monthly <- function(start, end, station) {
  paste0(
    "/api/valores/climatologicos/mensualesanuales/datos",
    "/anioini/",
    start,
    "/aniofin/",
    end,
    "/estacion/",
    station
  )
}

aemet_endpoint_normal <- function(station) {
  paste0("/api/valores/climatologicos/normales/estacion/", station)
}

aemet_endpoint_last_obs <- function(station) {
  if (station == "all") {
    return("/api/observacion/convencional/todas")
  }

  paste0("/api/observacion/convencional/datos/estacion/", station)
}

aemet_endpoint_daily <- function(start, end, station) {
  endpoint <- paste0(
    "/api/valores/climatologicos/diarios/datos/fechaini/",
    start,
    "/fechafin/",
    end
  )

  if (station == "all") {
    paste0(endpoint, "/todasestaciones")
  } else {
    paste0(endpoint, "/estacion/", station)
  }
}

aemet_endpoint_extremes <- function(parameter, station) {
  paste0(
    "/api/valores/climatologicos",
    "/valoresextremos/parametro/",
    parameter,
    "/estacion/",
    station
  )
}

aemet_hlp_match_all <- function(x) {
  if (any(x == "all")) {
    return("all")
  }

  x
}

aemet_hlp_req_timeout <- function(req) {
  httr2::req_timeout(req, getOption("climaemet_timeout", 60))
}

aemet_hlp_request <- function(url) {
  req <- httr2::request(url)
  aemet_hlp_req_timeout(req)
}

aemet_hlp_cache_paths <- function(name, ext = "rds", date_name = name) {
  list(
    data = file.path(climaemet_tempdir(), paste0(name, ".", ext)),
    date = file.path(climaemet_tempdir(), paste0(date_name, "_date.rds"))
  )
}

climaemet_tempdir <- function() {
  tempdir()
}

aemet_hlp_read_cache <- function(paths, label, verbose, read) {
  if (!file.exists(paths$data)) {
    return(NULL)
  }

  x <- read(paths$data)
  dat <- readRDS(paths$date) # nolint

  if (verbose) {
    cli::cli_alert_info(paste0(
      "Loading {.val {label}} from temporary cache file {.file {paths$data}}, ",
      "saved at {.time {format(dat, usetz = TRUE)}}."
    ))
  }

  x
}

aemet_hlp_write_cache <- function(x, paths, write) {
  write(x, paths$data)
  saveRDS(Sys.time(), paths$date)
  invisible(x)
}

aemet_hlp_try_forecast <- function(id, fetch) {
  df <- try(fetch(id), silent = TRUE)

  if (inherits(df, "try-error")) {
    cli::cli_alert_warning(
      "AEMET OpenData API request for {.val {id}} returned an error."
    )
    cli::cli_alert_info("Returning {.val NULL} for this request.")

    df <- NULL
  }

  df
}

aemet_hlp_fetch_loop <- function(x, fetch, progress, verbose) {
  progress <- isTRUE(progress) && !isTRUE(verbose) && cli::is_dynamic_tty()

  # nolint start
  # nocov start
  if (progress) {
    opts <- options()
    options(
      cli.progress_bar_style = "fillsquares",
      cli.progress_show_after = 3,
      cli.spinner = "clock"
    )

    cli::cli_progress_bar(
      format = paste0(
        "{cli::pb_spin} AEMET OpenData API ({cli::pb_current}/{cli::pb_total}) ",
        "| {cli::pb_bar} {cli::pb_percent}  ",
        "| ETA:{cli::pb_eta} [{cli::pb_elapsed}]"
      ),
      total = length(x),
      clear = FALSE
    )
    on.exit({
      cli::cli_progress_done()
      options(
        cli.progress_bar_style = opts$cli.progress_bar_style,
        cli.progress_show_after = opts$cli.progress_show_after,
        cli.spinner = opts$cli.spinner
      )
    })
  }

  # nocov end
  # nolint end

  final_result <- vector("list", length(x))
  for (i in seq_along(x)) {
    id <- x[[i]]

    if (progress) {
      cli::cli_progress_update() # nocov
    }

    final_result[[i]] <- fetch(id)
  }

  final_result
}
