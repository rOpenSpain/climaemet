test_that("dms2decdegrees works", {
  expect_snapshot(dms2decdegrees("055245W"))

  expect_snapshot(dms2decdegrees("522312N"))
})


test_that("dms2decdegrees_2 works", {
  expect_snapshot(dms2decdegrees_2("-5º 52' 45\""))

  expect_snapshot(dms2decdegrees_2("52º 23'12\""))

  expect_snapshot(dms2decdegrees_2("52º 2312\""), error = TRUE)
})

test_that("first and last works", {
  expect_snapshot(first_day_of_year(2000))
  expect_snapshot(last_day_of_year(2020))

  expect_snapshot(first_day_of_year(), error = TRUE)
  expect_snapshot(last_day_of_year(), error = TRUE)

  expect_snapshot(first_day_of_year("A"), error = TRUE)
  expect_snapshot(last_day_of_year("B"), error = TRUE)
})
