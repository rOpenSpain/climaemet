test_that("Online", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  bc <- aemet_beaches()
  st <- bc$ID_PLAYA[1:3]
  meta <- aemet_forecast_beaches(st, extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_forecast_beaches("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # Default
  expect_message(alll <- aemet_forecast_beaches(st, verbose = TRUE))
  expect_s3_class(alll, "tbl_df")

  expect_identical(unique(alll$id), st)

  # Same as
  alln <- aemet_forecast_beaches(as.numeric(st))
  expect_identical(alln, alll)

  # Throw error
  expect_snapshot(alle <- aemet_forecast_beaches(c(st, "ASTRINGWHATEVER")))

  expect_identical(alle, alll)


  # sf
  Sys.sleep(0.5)
  alll_sf <- aemet_forecast_beaches(st, return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
