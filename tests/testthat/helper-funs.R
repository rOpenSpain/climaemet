local_fake_api_key <- function(apikey = "TEST_API_KEY_1234567890") {
  env <- parent.frame()
  key_names <- vapply(
    seq_along(apikey),
    aemet_hlp_api_key_name,
    FUN.VALUE = character(1)
  )
  withr::local_envvar(stats::setNames(apikey, key_names), .local_envir = env)

  db_file <- file.path(tempdir(), "dbapikey.rds")
  saveRDS(tibble::tibble(apikey = apikey, remain = 150), db_file)
  withr::defer(unlink(db_file), envir = env)

  invisible(apikey)
}

mock_aemet_response <- function(
  body = "",
  type = "application/json",
  status = 200,
  headers = list()
) {
  headers <- c(list("content-type" = type), headers)
  httr2::response(
    status_code = status,
    headers = headers,
    body = charToRaw(body)
  )
}

skip_if_no_aemet_api <- function() {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")
}

mock_aemet_stations <- function() {
  tibble::tibble(
    indicativo = c("9434", "3195", "0001"),
    indsinop = c("08160", "08221", "08001"),
    nombre = c("Station 9434", "Station 3195", "Station 0001"),
    provincia = c("ZARAGOZA", "MADRID", "TEST"),
    altitud = c(249, 667, 100),
    longitud = c(-0.88, -3.70, 0),
    latitud = c(41.66, 40.41, 1)
  )
}

mock_daily_clim_data <- function(station = "9434") {
  tibble::tibble(
    indicativo = station,
    fecha = as.character(Sys.Date() - seq_along(station)),
    tmed = seq_along(station),
    prec = seq_along(station) / 10
  )
}

mock_monthly_clim_data <- function(station = "9434") {
  tibble::tibble(
    indicativo = station,
    fecha = c("2023-1", "2023-2")[seq_along(station)],
    p_mes = seq_along(station),
    tm_mes = seq_along(station) + 10
  )
}

mock_aemet_metadata <- function() {
  tibble::tibble(
    id = c("indicativo", "fecha"),
    descripcion = c("Station identifier", "Date")
  )
}

mock_forecast_daily_data <- function(id = "00001") {
  tibble::tibble(
    municipio = id,
    id = id,
    nombre = paste("Municipality", id),
    elaborado = as.POSIXct("2024-01-01 00:00:00", tz = "Europe/Madrid"),
    fecha = as.Date("2024-01-02"),
    temperatura = list(tibble::tibble(periodo = c("00", "12"), value = c(10, 15)))
  )
}

mock_forecast_hourly_data <- function(id = "00001") {
  tibble::tibble(
    municipio = id,
    id = id,
    nombre = paste("Municipality", id),
    elaborado = as.POSIXct("2024-01-01 00:00:00", tz = "Europe/Madrid"),
    fecha = as.Date("2024-01-01") + 0:2,
    temperatura = list(
      tibble::tibble(periodo = "00", value = 10),
      tibble::tibble(periodo = "06", value = 11),
      tibble::tibble(periodo = "12", value = 12)
    )
  )
}

mock_forecast_beach_data <- function(id = "0000001") {
  tibble::tibble(
    id = id,
    localidad = "00001",
    fecha = as.Date("2024-01-01"),
    nombre = paste("Beach", id),
    elaborado = as.POSIXct("2024-01-01 00:00:00", tz = "Europe/Madrid"),
    tagua_valor1 = 18
  )
}

mock_aemet_beaches <- function() {
  tibble::tibble(
    ID_PLAYA = c("0000001", "0000002", "0000003"),
    NOMBRE_PLAYA = c("Beach 1", "Beach 2", "Beach 3"),
    longitud = c(-3, -4, -5),
    latitud = c(40, 41, 42)
  )
}

mock_wind_data <- function(station = "9434") {
  tibble::tibble(
    indicativo = station,
    fecha = as.Date("2000-12-01") + 0:7,
    dir = c(1, 4, 8, 12, 16, 20, 24, 32),
    velmedia = c(1, 2, 3, 4, 5, 6, 7, 8)
  )
}

mock_stripes_period_data <- function(station = "9434") {
  tibble::tibble(
    indicativo = station,
    fecha = paste0(2020:2024, "-13"),
    tm_mes = c(14, 14.5, 15, 15.2, 15.8)
  )
}

mock_normal_clim_data <- function(station = "9434") {
  dat <- as.data.frame(climaemet::climaemet_9434_climatogram)
  tibble::tibble(
    indicativo = station,
    mes = seq_len(12),
    p_mes_md = as.numeric(dat[1, ]),
    tm_max_md = as.numeric(dat[2, ]),
    tm_min_md = as.numeric(dat[3, ]),
    ta_min_min = as.numeric(dat[4, ])
  )
}

mock_monthly_period_data <- function(station = "9434", year = 2019) {
  dat <- as.data.frame(climaemet::climaemet_9434_climatogram)
  tibble::tibble(
    indicativo = station,
    fecha = c(sprintf("%s-%02d", year, seq_len(12)), sprintf("%s-13", year)),
    p_mes = c(as.numeric(dat[1, ]), sum(as.numeric(dat[1, ]))),
    tm_max = c(as.numeric(dat[2, ]), mean(as.numeric(dat[2, ]))),
    tm_min = c(as.numeric(dat[3, ]), mean(as.numeric(dat[3, ]))),
    ta_min = c(as.numeric(dat[4, ]), min(as.numeric(dat[4, ])))
  )
}

mock_extremes_clim_data <- function(station = "9434", parameter = "T") {
  value <- switch(parameter,
    T = 30,
    P = 100,
    V = 80
  )
  tibble::tibble(
    indicativo = station,
    parametro = parameter,
    valor = value + seq_along(station),
    fecha = as.Date("2024-01-01")
  )
}
