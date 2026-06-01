test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_beaches(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_beaches(verbose = "A"), error = TRUE)
})

test_that("Online", {
  # First clean cache
  cached_df <- file.path(tempdir(), "aemet_beaches.rds")
  cached_date <- file.path(tempdir(), "aemet_beaches_date.rds")
  unlink(cached_df)
  unlink(cached_date)
  withr::defer(unlink(c(cached_df, cached_date)))

  csv <- paste(
    "ID_PLAYA;NOMBRE_PLAYA;ID_PROVINCIA;LONGITUD;LATITUD",
    "1;Test beach;03;-0º 30' 00\";38º 20' 00\"",
    sep = "\n"
  )
  httr2::local_mocked_responses(list(
    mock_aemet_response(csv, type = "text/csv")
  ))

  # First download
  s <- aemet_beaches()
  expect_s3_class(s, "tbl_df")

  # Now is cached
  expect_message(
    aemet_beaches(verbose = TRUE),
    regexp = "Loading beaches from temporary cached file"
  )

  st1 <- aemet_beaches()
  expect_s3_class(st1, "tbl_df")

  # sf
  alll_sf <- aemet_beaches(return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_true(unique(sf::st_geometry_type(alll_sf)) == "POINT")
})
