test_that("Detection", {
  skip_if_no_aemet_api()

  # Internal
  expect_true(aemet_detect_api_key())
  int <- aemet_hlp_get_allkeys()
  exp <- aemet_show_api_key()
  expect_identical(int, exp)
})

test_that("Detection on init forcing read", {
  local_aemet_api_key_cache()
  local_aemet_api_key_env()

  writeLines("TEST_SOME_API_KEY", get_path_apikey_db())
  local_aemet_api_key_env()

  expect_true(aemet_detect_api_key())
  expect_identical(aemet_show_api_key(), "TEST_SOME_API_KEY")
})

test_that("Detection ignores empty cached keys", {
  local_aemet_api_key_cache()
  local_aemet_api_key_env()

  writeLines(character(0), get_path_apikey_db())
  expect_false(aemet_detect_api_key())

  writeLines("", get_path_apikey_db())
  expect_false(aemet_detect_api_key())
})

test_that("Load at init the keys", {
  skip_if_no_aemet_api()

  local_aemet_api_key_cache()

  # Uninstall from the env

  local_aemet_api_key_env()

  # Delete cache dir
  expect_false(aemet_detect_api_key())

  expect_snapshot(aemet_daily_clim(), error = TRUE)
  expect_snapshot(aemet_daily_clim(extract_metadata = TRUE), error = TRUE)

  expect_identical(aemet_show_api_key(), character(0))

  # Install and overwrite
  the_keys <- "TEST_SOME_API_KEY"
  expect_snapshot(aemet_api_key(the_keys))
  aemet_api_key(the_keys, overwrite = TRUE, install = TRUE)
  expect_error(aemet_api_key(the_keys, install = TRUE))
  expect_silent(aemet_api_key(the_keys, install = TRUE, overwrite = TRUE))

  # Trigger detection
  expect_true(aemet_detect_api_key())
})

test_that("Errors", {
  skip_on_cran()
  expect_snapshot(error = TRUE, aemet_api_key(list(a = 1)))
})


test_that("Minimal validation for aemet_show_api_key", {
  local_mocked_bindings(
    aemet_detect_api_key = function(...) {
      TRUE
    },
    aemet_hlp_get_allkeys = function(...) {
      "TEST_SHOW_API_KEY"
    }
  )

  expect_snapshot(aemet_show_api_key())
})


test_that("Mock migration", {
  skip_if_no_aemet_api()

  local_aemet_api_key_cache()

  local_aemet_api_key_env()

  # Create mocks files and directories.
  olddir <- file.path(withr::local_tempdir("old_test"), "oldcache")
  newdir <- file.path(withr::local_tempdir("new_test"), "newcache")

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
  expect_snapshot(migrate_cache(olddir, newdir))
  expect_false(file.exists(oldfile))
  expect_true(file.exists(oldfile_bk))
  expect_true(file.exists(newfile))
  expect_true(file.exists(file.path(olddir, "README.md")))

  expect_identical(readLines(oldfile_bk), readLines(newfile))

  # Now we must ensure that new APIs are written to the right file.
  local_mocked_bindings(aemet_api_key = my_fn)

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
})
