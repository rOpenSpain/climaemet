local_fake_api_key <- function(apikey = "TEST_API_KEY_1234567890") {
  env <- parent.frame()
  withr::local_envvar(c(AEMET_API_KEY = apikey), .local_envir = env)

  db_file <- file.path(tempdir(), "dbapikey.rds")
  saveRDS(tibble::tibble(apikey = apikey, remain = 150), db_file)
  withr::defer(unlink(db_file), envir = env)

  invisible(apikey)
}

mock_aemet_response <- function(
  body = "",
  type = "application/json",
  status = 200
) {
  httr2::response(
    status_code = status,
    headers = list("content-type" = type),
    body = charToRaw(body)
  )
}

test_that("Mocking no valid API key", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  my_fn <- aemet_hlp_get_allkeys
  local_mocked_bindings(aemet_hlp_get_allkeys = function(...) {
    NULL
  })

  expect_null(aemet_hlp_get_allkeys())

  expect_snapshot(error = TRUE, cache_apikeys("noexist.rds"))

  local_mocked_bindings(aemet_hlp_get_allkeys = my_fn)
  expect_false(is.null(aemet_hlp_get_allkeys()))
})

test_that("Mocking no API key", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  my_fn <- aemet_detect_api_key
  local_mocked_bindings(aemet_detect_api_key = function(...) {
    FALSE
  })

  expect_false(aemet_detect_api_key())

  expect_snapshot(error = TRUE, get_data_aemet(apidest = "testing"))

  local_mocked_bindings(aemet_detect_api_key = my_fn)
  expect_true(aemet_detect_api_key())
})

test_that("get_data_aemet handles mocked response branches", {
  local_fake_api_key()

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":404}', status = 404)
  ))
  expect_null(get_data_aemet("endpoint"))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200}')
  ))
  expect_message(
    expect_null(get_data_aemet("endpoint")),
    "Unable to parse JSON"
  )

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
  expect_message(
    expect_null(get_data_aemet("endpoint")),
    "API request did not return a body"
  )

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200,"datos":"data-url"}'),
    mock_aemet_response('[{"id":"a","value":1}]')
  ))
  out <- get_data_aemet("endpoint")
  expect_s3_class(out, "tbl_df")
  expect_identical(out$id, "a")
})

test_that("get_metadata_aemet errors without an API key", {
  local_mocked_bindings(aemet_detect_api_key = function(...) {
    FALSE
  })
  expect_error(get_metadata_aemet("endpoint"), "An API key is required")
})

test_that("get_metadata_aemet handles mocked response branches", {
  local_fake_api_key()

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":404}', status = 404)
  ))
  expect_null(get_metadata_aemet("endpoint"))

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":200}')
  ))
  expect_message(
    expect_null(get_metadata_aemet("endpoint")),
    "Unable to parse JSON"
  )

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
  expect_message(
    expect_null(get_metadata_aemet("endpoint")),
    "API request did not return a body"
  )
})

test_that("aemet_api_call handles mocked HTTP responses", {
  apikey <- local_fake_api_key()

  httr2::local_mocked_responses(list(
    mock_aemet_response('{"estado":401}', status = 401)
  ))
  expect_error(aemet_api_call("endpoint", apikey = apikey), "HTTP 401")

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

  httr2::local_mocked_responses(list(
    mock_aemet_response("not json", status = 418)
  ))
  expect_message(
    expect_null(aemet_api_call("endpoint", apikey = apikey)),
    "API request failed"
  )
})

test_that("Manual request", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  today <- "/api/prediccion/nacional/hoy"
  expect_message(tt <- get_data_aemet(today, verbose = TRUE), "API call")
  expect_true(is.character(tt))

  expect_message(tt2 <- get_metadata_aemet(today, verbose = TRUE))
  expect_silent(tt2 <- get_metadata_aemet(today))
  expect_s3_class(tt2, "tbl_df")

  # Raw data should inform
  expect_message(
    ss <- get_data_aemet("/api/mapasygraficos/analisis", verbose = FALSE),
    "Results are MIME type:"
  )
  expect_true(is.raw(ss))

  # Some errors
  expect_snapshot(error = TRUE, aemet_api_call(apidest = "fake"))
  entry <- paste0(
    "api/valores/climatologicos/inventarioestaciones/",
    "todasestaciones"
  )

  expect_snapshot(error = TRUE, aemet_api_call(entry, apikey = "FAKEONE"))
  expect_snapshot(
    error = TRUE,
    aemet_api_call(
      paste0("https://opendata.aemet.es/opendata/", entry),
      data_call = TRUE,
      verbose = TRUE,
      apikey = "FAKEONE"
    )
  )
  expect_snapshot(
    n <- aemet_api_call(
      paste0("https://opendata.aemet.es/opendata/", entry, "/fake"),
      data_call = TRUE,
      verbose = TRUE,
      apikey = "FAKEONE"
    )
  )
  expect_null(n)

  expect_snapshot(
    n <- aemet_api_call(
      "https://opendata.aemet.es/opendata/sh/1234fakethis",
      data_call = TRUE,
      verbose = TRUE,
      apikey = aemet_show_api_key()[1]
    )
  )

  expect_null(n)
})

test_that("Priority of api keys", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  db_file <- file.path(tempdir(), "dbapikey.rds")
  if (file.exists(db_file)) {
    unlink(db_file)
  }
  expect_false(file.exists(db_file))

  # From scratch
  ps <- cache_apikeys()
  expect_true(file.exists(db_file))

  # With 150 initially
  db <- get_db_apikeys()
  expect_identical(db$remain, rep_len(150, nrow(db)))

  # Should be generated in the first run
  if (file.exists(db_file)) {
    unlink(db_file)
  }
  expect_false(file.exists(db_file))
  tt <- aemet_daily_clim()
  expect_true(file.exists(db_file))

  # And the db should be updated now
  db <- get_db_apikeys()

  expect_false(all(db$remain == rep_len(150, nrow(db))))

  # Do some runs to get actual quota
  for (i in seq_len(nrow(db))) {
    tt <- aemet_last_obs(station = default_station)
  }

  db <- get_db_apikeys()

  # And exhaust
  for (i in seq_len(nrow(db) * 2)) {
    tt <- aemet_last_obs(station = default_station)
  }

  dbnow <- get_db_apikeys()
  names(dbnow) <- c("apikey", "remain_test")
  dbend <- merge(db, dbnow, by = "apikey")

  # I would expect all values have reduced

  expect_true(any(dbend$remain > dbend$remain_test))
})
