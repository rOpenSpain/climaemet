test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_alert_zones(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_alert_zones(verbose = "A"), error = TRUE)
})


test_that("Online", {
  skip_on_cran()
  skip_if_offline()


  # First clean cache
  cached_df <- file.path(tempdir(), "aemet_alert_zones.gpkg")
  cached_date <- file.path(tempdir(), "aemet_alert_zone_date.rds")

  unlink(cached_df)
  unlink(cached_date)

  # First download
  s <- aemet_alert_zones()


  # Now is cached
  expect_message(
    aemet_alert_zones(verbose = TRUE),
    regexp = "Loading alert zones from temporal cached file"
  )

  st1 <- aemet_alert_zones()
  expect_s3_class(st1, "tbl_df")

  # sf
  alll_sf <- aemet_alert_zones(return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_s3_class(alll_sf, "tbl")
})
