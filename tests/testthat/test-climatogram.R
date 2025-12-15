test_that("climatogram_normal", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")
  n <- climatogram_normal("9434", ggplot2 = TRUE)
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

  n <- climatogram_period("9434", start = 2019, end = 2020, ggplot2 = TRUE)
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

  expect_error(n <- climatogram_period("9434", start = 1800, end = 1801))
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

  # Distinct of
  n2 <- ggclimat_walter_lieth(df, shem = TRUE, p3line = TRUE)
  expect_s3_class(n2, "ggplot")

  expect_false(identical(
    ggplot2::get_layer_data(n),
    ggplot2::get_layer_data(n2)
  ))

  dfcold <- df
  dfcold[2, ] <- dfcold[2, ] - 10
  dfcold[3, ] <- dfcold[3, ] - 10
  dfcold[4, ] <- dfcold[4, ] - 10
  ncold <- ggclimat_walter_lieth(dfcold)
  expect_s3_class(ncold, "ggplot")
})

test_that("Try climatol", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  expect_no_error(
    n <- climatogram_normal("9434", ggplot2 = FALSE)
  )
  expect_no_error(
    n <- climatogram_period("9434", start = 2019, end = 2020, ggplot2 = FALSE)
  )
})
