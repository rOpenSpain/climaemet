test_that("Errors and validations", {
  # Validations aemet_daily clim
  expect_snapshot(aemet_daily_clim(NULL), error = TRUE)
  expect_snapshot(aemet_daily_clim(start = "aa"), error = TRUE)
  expect_snapshot(aemet_daily_clim(return_sf = "aa"), error = TRUE)
  expect_snapshot(aemet_daily_clim(verbose = "aa"), error = TRUE)

  # Validations aemet_daily_period
  expect_snapshot(aemet_daily_period(start = NULL), error = TRUE)
  expect_snapshot(aemet_daily_period(end = NULL), error = TRUE)
  expect_snapshot(aemet_daily_period(start = "aa"), error = TRUE)
  expect_snapshot(aemet_daily_period(end = "aa"), error = TRUE)

  # Validations aemet_daily_period_all
  expect_snapshot(aemet_daily_period_all(start = NULL), error = TRUE)
  expect_snapshot(aemet_daily_period_all(end = NULL), error = TRUE)
  expect_snapshot(aemet_daily_period_all(start = "aa"), error = TRUE)
  expect_snapshot(aemet_daily_period_all(end = "aa"), error = TRUE)
})

test_that("aemet_daily for all", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  meta <- aemet_daily_clim(extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_daily_clim("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # Default
  expect_message(alll <- aemet_daily_clim(verbose = TRUE))
  expect_s3_class(alll, "tbl_df")
  Sys.sleep(0.5)
  expect_silent(alll2 <- aemet_daily_clim())

  expect_identical(alll, alll2)
  expect_gt(length(unique(alll$indicativo)), 100)


  # Past today
  Sys.sleep(0.5)
  morethantoday <- aemet_daily_clim(end = Sys.Date() + 100)
  expect_identical(alll2, morethantoday)


  # Single day
  Sys.sleep(0.5)
  expect_silent(alll3 <- aemet_daily_clim(
    start = Sys.Date() - 20,
    end = Sys.Date() - 20
  ))


  expect_s3_class(alll3, "tbl_df")

  # More days
  Sys.sleep(0.5)
  alll_more <- aemet_daily_clim(start = "2023-01-01", end = "2023-02-15")

  # sf
  Sys.sleep(0.5)
  alll_sf <- aemet_daily_clim(return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})

test_that("aemet_daily iterations", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  st_demo <- aemet_stations()$indicativo[1:3]
  # Default
  alll <- aemet_daily_clim(st_demo)
  expect_s3_class(alll, "tbl_df")
  expect_identical(unique(alll$indicativo), st_demo)

  # More days
  Sys.sleep(0.5)
  alll_more <- aemet_daily_clim(st_demo,
    start = "2023-01-01",
    end = "2023-06-30"
  )
  expect_s3_class(alll_more, "tbl_df")
  expect_identical(unique(alll_more$indicativo), st_demo)


  # sf
  Sys.sleep(0.5)
  expect_silent(alll_sf <- aemet_daily_clim(
    st_demo,
    return_sf = TRUE
  ))

  expect_identical(unique(alll_sf$indicativo), st_demo)
  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})

test_that("aemet_daily_period", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  st_demo <- aemet_stations()$indicativo[1]
  # Default
  alll <- aemet_daily_period(st_demo, start = 2023, end = 2023)
  expect_s3_class(alll, "tbl_df")
  expect_identical(unique(alll$indicativo), st_demo)

  expect_gt(length(unique(alll$fecha)), 200)
})
