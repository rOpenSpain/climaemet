test_that("Errors", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  expect_snapshot(aemet_forecast_fires("Idonotexist"), error = TRUE)
})

test_that("Metadata", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")
  Sys.sleep(30)

  meta <- aemet_forecast_fires(extract_metadata = TRUE)
  expect_s3_class(meta, "tbl")
})


test_that("rasters", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")
  skip_if_not_installed("terra")

  library(terra)
  rr <- aemet_forecast_fires()
  expect_s4_class(rr, "SpatRaster")

  expect_gt(terra::nlyr(rr), 5)
  expect_true(all(terra::is.factor(rr)))
  expect_true(all(terra::has.colors(rr)))
  expect_true(terra::has.time(rr))

  # Should be different for c
  cc <- aemet_forecast_fires("c")
  expect_s4_class(cc, "SpatRaster")
  expect_true(terra::identical(rr, rr))
  expect_false(terra::identical(rr, cc))
})
