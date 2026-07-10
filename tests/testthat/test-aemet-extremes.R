test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_extremes_clim(NULL), error = TRUE)
  expect_snapshot(aemet_extremes_clim("NULL", parameter = NULL), error = TRUE)
  expect_snapshot(aemet_extremes_clim("NULL", parameter = TRUE), error = TRUE)
  expect_snapshot(aemet_extremes_clim("NULL", parameter = "ABC"), error = TRUE)
})

test_that("Online", {
  local_mocked_bindings(
    get_metadata_aemet = function(...) {
      mock_aemet_metadata()
    },
    get_data_aemet = function(apidest, ...) {
      station <- sub(".*/estacion/([^/]+).*", "\\1", apidest)
      parameter <- sub(".*/parametro/([^/]+)/estacion.*", "\\1", apidest)
      mock_extremes_clim_data(station, parameter)
    },
    aemet_stations = function(...) {
      mock_aemet_stations()
    }
  )

  st <- c("9434", "3195")
  meta <- aemet_extremes_clim("all", extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_extremes_clim("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # Default
  alll <- aemet_extremes_clim(st, verbose = TRUE)
  expect_s3_class(alll, "tbl_df")

  expect_identical(unique(alll$indicativo), st)

  # Other params
  alll_p <- aemet_extremes_clim(st, parameter = "P")
  alll_v <- aemet_extremes_clim(st, parameter = "V")

  expect_false(identical(alll_p, alll))
  expect_false(identical(alll_p, alll_v))
  expect_false(identical(alll_v, alll))

  # sf
  alll_sf <- aemet_extremes_clim(st, return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})

test_that("Parsing errors", {
  local_mocked_bindings(get_data_aemet = function(...) {
    list(matrix(1:4, nrow = 2))
  })

  expect_snapshot(v <- aemet_extremes_clim("B013X", parameter = "V"))
  expect_type(v, "list")

  expect_snapshot(p <- aemet_extremes_clim("B013X", parameter = "P"))
  expect_type(p, "list")
})
