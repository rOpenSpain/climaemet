test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_stations(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_stations(verbose = "A"), error = TRUE)
})

test_that("Online", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  # First clean cache
  cached_df <- file.path(tempdir(), "aemet_stations.rds")
  cached_date <- file.path(tempdir(), "aemet_stations_date.rds")
  unlink(cached_df)
  unlink(cached_date)

  # First download
  expect_message(aemet_stations(verbose = TRUE), regexp = "API call")

  # Now is cached
  expect_message(
    aemet_stations(verbose = TRUE),
    regexp = "Loading stations from temporal cached file"
  )

  st1 <- aemet_stations()
  expect_s3_class(st1, "tbl_df")

  # sf
  Sys.sleep(0.5)
  alll_sf <- aemet_stations(return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
