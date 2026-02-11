test_that("Manual request", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  today <- "/api/prediccion/nacional/hoy"
  expect_message(tt <- get_data_aemet(today, verbose = TRUE), "API call")
  expect_true(is.character(tt))

  expect_message(tt2 <- get_metadata_aemet(today, verbose = TRUE))
  expect_silent(tt2 <- get_metadata_aemet(today))
  expect_s3_class(tt2, "tbl_df")

  # Raw data should inform
  expect_message(
    ss <- get_data_aemet("/api/mapasygraficos/analisis", verbose = FALSE),
    "Results are MIME type:"
  )
  expect_true(is.raw(ss))

  # Some errors
  expect_snapshot(error = TRUE, aemet_api_call(apidest = "fake"))
  entry <- paste0(
    "api/valores/climatologicos/inventarioestaciones/",
    "todasestaciones"
  )

  expect_snapshot(error = TRUE, aemet_api_call(entry, apikey = "FAKEONE"))
  expect_snapshot(
    error = TRUE,
    aemet_api_call(
      paste0("https://opendata.aemet.es/opendata/", entry),
      data_call = TRUE,
      verbose = TRUE,
      apikey = "FAKEONE"
    )
  )
  expect_snapshot(
    n <- aemet_api_call(
      paste0("https://opendata.aemet.es/opendata/", entry, "/fake"),
      data_call = TRUE,
      verbose = TRUE,
      apikey = "FAKEONE"
    )
  )
  expect_null(n)

  expect_snapshot(
    n <- aemet_api_call(
      "https://opendata.aemet.es/opendata/sh/1234fakethis",
      data_call = TRUE,
      verbose = TRUE,
      apikey = aemet_show_api_key()[1]
    )
  )

  expect_null(n)
})


test_that("Priority of api keys", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  db_file <- file.path(tempdir(), "dbapikey.rds")
  if (file.exists(db_file)) {
    unlink(db_file)
  }
  expect_false(file.exists(db_file))

  # From scratch
  ps <- cache_apikeys()
  expect_true(file.exists(db_file))

  # With 150 initially
  db <- get_db_apikeys()
  expect_identical(db$remain, rep_len(150, nrow(db)))

  # Should be generated in the first run
  if (file.exists(db_file)) {
    unlink(db_file)
  }
  expect_false(file.exists(db_file))
  tt <- aemet_daily_clim()
  expect_true(file.exists(db_file))

  # And the db should be updated now
  db <- get_db_apikeys()

  expect_false(all(db$remain == rep_len(150, nrow(db))))

  # Do some runs to get actual quota
  for (i in seq_len(nrow(db))) {
    tt <- aemet_last_obs(station = default_station)
  }

  db <- get_db_apikeys()

  # And exhaust
  for (i in seq_len(nrow(db) * 2)) {
    tt <- aemet_last_obs(station = default_station)
  }

  dbnow <- get_db_apikeys()
  names(dbnow) <- c("apikey", "remain_test")
  dbend <- merge(db, dbnow, by = "apikey")

  # I would expect all values have reduced

  expect_true(any(dbend$remain > dbend$remain_test))
})
