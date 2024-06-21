test_that("Errors and validations", {
  # Validations aemet_monthly_clim
  expect_snapshot(aemet_monthly_clim(NULL), error = TRUE)
  expect_snapshot(aemet_monthly_clim("a", year = "aa"), error = TRUE)
  expect_snapshot(aemet_monthly_clim("a", return_sf = "aa"), error = TRUE)
  expect_snapshot(aemet_monthly_clim("a", verbose = "aa"), error = TRUE)

  # Validations aemet_monthly_period
  expect_snapshot(aemet_monthly_period("a", start = NULL), error = TRUE)
  expect_snapshot(aemet_monthly_period("a", end = NULL), error = TRUE)
  expect_snapshot(aemet_monthly_period(NULL, start = "aa"), error = TRUE)

  # Validations aemet_monthly_period_all
  expect_snapshot(aemet_monthly_period_all(start = NULL), error = TRUE)
  expect_snapshot(aemet_monthly_period_all(end = NULL), error = TRUE)
  expect_snapshot(aemet_monthly_period_all(start = "NULL"), error = TRUE)
  expect_snapshot(aemet_monthly_period_all(end = "NULL"), error = TRUE)
})
