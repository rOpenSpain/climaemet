test_that("climatogram_normal", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  n <- climatogram_normal("9434")
  expect_s3_class(n, "ggplot")
  expect_message(
    n <- climatogram_normal("9434", verbose = TRUE, labels = NULL)
  )
  expect_s3_class(n, "ggplot")

  expect_snapshot(error = TRUE, n <- climatogram_normal("XXXX"))
})

test_that("climatogram_period", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  n <- climatogram_period("9434", start = 2019, end = 2020)
  expect_s3_class(n, "ggplot")
  expect_message(
    n <- climatogram_period(
      "9434",
      verbose = TRUE,
      labels = NULL,
      start = 2019,
      end = 2020
    )
  )
  expect_s3_class(n, "ggplot")

  expect_error(n <- climatogram_period("XXXX", start = 2019, end = 2020))
})
test_that("ggclimat_walter_lieth", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")
  dat <- data.frame(x = 1)
  expect_snapshot(error = TRUE, ggclimat_walter_lieth(dat))

  df <- climaemet::climaemet_9434_climatogram
  df[1, 1] <- NA
  expect_snapshot(error = TRUE, ggclimat_walter_lieth(df))
  df <- climaemet::climaemet_9434_climatogram
  df <- as.matrix(df)
  expect_true(inherits(df, "matrix"))
  expect_silent(n <- ggclimat_walter_lieth(df))
  expect_s3_class(n, "ggplot")
})
