test_that("Errors and validations", {
  # Validations aemet_daily clim
  expect_snapshot(aemet_daily_clim(NULL), error = TRUE)
  expect_snapshot(aemet_daily_clim(start = "aa"), error = TRUE)
  expect_snapshot(aemet_daily_clim(return_sf = "aa"), error = TRUE)
  expect_snapshot(aemet_daily_clim(verbose = "aa"), error = TRUE)

  # Validations aemet_daily_period
  expect_snapshot(aemet_daily_period("a", start = NULL), error = TRUE)
  expect_snapshot(aemet_daily_period("a", end = NULL), error = TRUE)
  expect_snapshot(aemet_daily_period("a", start = "aa"), error = TRUE)
  expect_snapshot(aemet_daily_period("a", end = "aa"), error = TRUE)

  # Validations aemet_daily_period_all
  expect_snapshot(aemet_daily_period_all(start = NULL), error = TRUE)
  expect_snapshot(aemet_daily_period_all(end = NULL), error = TRUE)
  expect_snapshot(aemet_daily_period_all(start = "aa"), error = TRUE)
  expect_snapshot(aemet_daily_period_all(end = "aa"), error = TRUE)
})

test_that("aemet_daily for all", {
  local_mocked_bindings(
    get_metadata_aemet = function(...) {
      mock_aemet_metadata()
    },
    get_data_aemet = function(...) {
      mock_daily_clim_data(c("9434", "3195", "0001"))
    },
    aemet_stations = function(...) {
      mock_aemet_stations()
    }
  )

  meta <- aemet_daily_clim(extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_daily_clim("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # Default
  alll <- aemet_daily_clim(verbose = TRUE)
  expect_s3_class(alll, "tbl_df")
  alll2 <- aemet_daily_clim()

  expect_identical(alll, alll2)
  expect_identical(unique(alll$indicativo), c("9434", "3195", "0001"))

  # Past today
  morethantoday <- aemet_daily_clim(end = Sys.Date() + 1, verbose = TRUE)
  expect_identical(alll2, morethantoday)

  # Single day
  alll3 <- aemet_daily_clim(start = Sys.Date() - 20, end = Sys.Date() - 20)

  expect_s3_class(alll3, "tbl_df")

  # More days
  alll_more <- aemet_daily_clim(start = "2023-01-01", end = "2023-02-15")
  expect_s3_class(alll_more, "tbl_df")

  # sf
  alll_sf <- aemet_daily_clim(return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})

test_that("aemet_daily iterations", {
  local_mocked_bindings(
    get_data_aemet = function(apidest, ...) {
      station <- sub(".*/estacion/([^/]+).*", "\\1", apidest)
      mock_daily_clim_data(station)
    },
    aemet_stations = function(...) {
      mock_aemet_stations()
    }
  )

  st_demo <- c("9434", "3195", "0001")
  # Default
  alll <- aemet_daily_clim(st_demo)
  expect_s3_class(alll, "tbl_df")
  expect_identical(unique(alll$indicativo), st_demo)

  # More days
  alll_more <- aemet_daily_clim(
    st_demo,
    start = "2023-01-01",
    end = "2023-06-30"
  )
  expect_s3_class(alll_more, "tbl_df")
  expect_identical(unique(alll_more$indicativo), st_demo)

  # sf
  alll_sf <- aemet_daily_clim(st_demo, return_sf = TRUE)

  expect_identical(unique(alll_sf$indicativo), st_demo)
  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})

test_that("aemet_daily_period", {
  local_mocked_bindings(get_data_aemet = function(apidest, ...) {
    station <- sub(".*/estacion/([^/]+).*", "\\1", apidest)
    mock_daily_clim_data(rep(station, 250))
  })

  st_demo <- "9434"
  # Default
  alll <- aemet_daily_period(st_demo, start = 2023, end = 2023)
  expect_s3_class(alll, "tbl_df")
  expect_identical(unique(alll$indicativo), st_demo)

  expect_gt(length(unique(alll$fecha)), 200)
})
