test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_last_obs(NULL), error = TRUE)
  expect_snapshot(aemet_last_obs(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_last_obs(verbose = "A"), error = TRUE)
})

test_that("Online", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  st <- c("9434", "3195")
  meta <- aemet_last_obs(extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_last_obs("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # Default
  expect_message(alll <- aemet_last_obs(verbose = TRUE))
  expect_s3_class(alll, "tbl_df")

  # If any is all ignore
  alll2 <- aemet_last_obs(c("all", "IDONOT"))
  expect_identical(alll, alll2)

  # Several
  sev <- aemet_last_obs(st)
  expect_identical(unique(sev$idema), st)


  # sf
  Sys.sleep(0.5)
  alll_sf <- aemet_last_obs(st, return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
