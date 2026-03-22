#' Install an AEMET API Key
#'
#' @family aemet_auth
#'
#' @description
#' This function will store your AEMET API key on your local machine so it can
#' be called securely without being stored in your code.
#'
#' Alternatively, you can install the API key manually:
#'   - Run `Sys.setenv(AEMET_API_KEY = "Your_Key")`. You will need to run this
#'     command in each session (similar to `install = FALSE`).
#'   - Write this line in your .Renviron file: `AEMET_API_KEY = "Your_Key"`
#'     (same behavior as `install = TRUE`). This stores your API key
#'     permanently.
#'
#' @return Invisibly returns `NULL`.
#'
#' @param apikey The API key provided to you from the AEMET formatted in quotes.
#'   A key can be acquired at
#'   <https://opendata.aemet.es/centrodedescargas/inicio>. You can install
#'   several API keys as a character vector; see **Details**.
#' @param install If `TRUE`, installs the key on your local machine for
#'   use in future sessions. Defaults to `FALSE`.
#' @param overwrite If `TRUE`, overwrites an existing
#'   `AEMET_API_KEY` already set on your local machine.
#'
#' @details
#' You can pass several `apikey` values as a character vector `c(api1, api2)`;
#' in this case, multiple `AEMET_API_KEY` values are generated. In each
#' subsequent API call, \CRANpkg{climaemet} chooses the API key with the highest
#' remaining quota.
#'
#' This is useful when performing batch queries to avoid API throttling.
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

  apikey <- trimws(apikey)

  if (install) {
    cachedir <- rappdirs::user_cache_dir("climaemet", "R")
    # Create cache dir if not present
    if (!dir.exists(cachedir)) {
      dir.create(cachedir, recursive = TRUE)
    }

    api_file <- file.path(cachedir, "aemet_api_key")

    if (!file.exists(api_file) || overwrite) {
      # Create file if it doesn't exist
      writeLines(apikey, con = api_file)
    } else {
      cli::cli_abort(
        paste0(
          "An {.envvar AEMET_API_KEY} already exists. You can overwrite it ",
          " with {.arg overwrite = TRUE}."
        )
      )
    }
  } else {
    cli::cli_alert_info(
      paste0(
        "To install your API key for use in future sessions, run ",
        "{.fn climaemet::aemet_api_key} with {.arg install = TRUE}."
      )
    )
  }

  # Name and assign
  nms <- seq_along(apikey)
  nms2 <- vapply(
    nms,
    function(x) {
      if (x == 1) {
        return("AEMET_API_KEY")
      }
      sprintf("AEMET_API_KEY%02d", x - 1)
    },
    FUN.VALUE = character(1)
  )
  names(apikey) <- nms2

  do.call(Sys.setenv, as.list(apikey))

  invisible()
}

#' Check if an AEMET API Key is present for the current session
#'
#' @description
#' Detects whether an API key is available in the current session:
#'  - If an API key is already set as an environment variable, it is
#'    preserved.
#'  - If no environment variable is set and an API key has been stored
#'    permanently via [aemet_api_key()], it is loaded.
#'
#' @return
#' `TRUE` or `FALSE`. `aemet_show_api_key()` displays your stored API keys.
#'
#' @family aemet_auth
#'
#' @export
#'
#' @param ... Ignored.
#'
#' @rdname aemet_detect_api_key
#'
#' @examples
#'
#' aemet_detect_api_key()
#'
#' # CAUTION: This may reveal API Keys
#' if (FALSE) {
#'   aemet_show_api_key()
#' }
aemet_detect_api_key <- function(...) {
  allvar <- Sys.getenv()

  if (!any(grepl("^AEMET_API", names(allvar)))) {
    # Not set - tries to retrieve from cache
    cachedir <- rappdirs::user_cache_dir("climaemet", "R")
    api_file <- file.path(cachedir, "aemet_api_key")

    if (file.exists(api_file)) {
      cached_apikey <- readLines(api_file)

      # Case on empty cached apikey
      if (any(is.null(cached_apikey), is.na(cached_apikey))) {
        return(FALSE)
      }

      # Name and assign
      nms <- seq_along(cached_apikey)
      nms2 <- vapply(
        nms,
        function(x) {
          if (x == 1) {
            return("AEMET_API_KEY")
          }
          sprintf("AEMET_API_KEY%02d", x - 1)
        },
        FUN.VALUE = character(1)
      )
      names(cached_apikey) <- nms2

      do.call(Sys.setenv, as.list(cached_apikey))

      TRUE
    } else {
      FALSE
    }
  } else {
    TRUE
  }
}

#' @export
#' @rdname aemet_detect_api_key
aemet_show_api_key <- function(...) {
  # Expose internal function
  # nocov start
  aemet_hlp_get_allkeys(...)
  # nocov end
}

aemet_hlp_get_allkeys <- function(...) {
  allkeys <- Sys.getenv()[grepl("^AEMET_API", names(Sys.getenv()))]
  allkeys <- unname(as.character(allkeys))
  allkeys[nchar(allkeys) > 0]
}
