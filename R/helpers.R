##############################################################################
# Helper functions: This functions doesn't make any call
##############################################################################

#' Converts dms to decimal degrees
#'
#' Converts degrees, minutes and seconds to decimal degrees.
#'
#' @concept helpers
#'
#' @note Code modified from project <https://github.com/SevillaR/aemet>
#'
#' @param input Character string as DMS coordinates.
#'
#' @return a numeric value.
#'
#' @examples
#' dms2decdegrees("055245W")
#' @export

dms2decdegrees <- function(input = NULL) {
  if (is.null(input)) {
    stop("Input can't be missing")
  }

  if (!is.character(input)) {
    stop("Input need to be character string")
  }

  deg <- as.numeric(substr(input, 0, 2))
  min <- as.numeric(substr(input, 3, 4))
  sec <- as.numeric(substr(input, 5, 6))
  x <- deg + min / 60 + sec / 3600
  x <- ifelse(substr(input, 7, 8) == "W", -x, x)
  x <- ifelse(substr(input, 7, 8) == "S", -x, x)

  return(x)
}

#' First and last day of year
#'
#' Get first and last day of year.
#'
#' @rdname day_of_year
#'
#' @concept helpers
#'
#' @param year Numeric value as year (format: %Y).
#'
#' @return Character string as date (format: %Y%m%d).
#'
#' @examples
#' first_day_of_year(2000)
#' last_day_of_year(2020)
#' @export


first_day_of_year <- function(year = NULL) {
  if (is.null(year)) {
    stop("Year can't be missing")
  }

  if (!is.numeric(year)) {
    stop("Year need to be numeric")
  }

  date <- as.character(paste0(year, "-01-01"))

  return(date)
}

#' @rdname day_of_year
#' @export
last_day_of_year <- function(year = NULL) {
  if (is.null(year)) {
    stop("Year can't be missing")
  }

  if (!is.numeric(year)) {
    stop("Year need to be numeric")
  }

  date <- as.character(paste0(year, "-12-31"))

  return(date)
}
