test_that("Errors and validations", {
  # Validations aemet_monthly_clim
  expect_snapshot(aemet_monthly_clim(NULL), error = TRUE)
  expect_snapshot(aemet_monthly_clim("a", year = "aa"), error = TRUE)
  expect_snapshot(aemet_monthly_clim("a", return_sf = "aa"), error = TRUE)
  expect_snapshot(aemet_monthly_clim("a", verbose = "aa"), error = TRUE)

  # Validations aemet_monthly_period
  expect_snapshot(aemet_monthly_period("a", start = NULL), error = TRUE)
  expect_snapshot(aemet_monthly_period("a", end = NULL), error = TRUE)
  expect_snapshot(aemet_monthly_period(NULL, start = "aa"), error = TRUE)

  # Validations aemet_monthly_period_all
  expect_snapshot(aemet_monthly_period_all(start = NULL), error = TRUE)
  expect_snapshot(aemet_monthly_period_all(end = NULL), error = TRUE)
  expect_snapshot(aemet_monthly_period_all(start = "NULL"), error = TRUE)
  expect_snapshot(aemet_monthly_period_all(end = "NULL"), error = TRUE)
})

test_that("aemet_monthly", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  meta <- aemet_monthly_clim("a", extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_monthly_clim(
    "NOEXIST",
    extract_metadata = TRUE,
    verbose = TRUE
  )
  expect_identical(meta, meta2)

  # Same as
  meta3 <- aemet_monthly_period("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta3)

  # Same as
  meta4 <- aemet_monthly_period_all(extract_metadata = TRUE)
  expect_identical(meta, meta4)

  st <- c("9434", "3195")

  # Default
  expect_message(alll <- aemet_monthly_clim(st, verbose = TRUE))
  expect_s3_class(alll, "tbl_df")

  expect_identical(unique(alll$indicativo), st)

  # maxfechas
  alll2 <- aemet_monthly_clim(st, year = 2029)

  expect_identical(alll, alll2)

  # sf
  Sys.sleep(0.5)
  alll_sf <- aemet_monthly_clim(st, return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})

test_that("aemet_monthly_period", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  Sys.sleep(30)

  st <- c("9434", "3195")

  # Default
  expect_message(alll <- aemet_monthly_period(st, verbose = TRUE))
  expect_s3_class(alll, "tbl_df")

  expect_identical(unique(alll$indicativo), st)

  # maxfechas
  alll2 <- aemet_monthly_period(st, end = 4000)
  expect_identical(alll, alll2)

  # sf
  alll_sf <- aemet_monthly_period(
    st,
    start = 2020,
    end = 2023,
    return_sf = TRUE
  )

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
