test_that("Check sf", {
  skip_if_not_installed("sf")

  # Example tb
  ex <- climaemet::aemet_munic[1:10, ]

  expect_snapshot(bad <- aemet_hlp_sf(ex, "lat", "lon", verbose = FALSE))
  expect_s3_class(bad, "tbl_df")

  expect_silent(asf <- aemet_hlp_sf(ex, "cpro", "codauto"))

  expect_s3_class(asf, "sf")
  expect_snapshot(a <- aemet_hlp_sf(ex, "cpro", "codauto", verbose = TRUE))

  # MOdify and add NAs
  ex$cpro[1] <- NA

  expect_snapshot(bad2 <- aemet_hlp_sf(ex, "cpro", "codauto", verbose = FALSE))
  expect_s3_class(bad2, "tbl_df")
})
