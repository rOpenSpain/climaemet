test_that("ggstripes errors", {
  data <- climaemet::climaemet_9434_temp

  expect_snapshot(
    error = TRUE,
    ggstripes(data, plot_title = "Zaragoza Airport", n_temp = "calab")
  )
  expect_snapshot(
    error = TRUE,
    ggstripes(data, plot_title = "Zaragoza Airport", plot_type = "calab")
  )
  expect_snapshot(
    error = TRUE,
    ggstripes(data, plot_title = "Zaragoza Airport", col_pal = "calab")
  )
  expect_snapshot(
    error = TRUE,
    ggstripes(data.frame(x = 1), plot_title = "Zaragoza Airport")
  )
})

test_that("ggstripes plotting", {
  data <- climaemet::climaemet_9434_temp

  expect_snapshot(
    n <- ggstripes(data, plot_title = "Zaragoza Airport"),
  )

  expect_s3_class(n, "ggplot")
})
test_that("climatestripes_station", {
  local_mocked_bindings(
    aemet_monthly_period = function(station, ...) {
      mock_stripes_period_data(station)
    },
    aemet_stations = function(...) {
      mock_aemet_stations()
    }
  )

  expect_snapshot(
    n <- climatestripes_station(
      "9434",
      start = 2024,
      end = 2024,
      with_labels = "yes",
      col_pal = "Inferno"
    )
  )

  expect_s3_class(n, "ggplot")
  expect_snapshot(
    n2 <- climatestripes_station(
      "9434",
      start = 2024,
      end = 2024,
      with_labels = NULL,
      col_pal = "Inferno"
    )
  )

  expect_identical(n, n2)

  n3 <- climatestripes_station(
    "9434",
    start = 2024,
    end = 2024,
    with_labels = "no",
    col_pal = "Inferno"
  )
  expect_s3_class(n3, "ggplot")

  local_mocked_bindings(
    aemet_monthly_period = function(...) {
      dplyr::tibble()
    }
  )

  expect_snapshot(error = TRUE, climatestripes_station("anyvalue"))
})
