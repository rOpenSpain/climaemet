#' Install an AEMET API key
#'
#' @description
#' Stores an AEMET API key on your local machine so it can be used without
#' including it in your code.
#'
#' Alternatively, set the key for the current session with
#' `Sys.setenv(AEMET_API_KEY = "Your_Key")`, equivalent to `install = FALSE`.
#' To store it permanently, add `AEMET_API_KEY = "Your_Key"` to `.Renviron`,
#' equivalent to `install = TRUE`.
#'
#' @param apikey Character vector of AEMET API keys. A key can be acquired at
#'   <https://opendata.aemet.es/centrodedescargas/inicio>. You can install
#'   multiple API keys at once. See **Details**.
#' @param install Logical. If `TRUE`, installs the key on your local machine for
#'   use in future sessions. Defaults to `FALSE`.
#' @param overwrite Logical. If `TRUE`, overwrites an existing
#'   `AEMET_API_KEY` environment variable.
#'
#' @details
#' You can pass multiple `apikey` values as a character vector
#' `c(api1, api2)`. In this case, multiple `AEMET_API_KEY` values are stored.
#' In each subsequent API call, \CRANpkg{climaemet} chooses the API key with
#' the highest remaining quota.
#'
#' This is useful when performing batch queries to avoid API throttling.
#'
#' @returns `NULL`, invisibly.
#'
#' @note
#' To locate the stored API key, run
#' `tools::R_user_dir("climaemet", "config")`.
#'
#' @family aemet_auth
#'
#' @export
#' @encoding UTF-8
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
        "The {.envvar AEMET_API_KEY} environment variable already exists. ",
        "Set {.code overwrite = TRUE} to replace it."
      ))
    }
  } else {
    cli::cli_alert_info(paste0(
      "To install your API key for use in future sessions, run ",
      "{.fn climaemet::aemet_api_key} with {.code install = TRUE}."
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

#' Check for an AEMET API key
#'
#' @description
#' Detects whether an API key is available in the current session. An existing
#' environment variable is preserved. Otherwise, a key stored permanently with
#' [aemet_api_key()] is loaded.
#'
#' @rdname aemet_detect_api_key
#'
#' @param ... Ignored.
#'
#' @returns `TRUE` if an API key is available and `FALSE` otherwise.
#'   `aemet_show_api_key()` displays stored API keys.
#'
#' @family aemet_auth
#'
#' @export
#' @encoding UTF-8
#'
#' @examples
#'
#' aemet_detect_api_key()
#'
#' # CAUTION: This may reveal API keys.
#' if (FALSE) {
#'   aemet_show_api_key()
#' }
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

#' Migrate the cache configuration from \CRANpkg{rappdirs} to \pkg{tools}
#'
#' Performs a one-time migration of the cache configuration.
#'
#' @param old Path to the old cache configuration directory.
#' @param new Path to the new cache configuration directory.
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

# Support safe mocking.
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
