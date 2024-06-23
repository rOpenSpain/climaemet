test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_beaches(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_beaches(verbose = "A"), error = TRUE)
})


test_that("Online", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  # First clean cache
  cached_df <- file.path(tempdir(), "aemet_beaches.rds")
  cached_date <- file.path(tempdir(), "aemet_beaches_date.rds")
  unlink(cached_df)
  unlink(cached_date)

  # First download
  s <- aemet_beaches()


  # Now is cached
  expect_message(
    aemet_beaches(verbose = TRUE),
    regexp = "Loading beaches from temporal cached file"
  )

  st1 <- aemet_beaches()
  expect_s3_class(st1, "tbl_df")

  # sf
  Sys.sleep(0.5)
  alll_sf <- aemet_beaches(return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
