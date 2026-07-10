# AEMET standard climatology endpoints.

#' Climatological normal values
#'
#' Retrieves climatological normal values for a station or for all stations
#' with `aemet_normal_clim_all()`. The standard normal period is 1981–2010.
#'
#' @rdname aemet_normal
#' @name aemet_normal_clim
#' @inheritParams aemet_last_obs
#'
#' @inheritSection aemet_api_key API key
#'
#' @inherit aemet_last_obs return
#'
#' @note
#' Code modified from project <https://github.com/SevillaR/aemet>.
#'
#' @seealso [aemet_stations()] for station identifiers.
#'
#' @family climatology
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' obs <- aemet_normal_clim(c("9434", "3195"))
#' dplyr::glimpse(obs)
aemet_normal_clim <- function(
  station = NULL,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs ----
  if (is.null(station)) {
    cli::cli_abort("{.arg station} cannot be {.obj_type_friendly {station}}.")
  }

  aemet_hlp_validate_logical(return_sf, "return_sf")
  aemet_hlp_validate_logical(verbose, "verbose")

  station <- as.character(station)

  if (isTRUE(extract_metadata)) {
    station <- default_station
  }

  # 2. Call the API ----

  ## Metadata ----
  if (extract_metadata) {
    apidest <- aemet_endpoint_normal(station)
    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
    return(final_result)
  }

  ## Data request ----

  final_result <- aemet_hlp_fetch_loop(
    station,
    function(id) {
      get_data_aemet(apidest = aemet_endpoint_normal(id), verbose = verbose)
    },
    progress = progress,
    verbose = verbose
  )

  final_result <- aemet_hlp_finalize(final_result, "indicativo", dec_mark = ".")

  # Prepare spatial output ----
  if (return_sf) {
    final_result <- aemet_hlp_station_sf(final_result, verbose)
  }

  final_result
}

#' @rdname aemet_normal
#' @name aemet_normal
#'
#' @export
#' @encoding UTF-8
aemet_normal_clim_all <- function(
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # Arguments are validated in `aemet_normal_clim()`.

  if (isTRUE(extract_metadata)) {
    stations <- data.frame(indicativo = default_station)
  } else {
    stations <- aemet_stations(verbose = verbose)
  }

  # Do not cover this because it is a large extraction.

  data_all <- aemet_normal_clim(
    stations$indicativo,
    verbose = verbose,
    return_sf = return_sf,
    extract_metadata = extract_metadata,
    progress = progress
  )

  data_all
}
