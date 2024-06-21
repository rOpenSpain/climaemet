test_that("Online", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  meta <- aemet_forecast_daily("a", extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_forecast_daily("NOEXIST",
    extract_metadata = TRUE,
    verbose = TRUE
  )
  expect_identical(meta, meta2)


  st <- aemet_munic$municipio[1:10]

  # Default
  expect_message(alll <- aemet_forecast_daily(st, verbose = TRUE))
  expect_s3_class(alll, "tbl_df")
  expect_identical(unique(alll$municipio), st)

  # Same as
  stn <- as.numeric(st)

  allln <- aemet_forecast_daily(stn)
  expect_identical(alll, allln)
  # NUll
  expect_snapshot(emp <- aemet_forecast_daily("naha"))

  expect_s3_class(emp, "tbl_df")
  expect_equal(nrow(emp), 0)
  expect_snapshot(dput(emp))

  # Extract some vars
  expect_snapshot(vv <- aemet_forecast_vars_available(alll))

  expect_snapshot(aemet_forecast_tidy(alll, "hagaga"), error = TRUE)

  # Extract everythig
  for (v in vv) {
    tt <- aemet_forecast_tidy(alll, v)
    expect_s3_class(tt, "tbl_df")
  }
})
