local_fake_api_key <- function(apikey = "TEST_API_KEY_1234567890") {
  env <- parent.frame()
  key_names <- vapply(
    seq_along(apikey),
    aemet_hlp_api_key_name,
    FUN.VALUE = character(1)
  )
  withr::local_envvar(stats::setNames(apikey, key_names), .local_envir = env)

  db_file <- file.path(climaemet_tempdir(), "dbapikey.rds")
  saveRDS(dplyr::tibble(apikey = apikey, remain = 150), db_file)
  withr::defer(unlink(db_file), envir = env)

  invisible(apikey)
}

local_aemet_api_key_env <- function(apikey = NULL, env = parent.frame()) {
  key_names <- names(Sys.getenv())
  key_names <- key_names[grepl("^AEMET_API", key_names)]
  old_keys <- Sys.getenv(key_names, names = TRUE)

  withr::defer(
    {
      current_keys <- names(Sys.getenv())
      current_keys <- current_keys[grepl("^AEMET_API", current_keys)]
      Sys.unsetenv(current_keys)

      if (length(old_keys) > 0) {
        do.call(Sys.setenv, as.list(old_keys))
      }
    },
    envir = env
  )

  Sys.unsetenv(key_names)

  if (!is.null(apikey)) {
    new_key_names <- vapply(
      seq_along(apikey),
      aemet_hlp_api_key_name,
      FUN.VALUE = character(1)
    )
    do.call(Sys.setenv, as.list(stats::setNames(apikey, new_key_names)))
  }

  invisible(key_names)
}

local_aemet_api_key_cache <- function(env = parent.frame()) {
  new_cache <- withr::local_tempdir(.local_envir = env)
  old_cache <- withr::local_tempdir(.local_envir = env)

  testthat::local_mocked_bindings(
    climaemet_user_dir = function(...) {
      new_cache
    },
    climaemet_user_cache_dir = function(...) {
      old_cache
    },
    .env = env
  )

  invisible(new_cache)
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
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  testthat::skip_if_not(aemet_detect_api_key(), message = "No API KEY")
}

mock_aemet_stations <- function() {
  dplyr::tibble(
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
  dplyr::tibble(
    indicativo = station,
    fecha = as.character(Sys.Date() - seq_along(station)),
    tmed = seq_along(station),
    prec = seq_along(station) / 10
  )
}

mock_monthly_clim_data <- function(station = "9434") {
  dplyr::tibble(
    indicativo = station,
    fecha = c("2023-1", "2023-2")[seq_along(station)],
    p_mes = seq_along(station),
    tm_mes = seq_along(station) + 10
  )
}

mock_aemet_metadata <- function() {
  dplyr::tibble(
    id = c("indicativo", "fecha"),
    descripcion = c("Station identifier", "Date")
  )
}

mock_forecast_daily_data <- function(id = "00001") {
  dplyr::tibble(
    municipio = id,
    id = id,
    nombre = paste("Municipality", id),
    elaborado = as.POSIXct("2024-01-01 00:00:00", tz = "Europe/Madrid"),
    fecha = as.Date("2024-01-02"),
    temperatura = list(dplyr::tibble(
      periodo = c("00", "12"),
      value = c(10, 15)
    ))
  )
}

mock_raw_municipality_forecast <- function(id = "00001") {
  dplyr::tibble(
    elaborado = "2024-01-01T00:00:00",
    id = id,
    nombre = paste("Municipality", id),
    provincia = "TEST",
    prediccion = list(dplyr::tibble(
      dia = list(dplyr::tibble(
        fecha = "2024-01-02",
        temperatura = list(dplyr::tibble(
          periodo = c("00", "12"),
          value = c(10, 15)
        )),
        estadoCielo = list(dplyr::tibble(
          periodo = c("00", "12"),
          value = c(11, 12),
          descripcion = c("Clear", "Cloudy")
        )),
        viento = list(dplyr::tibble(
          periodo = c("00", "12"),
          direccion = c("N", "S"),
          velocidad = c(5, 7)
        ))
      ))
    ))
  )
}

mock_forecast_hourly_data <- function(id = "00001") {
  dplyr::tibble(
    municipio = id,
    id = id,
    nombre = paste("Municipality", id),
    elaborado = as.POSIXct("2024-01-01 00:00:00", tz = "Europe/Madrid"),
    fecha = as.Date("2024-01-01") + 0:2,
    temperatura = list(
      dplyr::tibble(periodo = "00", value = 10),
      dplyr::tibble(periodo = "06", value = 11),
      dplyr::tibble(periodo = "12", value = 12)
    )
  )
}

mock_forecast_beach_data <- function(id = "0000001") {
  dplyr::tibble(
    id = id,
    localidad = "00001",
    fecha = as.Date("2024-01-01"),
    nombre = paste("Beach", id),
    elaborado = as.POSIXct("2024-01-01 00:00:00", tz = "Europe/Madrid"),
    tagua_valor1 = 18
  )
}

mock_raw_beach_forecast <- function(id = "1", locality = "1") {
  dplyr::tibble(
    elaborado = "2024-01-01T00:00:00",
    id = id,
    localidad = locality,
    nombre = paste("Beach", id),
    prediccion = list(dplyr::tibble(
      dia = list(dplyr::tibble(
        fecha = "20240102",
        tagua = list(dplyr::tibble(valor1 = 18)),
        oleaje = list(dplyr::tibble(valor1 = 1))
      ))
    ))
  )
}

mock_aemet_beaches <- function() {
  dplyr::tibble(
    ID_PLAYA = c("0000001", "0000002", "0000003"),
    NOMBRE_PLAYA = c("Beach 1", "Beach 2", "Beach 3"),
    longitud = c(-3, -4, -5),
    latitud = c(40, 41, 42)
  )
}

mock_wind_data <- function(station = "9434") {
  dplyr::tibble(
    indicativo = station,
    fecha = as.Date("2000-12-01") + 0:7,
    dir = c(1, 4, 8, 12, 16, 20, 24, 32),
    velmedia = c(1, 2, 3, 4, 5, 6, 7, 8)
  )
}

mock_stripes_period_data <- function(station = "9434") {
  dplyr::tibble(
    indicativo = station,
    fecha = paste0(2020:2024, "-13"),
    tm_mes = c(14, 14.5, 15, 15.2, 15.8)
  )
}

mock_normal_clim_data <- function(station = "9434") {
  dat <- as.data.frame(climaemet::climaemet_9434_climatogram)
  dplyr::tibble(
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
  dplyr::tibble(
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
  dplyr::tibble(
    indicativo = station,
    parametro = parameter,
    valor = value + seq_along(station),
    fecha = as.Date("2024-01-01")
  )
}
