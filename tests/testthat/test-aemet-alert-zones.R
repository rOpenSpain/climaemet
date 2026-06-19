test_that("Errors and validations", {
  # Validations
  expect_snapshot(aemet_alert_zones(return_sf = "A"), error = TRUE)
  expect_snapshot(aemet_alert_zones(verbose = "A"), error = TRUE)
})

test_that("Online", {
  # First clean cache
  cached_df <- file.path(tempdir(), "aemet_alert_zones.gpkg")
  cached_date <- file.path(tempdir(), "aemet_alert_zone_date.rds")

  unlink(cached_df)
  unlink(cached_date)
  withr::defer(unlink(c(cached_df, cached_date)))

  sf_areas <- sf::st_as_sf(
    data.frame(
      COD_CCAA = "01",
      COD_Z = "0101",
      NOM_PROV = "Test province",
      lon = -3,
      lat = 40
    ),
    coords = c("lon", "lat"),
    crs = 4326
  )
  sf::st_write(sf_areas, cached_df, quiet = TRUE)
  saveRDS(Sys.time(), cached_date)

  expect_message(
    st1 <- aemet_alert_zones(verbose = TRUE),
    regexp = "from a temporary cached file"
  )
  expect_s3_class(st1, "tbl_df")

  # sf
  alll_sf <- aemet_alert_zones(return_sf = TRUE)

  expect_s3_class(alll_sf, "sf")
  expect_s3_class(alll_sf, "tbl")
})
