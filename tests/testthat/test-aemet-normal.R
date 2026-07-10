test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_normal_clim(NULL), error = TRUE)
  expect_snapshot(aemet_normal_clim(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_normal_clim(verbose = "A"), error = TRUE)
})

test_that("Online", {
  local_mocked_bindings(
    get_metadata_aemet = function(...) {
      mock_aemet_metadata()
    },
    get_data_aemet = function(apidest, ...) {
      station <- sub(".*/estacion/([^/]+).*", "\\1", apidest)
      mock_normal_clim_data(station)
    },
    aemet_stations = function(...) {
      mock_aemet_stations()
    }
  )

  st <- c("9434", "3195")
  meta <- aemet_normal_clim("a", extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_normal_clim("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # And
  meta3 <- aemet_normal_clim_all(extract_metadata = TRUE)
  expect_identical(meta3, meta2)

  # Default
  alll <- aemet_normal_clim(st, verbose = TRUE)
  expect_s3_class(alll, "tbl_df")

  expect_identical(unique(alll$indicativo), st)

  # sf
  alll_sf <- aemet_normal_clim(st, return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})

test_that("aemet_normal_clim_all uses station inventory", {
  local_mocked_bindings(
    aemet_stations = function(...) {
      mock_aemet_stations()
    },
    aemet_normal_clim = function(station, ...) {
      dplyr::tibble(indicativo = station)
    }
  )

  out <- aemet_normal_clim_all()

  expect_s3_class(out, "tbl_df")
  expect_identical(out$indicativo, mock_aemet_stations()$indicativo)
})
