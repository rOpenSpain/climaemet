test_that("Detection", {
  skip_if_no_aemet_api()

  # Internal
  int <- aemet_hlp_get_allkeys()
  exp <- aemet_show_api_key()
  expect_identical(int, exp)
})

test_that("Load at init the keys", {
  skip_if_no_aemet_api()

  # recover keys and install
  the_keys <- aemet_show_api_key()
  aemet_api_key(the_keys, install = TRUE, overwrite = TRUE)

  # For safety, create a backup copy
  keydir <- tools::R_user_dir("climaemet", "config")
  path_orig <- file.path(keydir, "aemet_api_key")
  path_bk <- file.path(tempdir(), "aemet_api_key")

  unlink(path_bk)
  file.copy(path_orig, path_bk, overwrite = TRUE)

  # Now start to mess up with the keys

  # Uninstall from the env
  allk <- names(Sys.getenv())
  envk <- allk[grepl("AEMET_API_KEY", allk, fixed = TRUE)]

  for (k in envk) {
    Sys.unsetenv(k)
  }

  # Delete cache dir
  unlink(keydir, force = TRUE, recursive = TRUE)
  expect_false(aemet_detect_api_key())

  expect_snapshot(aemet_daily_clim(), error = TRUE)
  expect_snapshot(aemet_daily_clim(extract_metadata = TRUE), error = TRUE)

  expect_identical(aemet_show_api_key(), character(0))

  # Install and overwrite
  expect_message(aemet_api_key(the_keys))
  aemet_api_key(the_keys, overwrite = TRUE, install = TRUE)
  expect_error(aemet_api_key(the_keys, install = TRUE))
  expect_silent(aemet_api_key(the_keys, install = TRUE, overwrite = TRUE))

  # Trigger detection
  expect_true(aemet_detect_api_key())

  # Clean the envars and trigger detection again from cache
  for (k in envk) {
    Sys.unsetenv(k)
  }

  expect_true(aemet_detect_api_key())
  # And restore everything
  file.copy(path_bk, path_orig, overwrite = TRUE)
  expect_identical(aemet_show_api_key(), the_keys)
})

test_that("Errors", {
  skip_on_cran()
  expect_snapshot(error = TRUE, aemet_api_key(list(a = 1)))
})


test_that("Minimal validation for aemet_show_api_key", {
  local_mocked_bindings(aemet_hlp_get_allkeys = function(...) {
    "TEST_SHOW_API_KEY"
  })

  expect_snapshot(aemet_show_api_key())
})


test_that("Mock migration", {
  skip_if_no_aemet_api()

  # recover keys and install
  the_keys <- aemet_show_api_key()
  aemet_api_key(the_keys, install = TRUE, overwrite = TRUE)

  # For safety, create a backup copy
  keydir <- tools::R_user_dir("climaemet", "config")
  path_orig <- file.path(keydir, "aemet_api_key")
  path_bk <- file.path(tempdir(), "aemet_api_key")

  unlink(path_bk)
  file.copy(path_orig, path_bk, overwrite = TRUE)

  # Create mocks files and directories.
  olddir <- file.path(tempdir(), "oldcache")
  newdir <- file.path(tempdir(), "newcache")

  # Create a migration.
  oldfile <- get_path_apikey_db(olddir)
  oldfile_bk <- get_path_apikey_db(olddir, "bk_aemet_api_key")
  newfile <- get_path_apikey_db(newdir)
  writeLines("A_FAKE_API", oldfile)

  my_fn <- aemet_api_key

  local_mocked_bindings(aemet_api_key = function(apikeys, install = TRUE) {
    cli::cli_alert_info("Mocking new installation here with {install}.")
    writeLines(apikeys, newfile)
  })

  expect_true(file.exists(oldfile))
  expect_false(file.exists(oldfile_bk))
  expect_false(file.exists(newfile))
  expect_false(file.exists(file.path(olddir, "README.md")))
  expect_message(
    migrate_cache(olddir, newdir),
    "Mocking new installation here with TRUE."
  )
  expect_false(file.exists(oldfile))
  expect_true(file.exists(oldfile_bk))
  expect_true(file.exists(newfile))
  expect_true(file.exists(file.path(olddir, "README.md")))

  expect_identical(readLines(oldfile_bk), readLines(newfile))

  # Now we must ensure that new APIs are written to the right file.
  local_mocked_bindings(aemet_api_key = my_fn)

  my_fn2 <- get_path_apikey_db
  local_mocked_bindings(get_path_apikey_db = function(...) {
    newfile
  })

  expect_error(aemet_api_key(
    c("TWO_KEYS", "THREE_KEYS"),
    install = TRUE,
    overwrite = FALSE
  ))

  aemet_api_key(c("TWO_KEYS", "THREE_KEYS"), install = TRUE, overwrite = TRUE)
  expect_identical(readLines(newfile), c("TWO_KEYS", "THREE_KEYS"))

  # Trigger detection
  expect_true(aemet_detect_api_key())
  expect_identical(aemet_show_api_key()[1:2], c("TWO_KEYS", "THREE_KEYS"))

  # Restore everything.
  unlink(oldfile_bk)
  unlink(newfile)
  unlink(file.path(olddir, "README.md"))

  # Uninstall from the env
  allk <- names(Sys.getenv())
  envk <- allk[grepl("AEMET_API_KEY", allk, fixed = TRUE)]

  for (k in envk) {
    Sys.unsetenv(k)
  }

  local_mocked_bindings(get_path_apikey_db = my_fn2)
  file.copy(path_bk, path_orig, overwrite = TRUE)
  expect_true(aemet_detect_api_key())

  expect_identical(aemet_show_api_key(), the_keys)
})
