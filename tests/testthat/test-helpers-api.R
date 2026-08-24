test_that("extract_content_type handles missing and JSON content types", {
  na_type <- mock_aemet_response('{"estado":404}', status = 404, type = "")
  expect_identical(extract_content_type(na_type), "<unknown>")
  json_type <- mock_aemet_response(
    '{"estado":404}',
    status = 404,
    type = "application/json"
  )

  expect_identical(extract_content_type(json_type), "application/json")
})

test_that("try_parse_resp parses JSON and preserves unknown responses", {
  na_type <- mock_aemet_response("a number, is = here", type = "")
  expect_s3_class(try_parse_resp(na_type), "httr2_response")

  list_type <- mock_aemet_response(jsonlite::toJSON(list(a = 1)), type = "")
  expect_identical(try_parse_resp(list_type), list(a = list(1L)))
})

test_that("delay_aemet_api increases delays as quota decreases", {
  tic <- Sys.time()
  delay_aemet_api(200)
  no_delay <- Sys.time() - tic

  tic <- Sys.time()
  delay_aemet_api(125)
  some_delay <- Sys.time() - tic

  tic <- Sys.time()
  delay_aemet_api(110)
  yes_delay <- Sys.time() - tic

  expect_true(yes_delay > some_delay)
  expect_true(some_delay > no_delay)
})
