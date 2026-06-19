test_that("climatogram_normal", {
  local_mocked_bindings(
    aemet_normal_clim = function(station, ...) {
      if (identical(station, "XXXX")) {
        return(dplyr::tibble())
      }
      mock_normal_clim_data(station)
    },
    aemet_stations = function(...) {
      mock_aemet_stations()
    }
  )

  n <- climatogram_normal("9434", ggplot2 = TRUE)
  expect_s3_class(n, "ggplot")
  expect_message(n <- climatogram_normal("9434", verbose = TRUE, labels = NULL))
  expect_s3_class(n, "ggplot")

  expect_error(n <- climatogram_normal("XXXX"), "no valid results")
})

test_that("climatogram_period", {
  local_mocked_bindings(
    aemet_monthly_period = function(station, start, ...) {
      if (identical(station, "XXXX")) {
        return(dplyr::tibble())
      }
      if (start < 1900) {
        stop("No valid period")
      }
      mock_monthly_period_data(station, start)
    },
    aemet_stations = function(...) {
      mock_aemet_stations()
    }
  )

  n <- climatogram_period("9434", start = 2019, end = 2020, ggplot2 = TRUE)
  expect_s3_class(n, "ggplot")
  n <- climatogram_period(
    "9434",
    verbose = TRUE,
    labels = NULL,
    start = 2019,
    end = 2020
  )
  expect_s3_class(n, "ggplot")

  expect_error(n <- climatogram_period("XXXX", start = 2019, end = 2020))

  expect_error(n <- climatogram_period("9434", start = 1800, end = 1801))
})
test_that("ggclimat_walter_lieth", {
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
  local_mocked_bindings(
    aemet_normal_clim = function(station, ...) {
      mock_normal_clim_data(station)
    },
    aemet_monthly_period = function(station, start, ...) {
      mock_monthly_period_data(station, start)
    },
    aemet_stations = function(...) {
      mock_aemet_stations()
    }
  )

  expect_no_error(n <- climatogram_normal("9434", ggplot2 = FALSE))
  expect_no_error(
    n <- climatogram_period("9434", start = 2019, end = 2020, ggplot2 = FALSE)
  )
})
