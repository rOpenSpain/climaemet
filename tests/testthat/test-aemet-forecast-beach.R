test_that("Online", {
  local_mocked_bindings(
    aemet_beaches = function(...) {
      mock_aemet_beaches()
    },
    get_metadata_aemet = function(...) {
      mock_aemet_metadata()
    },
    aemet_hlp_meta_forecast = function(meta) {
      meta
    },
    aemet_forecast_beach_single = function(x, ...) {
      if (identical(x, "ASTRINGWHATEVER")) {
        stop("No forecast")
      }
      mock_forecast_beach_data(aemet_hlp_pad_integer(x, 7))
    }
  )

  bc <- aemet_beaches()
  st <- bc$ID_PLAYA[1:3]
  meta <- aemet_forecast_beaches(st, extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_forecast_beaches("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # Default
  alll <- aemet_forecast_beaches(st, verbose = TRUE)
  expect_s3_class(alll, "tbl_df")

  expect_identical(unique(alll$id), st)

  # Same as
  alln <- aemet_forecast_beaches(as.numeric(st))
  alln <- alln[, names(alll)]
  expect_identical(alln, alll)

  # Throw error
  alle <- aemet_forecast_beaches(c(st, "ASTRINGWHATEVER"))
  alle <- alle[, names(alll)]

  expect_identical(alle, alll)

  # sf
  alll_sf <- aemet_forecast_beaches(st, return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
