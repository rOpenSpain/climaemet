test_that("ggstripes errors", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

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
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  data <- climaemet::climaemet_9434_temp

  expect_message(
    n <- ggstripes(data, plot_title = "Zaragoza Airport"),
    "Climate stripes plotting ..."
  )
  expect_s3_class(n, "ggplot")

})
test_that("climatestripes_station", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  expect_message(
    n <- climatestripes_station(
      "9434",
      start = 2021,
      end = 2021,
      with_labels = "yes",
      col_pal = "Inferno"
    ),
    "Data download may take a"
  )

  expect_s3_class(n, "ggplot")
  expect_message(
    n2 <- climatestripes_station(
      "9434",
      start = 2021,
      end = 2021,
      with_labels = NULL,
      col_pal = "Inferno"
    ),
    "Data download may take a"
  )

  expect_identical(n, n2)
})
