test_that("Errors", {
  skip_if_no_aemet_api()

  expect_snapshot(aemet_forecast_fires("Idonotexist"), error = TRUE)
})

test_that("Metadata", {
  skip_if_no_aemet_api()

  meta <- aemet_forecast_fires(extract_metadata = TRUE)
  expect_s3_class(meta, "tbl")
})

test_that("rasters", {
  skip_if_no_aemet_api()
  skip_if_not_installed("terra")

  library(terra)
  rr <- aemet_forecast_fires()
  expect_s4_class(rr, "SpatRaster")

  expect_gt(terra::nlyr(rr), 5)
  expect_true(all(terra::is.factor(rr)))
  expect_true(all(terra::has.colors(rr)))

  # Should be different for c
  cc <- aemet_forecast_fires("c")
  expect_s4_class(cc, "SpatRaster")
  expect_true(terra::identical(rr, rr))
  expect_false(terra::identical(rr, cc))
})
