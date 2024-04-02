# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' Daily/annual climatology values
#'
#' @description
#' Get climatology values for a station or for all the available stations.
#' Note that `aemet_daily_period()` and `aemet_daily_period_all()` are shortcuts
#' of `aemet_daily_clim()`.
#'
#' @rdname aemet_daily
#' @name aemet_daily_clim
#'
#' @family aemet_api_data
#'
#' @param start,end  Character string with start and end date. See Details.
#'
#' @inheritParams aemet_last_obs
#'
#' @details
#' `start` and `end` parameters should be:
#' * For `aemet_daily_clim()`: A `Date` object or a string with format:
#'   YYYY-MM-DD (2020-12-31) coercible with [as.Date()].
#' * For `aemet_daily_period()` and `aemet_daily_period_all()`: A string
#'   representing the year(s) to be extracted: "2020", "2018".
#'
#' # API Key
#' You need to set your API Key globally using [aemet_api_key()].
#'
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object
#'
#' @examplesIf aemet_detect_api_key()
#'
#' library(tibble)
#' obs <- aemet_daily_clim(c("9434", "3195"))
#' glimpse(obs)
#'
#' # Metadata
#' meta <- aemet_daily_clim(c("9434", "3195"), extract_metadata = TRUE)
#'
#' glimpse(meta$campos)
#'
#' @seealso [aemet_api_key()], [as.Date()]
#' @export
aemet_daily_clim <- function(station = "all", start = Sys.Date() - 7,
                             end = Sys.Date(), verbose = FALSE,
                             return_sf = FALSE, extract_metadata = FALSE) {
  # Validate inputs----
  if (is.null(station)) {
    stop("Station can't be missing")
  }
  station <- as.character(station)

  # For metadata
  if (isTRUE(extract_metadata)) {
    if (tolower(station[1]) == "all") station <- default_station
    station <- station[1]
    start <- Sys.Date() - 7
    end <- Sys.Date()
  }

  start_conv <- as.Date(start)
  end_conv <- as.Date(end)

  if (is.na(start_conv) || is.na(end_conv)) {
    stop("Error parsing start/end dates.Use YYYY-MM-DD format")
  }
  stopifnot(is.logical(return_sf))
  stopifnot(is.logical(verbose))

  # Call API----

  ## All ----
  if ("all" %in% tolower(station)) {
    # Same day
    if (start_conv == end_conv) {
      seq_all <- sort(c(start_conv, end_conv))
    } else {
      # Max request: 31 days
      seq_all <- seq(start_conv, end_conv, by = "31 days")
      seq_all <- pmin(end_conv, c(start_conv, end_conv, seq_all))
      seq_all <- sort(unique(seq_all))
    }


    final_result <- NULL

    for (i in seq_len(length(seq_all) - 1)) {
      apidest <-
        paste0(
          "/api/valores/climatologicos/diarios/datos/fechaini/",
          seq_all[i],
          "T00:00:00UTC/fechafin/",
          seq_all[i + 1],
          "T23:59:59UTC/todasestaciones"
        )
      final_result <- dplyr::bind_rows(
        final_result,
        get_data_aemet(apidest = apidest, verbose = verbose)
      )
    }
  } else {
    ## Single request----
    # Max: 5 years
    # Same day
    if (start_conv == end_conv) {
      seq_all <- sort(c(start_conv, end_conv))
    } else {
      seq_all <- seq(start_conv, end_conv, by = "4 years")
      seq_all <- pmin(end_conv, c(start_conv, end_conv, seq_all))
      seq_all <- sort(unique(seq_all))
    }
    final_result <- NULL
    # Vectorise
    for (s in station) {
      for (i in seq_len(length(seq_all) - 1)) {
        apidest <-
          paste0(
            "/api/valores/climatologicos/diarios/datos/fechaini/",
            seq_all[i],
            "T00:00:00UTC/fechafin/",
            seq_all[i + 1],
            "T23:59:59UTC/estacion/",
            s
          )

        if (isTRUE(extract_metadata)) {
          final_result <- get_metadata_aemet(
            apidest = apidest,
            verbose = verbose
          )
        } else {
          final_result <-
            dplyr::bind_rows(
              final_result,
              get_data_aemet(
                apidest = apidest,
                verbose = verbose
              )
            )
        }
      }
    }
  }
  final_result <- dplyr::distinct(final_result)
  if (isTRUE(extract_metadata)) {
    return(final_result)
  }

  # Guess formats
  final_result <- aemet_hlp_guess(final_result, "indicativo")

  # Check spatial----
  if (return_sf) {
    # Coordinates from statios
    sf_stations <-
      aemet_stations(verbose = verbose, return_sf = FALSE)
    sf_stations <-
      sf_stations[c("indicativo", "latitud", "longitud")]

    final_result <- dplyr::left_join(final_result,
      sf_stations,
      by = "indicativo"
    )
    final_result <-
      aemet_hlp_sf(final_result, "latitud", "longitud", verbose)
  }

  return(final_result)
}


#' @rdname aemet_daily
#' @name aemet_daily
#' @export
aemet_daily_period <- function(station,
                               start = as.integer(format(Sys.Date(), "%Y")),
                               end = start,
                               verbose = FALSE, return_sf = FALSE,
                               extract_metadata = FALSE) {
  # Validate inputs----
  if (is.null(start)) {
    stop("Start year can't be missing")
  }
  if (is.null(end)) {
    stop("End year can't be missing")
  }
  if (!is.numeric(start)) {
    stop("Start year need to be numeric")
  }
  if (!is.numeric(end)) {
    stop("End year need to be numeric")
  }

  # Other inputs are validated in aemet_daily_clim
  fdoy <- paste0(start, "-01-01")
  ldoy <- paste0(end, "-12-31")

  # Call API----
  # Via daily clim
  final_result <-
    aemet_daily_clim(station, fdoy, ldoy, verbose, return_sf,
      extract_metadata = extract_metadata
    )

  return(final_result)
}


#' @rdname aemet_daily
#' @name aemet_daily
#' @export
aemet_daily_period_all <- function(start = as.integer(format(Sys.Date(), "%Y")),
                                   end = start, verbose = FALSE,
                                   return_sf = FALSE,
                                   extract_metadata = FALSE) {
  # Validate inputs----
  if (is.null(start)) {
    stop("Start year can't be missing")
  }

  if (is.null(end)) {
    stop("End year can't be missing")
  }

  if (!is.numeric(start)) {
    stop("Start year need to be numeric")
  }

  if (!is.numeric(end)) {
    stop("End year need to be numeric")
  }
  # Rest of parameters validated in aemet_daily_clim

  fdoy <- paste0(start, "-01-01")
  ldoy <- paste0(end, "-12-31")
  # Call API----
  # via aemet_daily_clim
  data_all <- aemet_daily_clim("all", fdoy, ldoy, verbose, return_sf,
    extract_metadata = extract_metadata
  )

  return(data_all)
}
