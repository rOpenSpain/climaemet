test_that("forecast metadata parser handles real daily AEMET metadata", {
  skip_if_no_aemet_api()

  meta <- aemet_forecast_daily(
    "28079",
    extract_metadata = TRUE,
    verbose = FALSE
  )

  expect_s3_class(meta, "tbl_df")
  expect_true(all(c("campos", "unidad_generadora") %in% names(meta)))
  expect_true(all(c("id", "descripcion") %in% names(meta$campos)))
  expect_true("viento_velocidad" %in% meta$campos$id)
  expect_true("rachaMax" %in% meta$campos$id)
})

test_that("forecast tidy handles real hourly wind gust values", {
  skip_if_no_aemet_api()

  hourly <- aemet_forecast_hourly(
    "28079",
    verbose = FALSE,
    progress = FALSE
  )
  vars <- aemet_forecast_vars_available(hourly)

  expect_true("vientoAndRachaMax" %in% vars)

  wind <- aemet_forecast_tidy(hourly, "vientoAndRachaMax")

  expect_s3_class(wind, "tbl_df")
  expect_gt(nrow(wind), 0)
  expect_true(all(
    c(
      "hora",
      "vientoAndRachaMax",
      "vientoAndRachaMax_direccion",
      "vientoAndRachaMax_velocidad"
    ) %in%
      names(wind)
  ))
  expect_equal(unique(wind$municipio), "28079")
  expect_false(any(is.na(wind$hora)))
})

test_that("forecast tidy handles four-digit hourly periods", {
  hourly <- tibble::tibble(
    elaborado = as.POSIXct(
      "2024-01-01 00:00:00",
      tz = "Europe/Madrid"
    ),
    municipio = "00001",
    id = "00001",
    nombre = "Municipality 00001",
    fecha = as.Date("2024-01-01") + 0:2,
    temperatura = list(
      tibble::tibble(periodo = "0000", value = 10),
      tibble::tibble(periodo = "0600", value = 11),
      tibble::tibble(periodo = "1200", value = 12)
    )
  )

  temp <- aemet_forecast_tidy(hourly, "temperatura")

  expect_s3_class(temp, "tbl_df")
  expect_equal(format(temp$hora), c("00:00:00", "06:00:00", "12:00:00"))
})
