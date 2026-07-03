# Internal helper functions that are not exported.

#' Guess column formats
#'
#' @param tbl A [tibble][dplyr::tibble].
#' @param preserve A character vector of names to preserve.
#' @returns A [tibble][dplyr::tibble].
#' @noRd
aemet_hlp_guess <- function(
  tbl,
  preserve = "",
  dec_mark = ",",
  group_mark = ""
) {
  for (i in names(tbl)) {
    if (typeof(tbl[[i]]) == "character" && !(i %in% preserve)) {
      tbl[i] <- readr::parse_guess(
        tbl[[i]],
        locale = readr::locale(
          decimal_mark = dec_mark,
          grouping_mark = group_mark
        ),
        na = "-"
      )
    }
  }
  tbl
}

#' Convert data to an `sf` object
#'
#' @param tbl A [tibble][dplyr::tibble].
#' @param lat,lon Latitude and longitude column names.
#' @param verbose A logical value. If `TRUE`, displays messages.
#' @returns A [tibble][dplyr::tibble] or a \CRANpkg{sf} object.
#' @noRd
aemet_hlp_sf <- function(tbl, lat, lon, verbose = FALSE) {
  # Check whether sf is installed.
  # nocov start
  if (!requireNamespace("sf", quietly = TRUE)) {
    cli::cli_alert_warning(c(
      "{.pkg sf} is required for spatial conversion.",
      "Run {.run install.packages(\"sf\")}."
    ))
    cli::cli_alert_info("Returning a {.cls tibble}.")
    return(tbl)
  }
  # nocov end
  if (lat %in% names(tbl) && lon %in% names(tbl)) {
    if (anyNA(tbl[[lat]]) || anyNA(tbl[[lon]])) {
      cli::cli_alert_warning(
        "Found {.val NA} coordinates. Returning a {.cls tibble}."
      )
      return(tbl)
    }

    if (verbose) {
      cli::cli_alert_info("Converting to spatial object with {.pkg sf}.")
    }

    out <- sf::st_as_sf(tbl, coords = c(lon, lat), crs = sf::st_crs(4326))
    if (verbose) {
      cli::cli_alert_success("Spatial conversion successful.")
    }
    out
  } else {
    cli::cli_alert_info(paste0(
      "Columns {.field {lat}} and {.field {lon}} not found. ",
      "Returning a {.cls tibble}."
    ))
    tbl
  }
}

# Default station for metadata.
default_station <- "9434"
