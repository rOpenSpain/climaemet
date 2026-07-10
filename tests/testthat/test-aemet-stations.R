test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_stations(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_stations(verbose = "A"), error = TRUE)
})

test_that("Online", {
  cache_dir <- withr::local_tempdir()
  local_mocked_bindings(climaemet_tempdir = function() {
    cache_dir
  })

  local_mocked_bindings(get_data_aemet = function(...) {
    dplyr::tibble(
      indicativo = c("9434", "3195"),
      indsinop = c("08160", "08221"),
      nombre = c("Station 9434", "Station 3195"),
      provincia = c("ZARAGOZA", "MADRID"),
      altitud = c("249", "667"),
      longitud = c("005248W", "034200W"),
      latitud = c("413938N", "402436N")
    )
  })

  # First download
  downloaded <- aemet_stations(verbose = TRUE)
  expect_s3_class(downloaded, "tbl_df")

  # Now is cached
  expect_message(
    aemet_stations(verbose = TRUE),
    regexp = "from temporary cache file"
  )

  st1 <- aemet_stations()
  expect_s3_class(st1, "tbl_df")

  # sf
  alll_sf <- aemet_stations(return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
