test_that("Mocking no valid API key", {
  local_mocked_bindings(aemet_hlp_get_allkeys = function(...) {
    NULL
  })

  expect_null(aemet_hlp_get_allkeys())
  expect_error(cache_apikeys("noexist.rds"), "Configure a valid API key with")
})

test_that("Mocking no API key", {
  local_mocked_bindings(aemet_detect_api_key = function(...) {
    FALSE
  })

  expect_false(aemet_detect_api_key())
  expect_error(get_data_aemet(apidest = "testing"), "Configure an API key with")
})

test_that("get_data_aemet handles mocked response branches", {
  local_fake_api_key()

  httr2::local_mocked_responses(list(mock_aemet_response(
    '{"estado":404}',
    status = 404
  )))
  expect_null(get_data_aemet("endpoint"))

  httr2::local_mocked_responses(list(mock_aemet_response('{"estado":200}')))
  expect_snapshot(expect_null(get_data_aemet("endpoint")))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"datos":"data-url"}'),
    mock_aemet_response('{"estado":404}', status = 404)
  ))
  expect_null(get_data_aemet("endpoint"))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"datos":"data-url"}'),
    httr2::response(
      status_code = 200,
      headers = list("content-type" = "application/json"),
      body = raw()
    )
  ))
  expect_snapshot(expect_null(get_data_aemet("endpoint")))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"datos":"data-url"}'),
    mock_aemet_response('[{"id":"a","value":1}]')
  ))
  out <- get_data_aemet("endpoint")
  expect_s3_class(out, "tbl_df")
  expect_identical(out$id, "a")

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"datos":"data-url"}'),
    mock_aemet_response("GIF89a", type = "image/gif")
  ))
  expect_snapshot(raw <- get_data_aemet("endpoint"))
  expect_type(raw, "raw")

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"datos":"data-url"}'),
    mock_aemet_response("plain text", type = "text/plain")
  ))
  expect_snapshot(string <- get_data_aemet("endpoint"))
  expect_identical(string, "plain text")

  local_fake_api_key(c("TEST_API_KEY_1234567890", "TEST_API_KEY_0987654321"))
  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"datos":"data-url"}'),
    mock_aemet_response('[{"id":"a","value":1}]')
  ))
  expect_snapshot(out <- get_data_aemet("endpoint", verbose = TRUE))
  expect_s3_class(out, "tbl_df")

  local_fake_api_key(c("TEST_API_KEY_xxxxx", "TEST_API_KEY_yyyyy"))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"datos":"data-url"}'),
    mock_aemet_response('[{"id":"a","value":1}]', type = "")
  ))
  expect_s3_class(get_data_aemet("endpoint"), "tbl_df")

  local_fake_api_key(c("TEST_API_KEY_platano", "TEST_API_KEY_fresa"))

  test_vector <- "a test vector"
  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"datos":"data-url"}'),
    mock_aemet_response(test_vector, type = "")
  ))
  ss <- get_data_aemet("endpoint")
  expect_identical(rawToChar(ss), test_vector)
})

test_that("get_metadata_aemet errors without an API key", {
  local_mocked_bindings(aemet_detect_api_key = function(...) {
    FALSE
  })
  expect_error(get_metadata_aemet("endpoint"), "Configure an API key")
})

