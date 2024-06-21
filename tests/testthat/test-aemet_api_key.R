test_that("Detection", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  # Internal
  int <- aemet_hlp_get_allkeys()
  exp <- aemet_show_api_key()
  expect_identical(int, exp)
})


test_that("Load at init the keys", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  # recover keys and install
  the_keys <- aemet_show_api_key()
  aemet_api_key(the_keys, install = TRUE, overwrite = TRUE)

  # For safety, create a backup copy
  keydir <- rappdirs::user_cache_dir("climaemet", "R")
  path_orig <- file.path(keydir, "aemet_api_key")
  path_bk <- file.path(tempdir(), "aemet_api_key")

  unlink(path_bk)
  file.copy(path_orig, path_bk, overwrite = TRUE)

  # Now start to mess up with the keys

  # Uninstall from the env
  allk <- names(Sys.getenv())
  envk <- allk[grepl("AEMET_API_KEY", allk)]

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
