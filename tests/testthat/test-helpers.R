test_that("dms2decdegrees parses compact coordinates and validates inputs", {
  expect_snapshot(dms2decdegrees("055245W"))

  expect_snapshot(dms2decdegrees("522312N"))
  expect_snapshot(error = TRUE, dms2decdegrees(NULL))
  expect_snapshot(error = TRUE, dms2decdegrees(45))
})

test_that("dms2decdegrees_2 parses spaced coordinates and validates inputs", {
  expect_snapshot(dms2decdegrees_2("-5º 52' 45\""))

  expect_snapshot(dms2decdegrees_2("52º 23'12\""))

  expect_snapshot(dms2decdegrees_2("52º 2312\""), error = TRUE)
})

test_that("year boundary helpers return dates and reject invalid years", {
  expect_snapshot(first_day_of_year(2000))
  expect_snapshot(last_day_of_year(2020))

  expect_snapshot(first_day_of_year(), error = TRUE)
  expect_snapshot(last_day_of_year(), error = TRUE)

  expect_snapshot(first_day_of_year("A"), error = TRUE)
  expect_snapshot(last_day_of_year("B"), error = TRUE)
})

test_that("aemet_hlp_validate_logical accepts only scalar logical values", {
  # Valid logical values
  expect_silent(aemet_hlp_validate_logical(TRUE, "test_arg"))
  expect_silent(aemet_hlp_validate_logical(FALSE, "test_arg"))

  # Invalid values with snapshot errors
  expect_snapshot(error = TRUE, aemet_hlp_validate_logical("TRUE", "my_param"))
  expect_snapshot(error = TRUE, aemet_hlp_validate_logical(1, "my_param"))
  expect_snapshot(error = TRUE, aemet_hlp_validate_logical(NULL, "my_param"))
  expect_snapshot(
    error = TRUE,
    aemet_hlp_validate_logical(c(TRUE, FALSE), "my_param")
  )

  # Inside a fun
  a_mock_fun <- function(x) {
    aemet_hlp_validate_logical(x, "inside_a_fun")
  }
  expect_snapshot(error = TRUE, a_mock_fun(list()))
})

test_that("API helpers construct endpoints and parse response headers", {
  expect_null(aemet_hlp_order_monthly(NULL))
  expect_identical(
    aemet_endpoint_forecast("playa", "0000001"),
    "/api/prediccion/especifica/playa/0000001"
  )

  response <- httr2::response(
    status_code = 200,
    headers = list(aemet_estado = "HTTP 404", aemet_mensaje = "Not found"),
    body = charToRaw("")
  )
  code <- extract_resp_code(response)

  expect_identical(code$estado, 404)
  expect_identical(code$descripcion, "Not found")
})
