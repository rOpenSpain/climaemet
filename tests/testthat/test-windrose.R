test_that("ggwindrose", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = c(TRUE, FALSE))
  )
  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = seq(1, 3), direction = "atest")
  )
  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = seq(1, 3), direction = seq(1, 3), stack_reverse = 45)
  )
  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = seq(1, 3), direction = seq(1, 3), facet = 35)
  )

  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = seq(1, 3), direction = seq(1, 3), facet = letters)
  )
  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = seq(1, 3), direction = seq(1, 8))
  )
  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = seq(1, 3), direction = seq(401, 403))
  )

  speed <- climaemet::climaemet_9434_wind$velmedia
  direction <- climaemet::climaemet_9434_wind$dir

  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = speed, direction = direction, n_directions = seq(1, 3))
  )
  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = speed, direction = direction, n_speeds = seq(1, 3))
  )
  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = speed, direction = direction, calm_wind = seq(1, 3))
  )

  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = speed, direction = direction, legend_title = seq(1, 3))
  )

  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = speed, direction = direction, speed_cuts = letters[1:3])
  )

  expect_snapshot(
    error = TRUE,
    ggwindrose(speed = speed, direction = direction, col_pal = "SOMECRAZY")
  )

  expect_snapshot(
    s <- ggwindrose(speed = speed, direction = direction, n_directions = 37)
  )
  expect_s3_class(s, "ggplot")

  expect_silent(
    s <- ggwindrose(
      speed = speed,
      direction = direction,
      stack_reverse = TRUE,
      facet = rep(c("A", "B"), length(direction) / 2),
      speed_cuts = c(min(speed) - 3, seq(3, 15, 2))
    )
  )
  expect_s3_class(s, "ggplot")
  expect_silent(
    s <- ggwindrose(
      speed = speed,
      direction = direction,
      facet = "unique",
      speed_cuts = seq(8, 15, 2)
    )
  )
  expect_s3_class(s, "ggplot")
})

test_that("Online", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  expect_message(
    s <- windrose_days(
      "9434",
      start = "2000-12-01",
      end = "2000-12-31",
      speed_cuts = 4
    ),
    "Data download may take a few seconds"
  )
  expect_s3_class(s, "ggplot")

  expect_message(
    s <- windrose_period(
      "9434",
      start = 2000,
      end = 2001,
      speed_cuts = 9
    ),
    "Data download may take a few seconds"
  )
  expect_s3_class(s, "ggplot")
})
