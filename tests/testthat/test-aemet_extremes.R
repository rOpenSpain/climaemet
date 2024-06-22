test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_extremes_clim(NULL), error = TRUE)
  expect_snapshot(aemet_extremes_clim("NULL", parameter = NULL), error = TRUE)
  expect_snapshot(aemet_extremes_clim("NULL", parameter = TRUE), error = TRUE)
  expect_snapshot(aemet_extremes_clim("NULL", parameter = "ABC"), error = TRUE)
})


test_that("Online", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  st <- c("9434", "3195")
  meta <- aemet_extremes_clim("all", extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_extremes_clim("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # Default
  expect_message(alll <- aemet_extremes_clim(st, verbose = TRUE))
  expect_s3_class(alll, "tbl_df")

  expect_identical(unique(alll$indicativo), st)


  # Other params
  alll_p <- aemet_extremes_clim(st, parameter = "P")
  alll_v <- aemet_extremes_clim(st, parameter = "V")

  expect_false(identical(alll_p, alll))
  expect_false(identical(alll_p, alll_v))
  expect_false(identical(alll_v, alll))

  # sf
  Sys.sleep(0.5)
  alll_sf <- aemet_extremes_clim(st, return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})

test_that("Parsing errors", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  expect_message(v <- aemet_extremes_clim("B013X", parameter = "V"))
  expect_true(is.list(v))

  expect_message(p <- aemet_extremes_clim("B013X", parameter = "P"))
  expect_true(is.list(p))
})
