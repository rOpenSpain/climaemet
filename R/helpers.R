##############################################################################
# Helper functions: This functions doesn't make any call
##############################################################################


#' Install a AEMET API Key in Your `.Renviron` File for Repeated Use
#'
#' @concept helpers
#'
#' @description
#' This function will add your AEMET API key to your `.Renviron` file so it can
#' be called securely without being stored in your code. After you have
#' installed your key, it can be called any time by typing
#' `Sys.getenv("AEMET_API_KEY")` and can be
#' used in package functions by simply typing AEMET_API_KEY If you do not have
#' an `.Renviron` file, the function will create on for you.
#' If you already have an `.Renviron` file, the function will append the key to
#' your existing file, while making a backup of your
#' original file for disaster recovery purposes.
#'
#' @param apikey The API key provided to you from the AEMET formatted in quotes.
#'   A key can be acquired at
#'   <https://opendata.aemet.es/centrodedescargas/inicio>.
#' @param install if TRUE, will install the key in your `.Renviron` file for
#'   use in future sessions.  Defaults to FALSE.
#' @param overwrite If this is set to TRUE, it will overwrite an existing
#'   AEMET_API_KEY that you already have in your `.Renviron` file.
#'
#' @note Code adapted from
#'   <https://walker-data.com/tidycensus/reference/census_api_key.html>
#'
#' @examples
#'
#' # Don't run these examples!
#'
#' if (FALSE) {
#'   aemet_api_key("111111abc", install = TRUE)
#'   # First time, reload your environment o restart your session.
#'   readRenviron("~/.Renviron")
#'   # You can check it with:
#'   Sys.getenv("AEMET_API_KEY")
#' }
#'
#' if (FALSE) {
#'   # If you need to overwrite an existing key:
#'   aemet_api_key("111111abc", overwrite = TRUE, install = TRUE)
#'   readRenviron("~/.Renviron")
#'   # You can check it with:
#'   Sys.getenv("AEMET_API_KEY")
#' }
#' @export

aemet_api_key <-
  function(apikey,
           overwrite = FALSE,
           install = FALSE) {
    stopifnot(
      is.character(apikey),
      is.logical(overwrite),
      is.logical(install)
    )

    if (install) {
      home <- Sys.getenv("HOME")
      renv <- file.path(home, ".Renviron")
      if (file.exists(renv)) {
        # Backup original .Renviron before doing anything else here.
        file.copy(renv, file.path(home, ".Renviron_backup"))
      }
      if (!file.exists(renv)) {
        file.create(renv)
      }
      else {
        if (isTRUE(overwrite)) {
          message(
            "Your original .Renviron will be backed up and stored in your R ",
            "HOME directory if needed."
          )
          oldenv <- read.table(renv, stringsAsFactors = FALSE)
          newenv <- oldenv[-grep("AEMET_API_KEY", oldenv), ]
          write.table(
            newenv,
            renv,
            quote = FALSE,
            sep = "\n",
            col.names = FALSE,
            row.names = FALSE
          )
        }
        else {
          tv <- readLines(renv)
          if (any(grepl("AEMET_API_KEY", tv))) {
            stop(
              "A AEMET_API_KEY already exists. You can overwrite it with the ",
              "argument overwrite=TRUE",
              call. = FALSE
            )
          }
        }
      }

      keyconcat <- paste0("AEMET_API_KEY='", apikey, "'")
      # Append API key to .Renviron file
      write(keyconcat, renv, sep = "\n", append = TRUE)
      message(
        "Your API key has been stored in your .Renviron and can be accessed ",
        "by Sys.getenv('AEMET_API_KEY'). \nTo use now, restart R or run ",
        "`readRenviron('~/.Renviron')`"
      )
      return(apikey)
    } else {
      message(
        "To install your API key for use in future sessions, run this ",
        "function with `install = TRUE`."
      )
      Sys.setenv(AEMET_API_KEY = apikey)
    }
  }


#' Check if an AEMET API Key is present as environment variable
#'
#' The function returns TRUE/FALSE
#'
#' @concept helpers
#'
#' @export
#'
#' @param ... Ignored
#'
aemet_detect_api_key <- function(...) {
  getvar <- Sys.getenv("AEMET_API_KEY")

  if (is.null(getvar) || is.na(getvar) || getvar == "") {
    return(FALSE)
  } else {
    return(TRUE)
  }
}

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
