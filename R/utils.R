# Internal helpers functions: This functions are not exported

#' Guess formats
#'
#' @param tbl a [`tibble`][tibble::tibble()]
#' @param preserve vector of names to preserve
#' @return A [`tibble`][tibble::tibble()]
#' @noRd
aemet_hlp_guess <- function(tbl, preserve = "", dec_mark = ",",
                            group_mark = "") {
  for (i in names(tbl)) {
    if (class(tbl[[i]])[1] == "character" && !(i %in% preserve)) {
      tbl[i] <- readr::parse_guess(tbl[[i]],
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

#' Convert sf objects to tibble plus sf
#'
#' @param x a [`sf`][sf::st_sf] object
#' @return A \CRANpkg{sf} object
#' @noRd
aemet_hlp_sf_to_tbl <- function(x) {
  if (all(!inherits(x, "tbl"), inherits(x, "sf"))) {
    # If not, just add the same class
    # Template sf with tbl
    tmpl <- data.frame(x = 1)
    tmpl$geometry <- "POINT EMPTY"
    tmpl <- dplyr::as_tibble(tmpl)
    tmpl <- sf::st_as_sf(tmpl, wkt = "geometry", crs = sf::st_crs(4326))
    template <- class(tmpl)
    class(x) <- template
  }

  # Reorder columns - geom in geometry, it is sticky so even if
  # not select would be kept in the last position
  x <- x[, setdiff(names(x), "geometry")]

  result_out <- sf::st_make_valid(x)

  result_out
}


# Default station for metadata
default_station <- "9434"
