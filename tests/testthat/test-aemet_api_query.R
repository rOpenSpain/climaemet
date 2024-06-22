test_that("Manual request", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")


  today <- "/api/prediccion/nacional/hoy"
  expect_snapshot(tt <- get_data_aemet(today))
  expect_true(is.character(tt))

  tt2 <- get_metadata_aemet(today)
  expect_s3_class(tt2, "tbl_df")
})
