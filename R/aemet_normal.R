# valores-climatologicos
# https://opendata.aemet.es/dist/index.html#/

#' Normal climatology values
#'
#' @rdname aemet_normal
#'
#' @description
#' Get normal climatology values for a station (or all the stations with
#' `aemet_normal_clim_all()`. Standard climatology from 1981 to 2010.
#'
#' @note Code modified from project https://github.com/SevillaR/aemet
#'
#' @inheritParams aemet_last_obs
#'
#' @return a tibble
#'
#' @examples
#'
#' # Run this example only if AEMET_API_KEY is set
#' apikey <- Sys.getenv("AEMET_API_KEY")
#' if (apikey != "") {
#'   library(tibble)
#'   obs <- aemet_normal_clim(c("9434", "3195"))
#'   glimpse(obs)
#' }
#' @export

aemet_normal_clim <- function(station = NULL,
                              apikey = NULL,
                              verbose = FALSE,
                              return_sf = FALSE) {
  # Validate inputs----
  if (is.null(station)) {
    stop("Station can't be missing")
  }

  stopifnot(is.logical(return_sf))
  stopifnot(is.logical(verbose))

  station <- as.character(station)
  # Call API----

  # Single request----
  # Vectorize function
  final_result <- NULL

  for (i in seq_len(length(station))) {
    apidest <-
      paste0(
        "/api/valores/climatologicos/normales/estacion/",
        station[i]
      )

    final_result <-
      dplyr::bind_rows(
        final_result,
        get_data_aemet(apidest, apikey, verbose)
      )
  }
  final_result <- dplyr::distinct(final_result)

  # Reorder columns----
  if ("apidest_error" %in% names(final_result)) {
    final_result <-
      dplyr::bind_cols(
        final_result[!names(final_result) %in% c("apidest_error", "error_message")],
        final_result[c("apidest_error", "error_message")]
      )
  }

  # Guess formats----
  if (verbose) {
    message("\nGuessing fields...")
  }
  final_result <-
    aemet_hlp_guess(final_result, "indicativo", dec_mark = ".")

  # Check spatial----
  # Check spatial----
  if (return_sf) {
    # Coordinates from statios
    sf_stations <-
      aemet_stations(apikey, verbose, return_sf = FALSE)
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

#' @rdname aemet_normal
#'
#' @description Get normal climatology values for all stations.
#'
#' @export
aemet_normal_clim_all <-
  function(apikey = NULL,
           verbose = FALSE,
           return_sf = FALSE) {
    # Parameters are validated on aemet_normal_clim

    stations <- aemet_stations(apikey = apikey, verbose = verbose)

    data_all <-
      aemet_normal_clim(
        stations$indicativo,
        apikey = apikey,
        verbose = verbose,
        return_sf = return_sf
      )

    return(data_all)
  }
