# Internal helpers functions: This functions are not exported

#' Guess formats
#'
#' @param tbl a [`tibble`][tibble::tibble()]
#' @param preserve vector of names to preserve
#' @return A [`tibble`][tibble::tibble()]
#' @noRd
aemet_hlp_guess <- function(
  tbl,
  preserve = "",
  dec_mark = ",",
  group_mark = ""
) {
  for (i in names(tbl)) {
    if (class(tbl[[i]])[1] == "character" && !(i %in% preserve)) {
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
  return(tbl)
}


#' Convert to sf objects (maps)
#'
#' @param tbl a [`tibble`][tibble::tibble()]
#' @param lat,lon latitude and longitude fiels
#' @param verbose TRUE/FALSE
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object
#' @noRd
aemet_hlp_sf <- function(tbl, lat, lon, verbose = FALSE) {
  # Check if sf is installed
  # nocov start
  if (!requireNamespace("sf", quietly = TRUE)) {
    message(
      "\n\npackage sf required for spatial conversion, ",
      "please install it first"
    )
    message("\nReturnig a tibble")
    return(tbl)
  }
  # nocov end
  if (lat %in% names(tbl) && lon %in% names(tbl)) {
    if (any(is.na(tbl[[lat]])) || any(is.na(tbl[[lon]]))) {
      message("Found NA coordinates. Returning a tibble")
      return(tbl)
    }

    if (verbose) {
      message("Converting to spatial object")
    }

    out <- sf::st_as_sf(tbl, coords = c(lon, lat), crs = sf::st_crs(4326))
    if (verbose) {
      message("spatial conversion succesful")
    }
    return(out)
  } else {
    message("lat/lon columns not found. Returning a tibble")
    return(tbl)
  }
}

# Default station for metadata
default_station <- "9434"
