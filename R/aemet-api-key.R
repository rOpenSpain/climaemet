#' Install an AEMET API Key
#'
#' @family aemet_auth
#'
#' @description
#' This function will store your AEMET API key on your local machine so it can
#' be called securely without being stored in your code.
#'
#' Alternatively, you can install the API Key manually:
#'   - Run `Sys.setenv(AEMET_API_KEY = "Your_Key")`. You would need to run this
#'     command on each session (Similar to `install = FALSE`).
#'   - Write this line on your .Renviron file: `AEMET_API_KEY = "Your_Key"`
#'     (same behavior than `install = TRUE`). This would store your API key
#'     permanently.
#'
#' @return None
#'
#' @param apikey The API key provided to you from the AEMET formatted in quotes.
#'   A key can be acquired at
#'   <https://opendata.aemet.es/centrodedescargas/inicio>. You can install
#'   several API Keys as a vector of characters, see **Details**.
#' @param install if `TRUE`, will install the key in your local machine for
#'   use in future sessions.  Defaults to `FALSE.`
#' @param overwrite If this is set to `TRUE`, it will overwrite an existing
#'   `AEMET_API_KEY` that you already have in local machine.
#'
#' @details
#' You can pass several `apikey` values as a vector `c(api1, api2)`, in this
#' case several `AEMET_API_KEY` values would be generated. In each subsequent
#' api call \CRANpkg{climaemet} would choose the API Key with the highest
#' remaining quota.
#'
#' This is useful when performing batch queries to avoid API throttling.
#'
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
    # Create cache dir if not presente
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
#' The function would detect if an API Key is available on this session:
#'  - If an API Key is already set as an environment variable it would be
#'  preserved
#'  - If no environment variable has been set and you have stored permanently
#'  an API Key using [aemet_api_key()], the latter would be loaded.
#'
#' @return
#' `TRUE` or `FALSE`. `aemet_show_api_key()` would display your stored API keys.
#'
#' @family aemet_auth
#'
#' @export
#'
#' @param ... Ignored
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
