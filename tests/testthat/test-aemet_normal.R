test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_normal_clim(NULL), error = TRUE)
  expect_snapshot(aemet_normal_clim(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_normal_clim(verbose = "A"), error = TRUE)
})

test_that("Online", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  Sys.sleep(30)

  st <- c("9434", "3195")
  meta <- aemet_normal_clim("a", extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_normal_clim("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # And
  meta3 <- aemet_normal_clim_all(extract_metadata = TRUE)
  expect_identical(meta3, meta2)

  # Default
  expect_message(alll <- aemet_normal_clim(st, verbose = TRUE))
  expect_s3_class(alll, "tbl_df")

  expect_identical(unique(alll$indicativo), st)


  # sf
  Sys.sleep(0.5)
  alll_sf <- aemet_normal_clim(st, return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
