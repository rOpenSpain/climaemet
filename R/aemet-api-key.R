#' Install an AEMET API key
#'
#' @description
#' This function stores your AEMET API key on your local machine so it can be
#' called securely without being stored in your code.
#'
#' Alternatively, you can install the API key manually:
#' - Run `Sys.setenv(AEMET_API_KEY = "Your_Key")`. You will need to run this
#'   command in each session (similar to `install = FALSE`).
#' - Write this line in your `.Renviron` file: `AEMET_API_KEY = "Your_Key"`
#'   (same behavior as `install = TRUE`). This stores your API key
#'   permanently.
#'
#' @family aemet_auth
#'
#' @param apikey The AEMET API key formatted in quotes.
#'   A key can be acquired at
#'   <https://opendata.aemet.es/centrodedescargas/inicio>. You can install
#'   several API keys as a character vector. See **Details**.
#' @param install If `TRUE`, installs the key on your local machine for
#'   use in future sessions. Defaults to `FALSE`.
#' @param overwrite If `TRUE`, overwrites an existing
#'   `AEMET_API_KEY` already set on your local machine.
#'
#' @details
#' You can pass several `apikey` values as a character vector `c(api1, api2)`.
#' In this case, multiple `AEMET_API_KEY` values are generated. In each
#' subsequent API call, \CRANpkg{climaemet} chooses the API key with the highest
#' remaining quota.
#'
#' This is useful when performing batch queries to avoid API throttling.
#'
#' @return Invisibly returns `NULL`.
#'
#' @note
#' To locate your API key on your local machine, run
#' `tools::R_user_dir("climaemet", "config")`.
#'
#' @examples
#' # Do not run these examples.
#'
#' if (FALSE) {
#'   aemet_api_key("111111abc", install = TRUE)
#'
#'   # Check it with:
#'   Sys.getenv("AEMET_API_KEY")
#' }
#'
#' if (FALSE) {
#'   # Overwrite an existing key:
#'   aemet_api_key("222222abc", overwrite = TRUE, install = TRUE)
#'
#'   # Check it with:
#'   Sys.getenv("AEMET_API_KEY")
#' }
#' @export
#' @encoding UTF-8

aemet_api_key <- function(apikey, overwrite = FALSE, install = FALSE) {
  # Validate inputs.
  if (!is.character(apikey)) {
    cli::cli_abort(paste0(
      "{.arg apikey} must be a character string, ",
      "not {.obj_type_friendly {apikey}}."
    ))
  }
  aemet_hlp_validate_logical(overwrite, "overwrite")
  aemet_hlp_validate_logical(install, "install")

  apikey <- trimws(apikey)

  if (install) {
    api_file <- get_path_apikey_db()

    if (!file.exists(api_file) || overwrite) {
      # Create the file if needed.
      writeLines(apikey, con = api_file)
    } else {
      cli::cli_abort(paste0(
        "An {.envvar AEMET_API_KEY} already exists. You can overwrite it ",
        "with {.arg overwrite = TRUE}."
      ))
    }
  } else {
    cli::cli_alert_info(paste0(
      "To install your API key for use in future sessions, run ",
      "{.fn climaemet::aemet_api_key} with {.arg install = TRUE}."
    ))
  }

  # Name and assign environment variables.
  nms <- seq_along(apikey)
  nms2 <- vapply(
    nms,
    aemet_hlp_api_key_name,
    FUN.VALUE = character(1)
  )
  names(apikey) <- nms2

  do.call(Sys.setenv, as.list(apikey))

  invisible()
}

#' Check whether an AEMET API key is present for the current session
#'
#' @description
#' Detects whether an API key is available in the current session:
#' - If an API key is already set as an environment variable, it is preserved.
#' - If no environment variable is set and an API key has been stored
#'   permanently via [aemet_api_key()], it is loaded.
#'
#' @rdname aemet_detect_api_key
#'
#' @family aemet_auth
#'
#' @param ... Ignored.
#'
#' @return
#' `TRUE` or `FALSE`. `aemet_show_api_key()` displays your stored API keys.
#'
#' @examples
#'
#' aemet_detect_api_key()
#'
#' # CAUTION: This may reveal API keys.
#' if (FALSE) {
#'   aemet_show_api_key()
#' }
#' @export
#' @encoding UTF-8
#'
aemet_detect_api_key <- function(...) {
  migrate_cache()
  allvar <- Sys.getenv()

  if (!any(grepl("^AEMET_API", names(allvar)))) {
    # If not set, try to retrieve it from the cache.
    api_file <- get_path_apikey_db()

    if (file.exists(api_file)) {
      cached_apikey <- readLines(api_file)

      # Handle an empty cached API key.
      if (any(is.null(cached_apikey), is.na(cached_apikey))) {
        return(FALSE) # nocov
      }

      # Name and assign environment variables.
      nms <- seq_along(cached_apikey)
      nms2 <- vapply(
        nms,
        aemet_hlp_api_key_name,
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

#' @rdname aemet_detect_api_key
#' @export
#' @encoding UTF-8
aemet_show_api_key <- function(...) {
  # Expose the internal function.

  aemet_hlp_get_allkeys(...)
}

aemet_hlp_get_allkeys <- function(...) {
  allkeys <- Sys.getenv()[grepl("^AEMET_API", names(Sys.getenv()))]
  allkeys <- unname(as.character(allkeys))
  allkeys[nchar(allkeys) > 0]
}

#' Migrate cache config from rappdirs to tools
#'
#' One-time function.
#' @param old A path to the old cache config folder.
#' @param new A path to the new cache config folder.
#'
#' @noRd
migrate_cache <- function(
  old = rappdirs::user_cache_dir("climaemet", "R"),
  new = tools::R_user_dir("climaemet", "config"),
  fname = "aemet_api_key"
) {
  old_fname <- file.path(old, fname)
  new_fname <- file.path(new, fname)
  old_fname_bk <- file.path(old, paste0("bk_", fname))

  # Leave a warning file.
  if (file.exists(old_fname)) {
    if (!file.exists(file.path(old, "README.md"))) {
      writeLines(
        c(
          "# climaemet uses now `tools::R_user_dir('climaemet', 'config')`.",
          "",
          "Cached keys are now stored in this folder:",
          new
        ),
        file.path(old, "README.md")
      )
    }

    file.copy(old_fname, old_fname_bk)
  }

  if (file.exists(new_fname)) {
    unlink(old_fname)
    return(invisible())
  }

  if (file.exists(old_fname)) {
    apikeys <- readLines(old_fname)

    aemet_api_key(apikeys, install = TRUE)
    unlink(old_fname)
  }

  invisible()
}

# For mocking safely
get_path_apikey_db <- function(
  cachedir = tools::R_user_dir("climaemet", "config"),
  fname = "aemet_api_key"
) {
  # Create the cache directory if needed.
  if (!dir.exists(cachedir)) {
    dir.create(cachedir, recursive = TRUE)
  }

  api_file <- file.path(cachedir, fname)
  api_file
}
