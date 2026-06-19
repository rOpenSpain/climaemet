# Testing only

withr::local_options(
  list(climaemet_timeout = 300),
  .local_envir = testthat::teardown_env()
)

# Write a backup of my AEMET keys as a security measure.
# Located in tests/testthat/backup_keys, it is git- and Rbuild- ignored.
if (climaemet::aemet_detect_api_key()) {
  dir <- testthat::test_path("backup_keys")
  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE)
  }

  # Versioned backup file with timestamp.
  bk_file <- paste0(
    "backup_keys",
    format(Sys.Date(), format = "%Y%m%d"),
    "_",
    as.integer(Sys.time()),
    ".txt"
  )

  writeLines(climaemet::aemet_show_api_key(), file.path(dir, bk_file))
}
