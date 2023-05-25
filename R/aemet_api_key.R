#' Install an AEMET API Key
#'
#' @family aemet_auth
#'
#' @description
#' This function will store your AEMET API key on your local machine so it can
#' be called securely without being stored in your code. After you have
#' installed your key, it can be called any time by typing
#' `Sys.getenv("AEMET_API_KEY")` and can be
#' used in package functions by simply typing `AEMET_API_KEY`.
#'
#' Alternatively, you can install the API Key manually:
#'   * Run `Sys.setenv(AEMET_API_KEY = "Your_Key")`. You would need to run this
#'   command on each session (Similar to `install = FALSE`).
#'   * Write this line on your .Renviron file: `AEMET_API_KEY = "Your_Key"` (
#'    same behavior than `install = TRUE`). This would store your API key
#'    permanently.
#'
#' @return None
#'
#' @param apikey The API key provided to you from the AEMET formatted in quotes.
#'   A key can be acquired at
#'   <https://opendata.aemet.es/centrodedescargas/inicio>.
#' @param install if `TRUE`, will install the key in your local machine for
#'   use in future sessions.  Defaults to `FALSE.`
#' @param overwrite If this is set to `TRUE`, it will overwrite an existing
#'   AEMET_API_KEY that you already have in local machine.
#'
#' @note
#' To locate your API Key on your local machine, run
#' `rappdirs::user_cache_dir("climaemet", "R")`.
#'
#' @examples
#' # Don't run these examples!
#'
#' if (FALSE) {
#'   aemet_api_key("111111abc", install = TRUE)
#'
#'   # You can check it with:
#'   Sys.getenv("AEMET_API_KEY")
#' }
#'
#' if (FALSE) {
#'   # If you need to overwrite an existing key:
#'   aemet_api_key("222222abc", overwrite = TRUE, install = TRUE)
#'
#'   # You can check it with:
#'   Sys.getenv("AEMET_API_KEY")
#' }
#' @export

aemet_api_key <- function(apikey, overwrite = FALSE, install = FALSE) {
  # Validate
  stopifnot(is.character(apikey), is.logical(overwrite), is.logical(install))

  if (install) {
    cachedir <- rappdirs::user_cache_dir("climaemet", "R")
    # Create cache dir if not presente
    if (!dir.exists(cachedir)) {
      dir.create(cachedir, recursive = TRUE)
    }

    api_file <- file.path(cachedir, "aemet_api_key")

    if (!file.exists(api_file) || overwrite == TRUE) {
      # Create file if it doesn't exist
      writeLines(apikey, con = api_file)
    } else {
      stop(
        "An AEMET_API_KEY already exists. You can overwrite it with the ",
        "argument overwrite=TRUE",
        call. = FALSE
      )
    }
  } else {
    message(
      "To install your API key for use in future sessions, run this ",
      "function with `install = TRUE`."
    )
  }

  Sys.setenv(AEMET_API_KEY = apikey)
  return(invisible())
}

#' Check if an AEMET API Key is present for the current session
#'
#' @description
#' The function would detect if an API Key is available on this session:
#'  * If an API Key is already set as an environment variable it would be
#'  preserved
#'  * If no environment variable has been set and you have stored permanently
#'  an API Key using [aemet_api_key()], the latter would be loaded.
#'
#' @return `TRUE` or `FALSE`
#'
#' @family aemet_auth
#'
#' @export
#'
#' @param ... Ignored
#'
#'
#' @examples
#'
#' aemet_detect_api_key()
aemet_detect_api_key <- function(...) {
  getvar <- Sys.getenv("AEMET_API_KEY")

  if (is.null(getvar) || is.na(getvar) || getvar == "") {
    # Not set - tries to retrieve from cache
    cachedir <- rappdirs::user_cache_dir("climaemet", "R")
    api_file <- file.path(cachedir, "aemet_api_key")

    if (file.exists(api_file)) {
      cached_apikey <- readLines(api_file)

      # Case on empty cached apikey
      if (is.null(cached_apikey) ||
        is.na(cached_apikey) || cached_apikey == "") {
        return(FALSE)
      }


      Sys.setenv(AEMET_API_KEY = cached_apikey)
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else {
    return(TRUE)
  }
}