test_that("get_metadata_aemet handles mocked response branches", {
  local_fake_api_key()

  httr2::local_mocked_responses(list(mock_aemet_response(
    '{"estado":404}',
    status = 404
  )))
  expect_null(get_metadata_aemet("endpoint"))

  httr2::local_mocked_responses(list(mock_aemet_response('{"estado":200}')))
  expect_snapshot(expect_null(get_metadata_aemet("endpoint")))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"metadatos":"metadata-url"}'),
    mock_aemet_response('{"estado":404}', status = 404)
  ))
  expect_null(get_metadata_aemet("endpoint"))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"metadatos":"metadata-url"}'),
    httr2::response(
      status_code = 200,
      headers = list("content-type" = "application/json"),
      body = raw()
    )
  ))
  expect_snapshot(expect_null(get_metadata_aemet("endpoint")))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"metadatos":"metadata-url"}'),
    mock_aemet_response('{"campos":[{"id":"a","descripcion":"b"}],"empty":[]}')
  ))
  out <- get_metadata_aemet("endpoint")
  expect_s3_class(out, "tbl_df")
  expect_identical(out$campos[[1]]$id, "a")

  local_fake_api_key(c("TEST_API_KEY_1234567890", "TEST_API_KEY_0987654321"))
  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"metadatos":"metadata-url"}'),
    mock_aemet_response('{"campos":[{"id":"a","descripcion":"b"}]}')
  ))
  expect_snapshot(meta <- get_metadata_aemet("endpoint", verbose = TRUE))
  expect_s3_class(meta, "tbl_df")

  local_fake_api_key(c("TEST_API_KEY_EINSTEIN", "TEST_API_KEY_GALILEO"))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"metadatos":"metadata-url"}'),
    mock_aemet_response('{"campos":[{"id":"a","descripcion":"b"}]}', type = "")
  ))

  expect_s3_class(get_metadata_aemet("endpoint"), "tbl_df")

  local_fake_api_key(c("TEST_API_KEY_MESSI", "TEST_API_KEY_CR7"))

  test_vector <- "a test vector"

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"metadatos":"metadata-url"}'),
    mock_aemet_response(test_vector, type = "")
  ))

  ss <- get_metadata_aemet("endpoint")
  expect_identical(ss, test_vector)

  local_fake_api_key(c("TEST_API_KEY_MILIKI", "TEST_API_KEY_FOFO"))

  test_vector <- "a test vector"
  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"metadatos":"metadata-url"}'),
    mock_aemet_response(test_vector, type = "gif")
  ))
  ss <- get_metadata_aemet("endpoint")
  expect_identical(rawToChar(ss), test_vector)
})

test_that("aemet_api_call handles mocked HTTP responses", {
  apikey <- local_fake_api_key()

  httr2::local_mocked_responses(list(mock_aemet_response(
    '{"estado":401}',
    status = 401
  )))
  expect_error(aemet_api_call("endpoint", apikey = apikey), "HTTP 401")

  httr2::local_mocked_responses(list(mock_aemet_response(
    '{"estado":404,"descripcion":"Not here"}',
    status = 404
  )))
  expect_snapshot(expect_null(aemet_api_call("endpoint", apikey = apikey)))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":429}', status = 429),
    mock_aemet_response('{"estado":200}', status = 200)
  ))
  expect_s3_class(aemet_api_call("endpoint", apikey = apikey), "httr2_response")

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":429}', status = 429),
    mock_aemet_response('{"estado":401}', status = 401)
  ))
  expect_error(aemet_api_call("endpoint", apikey = apikey), "HTTP 401")

  httr2::local_mocked_responses(list(mock_aemet_response(
    "not json",
    status = 418
  )))
  expect_snapshot(expect_null(aemet_api_call("endpoint", apikey = apikey)))
})

test_that("aemet_api_call validates inputs and updates cached quota", {
  expect_error(aemet_api_call(apidest = "fake"), "`apikey` cannot be")
  apikey <- local_fake_api_key()

  httr2::local_mocked_responses(list(mock_aemet_response(
    '{"estado":200}',
    headers = list("Remaining-request-count" = "123")
  )))

  expect_snapshot(
    response <- aemet_api_call("endpoint", verbose = TRUE, apikey = apikey)
  )
  expect_s3_class(response, "httr2_response")
  expect_identical(get_db_apikeys()$remain, 123)
})

test_that("Priority of api keys", {
  db_file <- withr::local_tempfile(fileext = ".rds")
  db_name <- basename(db_file)
  unlink(db_file)

  local_mocked_bindings(aemet_hlp_get_allkeys = function(...) {
    c("LOWER_QUOTA_KEY_12345", "HIGHER_QUOTA_KEY_1234")
  })

  ps <- cache_apikeys(db_name)
  expect_true(file.exists(db_file))
  expect_identical(ps$apikey, "LOWER_QUOTA_KEY_12345")

  db <- get_db_apikeys(db_name)
  expect_identical(db$remain, rep_len(150, nrow(db)))

  db$remain <- c(10, 140)
  saveRDS(db, db_file)
  expect_identical(cache_apikeys(db_name)$apikey, "HIGHER_QUOTA_KEY_1234")
})
