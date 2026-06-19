test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_last_obs(NULL), error = TRUE)
  expect_snapshot(aemet_last_obs(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_last_obs(verbose = "A"), error = TRUE)
})

test_that("Online", {
  local_mocked_bindings(
    get_metadata_aemet = function(...) {
      mock_aemet_metadata()
    },
    get_data_aemet = function(apidest, ...) {
      if (grepl("/todas$", apidest)) {
        station <- c("9434", "3195")
      } else {
        station <- sub(".*/estacion/([^/]+).*", "\\1", apidest)
      }
      dplyr::tibble(
        idema = station,
        fint = as.POSIXct("2024-01-01", tz = "UTC"),
        lat = c(41.66, 40.41)[seq_along(station)],
        lon = c(-0.88, -3.70)[seq_along(station)],
        ta = seq_along(station)
      )
    }
  )

  st <- c("9434", "3195")
  meta <- aemet_last_obs(extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_last_obs("NOEXIST", extract_metadata = TRUE)
  expect_identical(meta, meta2)

  # Default
  alll <- aemet_last_obs(verbose = TRUE)
  expect_s3_class(alll, "tbl_df")

  # If any is all ignore
  alll2 <- aemet_last_obs(c("all", "IDONOT"))
  expect_identical(alll, alll2)

  # Several
  sev <- aemet_last_obs(st)
  expect_identical(unique(sev$idema), st)

  # sf
  alll_sf <- aemet_last_obs(st, return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
