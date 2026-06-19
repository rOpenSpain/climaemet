# AEMET climatology extremes endpoints.

#' Extreme values for a station
#'
#' Retrieves recorded extreme values for one or more stations.
#'
#' @param parameter A character string specifying the parameter to retrieve:
#'   temperature (`"T"`), precipitation (`"P"`) or wind (`"V"`).
#'
#' @inheritParams aemet_monthly station
#' @inheritParams aemet_last_obs
#'
#' @inheritSection aemet_daily_clim API key
#'
#' @returns
#' A [tibble][dplyr::tibble] or a \CRANpkg{sf} object. If the function
#' encounters a parsing error, it returns a list.
#'
#' @family climatology
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' obs <- aemet_extremes_clim(c("9434", "3195"))
#' dplyr::glimpse(obs)
aemet_extremes_clim <- function(
  station = NULL,
  parameter = "T",
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate parameters ----
  if (is.null(station)) {
    cli::cli_abort("{.arg station} cannot be {.obj_type_friendly {station}}.")
  }

  station <- as.character(station)

  if (isTRUE(extract_metadata)) {
    station <- default_station
  }

  if (is.null(parameter)) {
    cli::cli_abort(
      "{.arg parameter} cannot be {.obj_type_friendly {parameter}}."
    )
  }

  if (!is.character(parameter)) {
    cli::cli_abort(paste0(
      "{.arg parameter} must be a character, ",
      "not {.obj_type_friendly {parameter}}."
    ))
  }

  if (!parameter %in% c("T", "P", "V")) {
    cli::cli_abort(
      "{.arg parameter} must be one of {.or {.str {c('T', 'P', 'V')}}}."
    )
  }

  # 2. Call the API ----

  ## Metadata ----

  if (extract_metadata) {
    apidest <- aemet_endpoint_extremes(parameter, default_station)

    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
    return(final_result)
  }

  ## Data request ----

  final_result <- aemet_hlp_fetch_loop(
    station,
    function(id) {
      get_data_aemet(
        apidest = aemet_endpoint_extremes(parameter, id),
        verbose = verbose
      )
    },
    progress = progress,
    verbose = verbose
  )

  bindtry <- try(dplyr::bind_rows(final_result), silent = TRUE)
  if (inherits(bindtry, "try-error")) {
    cli::cli_alert_warning(c(
      "Cannot convert to {.cls tibble}. Returning ",
      "{.obj_type_friendly {final_result}}."
    ))
    return(final_result)
  }
  final_result <- bindtry
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(final_result, "indicativo", dec_mark = ".")

  # Prepare spatial output ----
  if (return_sf) {
    final_result <- aemet_hlp_station_sf(final_result, verbose)
  }

  final_result
}
