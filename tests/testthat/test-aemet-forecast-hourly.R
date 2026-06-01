test_that("Online", {
  local_mocked_bindings(
    get_metadata_aemet = function(...) {
      mock_aemet_metadata()
    },
    aemet_hlp_meta_forecast = function(meta) {
      meta
    },
    aemet_forecast_hourly_single = function(x, ...) {
      if (identical(x, "naha")) {
        stop("No forecast")
      }
      mock_forecast_hourly_data(aemet_hlp_pad_integer(x, 5))
    }
  )

  meta <- aemet_forecast_hourly("a", extract_metadata = TRUE)
  # Same as
  meta2 <- aemet_forecast_hourly(
    "NOEXIST",
    extract_metadata = TRUE,
    verbose = TRUE
  )
  expect_identical(meta, meta2)

  st <- aemet_munic$municipio[1:3]

  # Default
  alll <- aemet_forecast_hourly(st, verbose = TRUE)
  expect_s3_class(alll, "tbl_df")
  expect_identical(unique(alll$municipio), st)

  # Same as
  stn <- as.numeric(st)

  allln <- aemet_forecast_hourly(stn)
  expect_identical(alll[1, ], allln[1, ])
  # NULL
  expect_warning(
    emp <- aemet_forecast_hourly("naha"),
    "Unknown or uninitialised column"
  )

  expect_s3_class(emp, "tbl_df")
  expect_equal(nrow(emp), 0)

  # Extract some vars
  vv <- aemet_forecast_vars_available(alll)
  expect_identical(vv, "temperatura")

  expect_error(aemet_forecast_tidy(alll, "hagaga"), "Variable")

  # Extract everythig
  for (v in vv) {
    tt <- aemet_forecast_tidy(alll, v)
    expect_s3_class(tt, "tbl_df")
  }
})

test_that("hourly forecast parser handles raw API shape", {
  local_mocked_bindings(
    get_data_aemet = function(...) {
      mock_raw_municipality_forecast()
    }
  )

  out <- aemet_forecast_hourly_single(1)

  expect_s3_class(out, "tbl_df")
  expect_identical(out$municipio, "00001")
  expect_identical(out$fecha, as.Date("2024-01-02"))
  expect_s3_class(out$temperatura[[1]], "tbl_df")
})
