# Daily and annual climatology values

Retrieves climatology values for one station or all available stations.
`aemet_daily_period()` and `aemet_daily_period_all()` are shortcuts for
`aemet_daily_clim()`.

## Usage

``` r
aemet_daily_clim(
  station = "all",
  start = Sys.Date() - 7,
  end = Sys.Date(),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)

aemet_daily_period(
  station,
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)

aemet_daily_period_all(
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)
```

## Arguments

- station:

  A character vector of station identifiers (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md))
  or `"all"` for all stations.

- start, end:

  Character strings containing the start and end dates. See **Details**.

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- return_sf:

  A logical value. If `TRUE`, the function returns an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object. If `FALSE` (the default), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  A logical value. If `TRUE`, displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  unless `verbose = TRUE`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object.

## Details

For `aemet_daily_clim()`, `start` and `end` must be `Date` objects or
strings in `YYYY-MM-DD` format, such as `"2020-12-31"`, that can be
coerced with [`as.Date()`](https://rdrr.io/r/base/as.Date.html). For
`aemet_daily_period()` and `aemet_daily_period_all()`, they must be
strings representing the years to extract, such as `"2018"` and
`"2020"`.

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)
for station identifiers.

Climatology:
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_monthly_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)

## Examples

``` r

library(dplyr)
obs <- aemet_daily_clim(c("9434", "3195"))
glimpse(obs)
#> Rows: 10
#> Columns: 27
#> $ fecha       <date> 2026-07-07, 2026-07-08, 2026-07-09, 2026-07-10, 2026-07-1…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 32.9, 33.6, 32.0, 31.1, 29.6, 30.8, 29.4, 29.8, 30.6, 29.4
#> $ prec        <dbl> 0.0, 0.0, 0.0, 0.2, 0.0, 3.1, 0.0, 0.0, 0.0, 0.2
#> $ tmin        <dbl> 23.5, 25.8, 23.6, 25.0, 21.8, 22.3, 20.8, 21.9, 25.2, 22.0
#> $ horatmin    <time> 04:50:00, 04:20:00, 04:50:00, 05:20:00, 04:40:00, 17:40:00…
#> $ tmax        <dbl> 42.3, 41.4, 40.3, 37.2, 37.3, 39.4, 37.9, 37.8, 36.0, 36.8
#> $ horatmax    <time> 17:00:00, 15:40:00, 14:30:00, 13:40:00, 16:20:00, 14:20:00…
#> $ dir         <chr> "26", "07", "23", "12", "13", "27", "24", "23", "07", "17"
#> $ velmedia    <dbl> 2.8, 4.4, 5.3, 4.2, 2.5, 2.8, 2.5, 2.5, 3.6, 3.3
#> $ racha       <dbl> 14.7, 11.7, 30.0, 13.9, 11.1, 16.9, 8.3, 9.7, 14.2, 13.6
#> $ horaracha   <time> 21:00:00, 17:00:00, 17:00:00, 15:40:00, 20:30:00, 16:10:00…
#> $ sol         <dbl> 11.6, 10.8, 9.5, 9.5, 13.5, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 989.1, 988.6, 984.0, 981.6, 984.0, 945.1, 944.1, 938.8, 93…
#> $ horaPresMax <chr> "08", "08", "00", "24", "07", "21", "00", "00", "22", "Va…
#> $ presMin     <dbl> 984.6, 983.0, 977.5, 977.8, 980.2, 941.1, 938.8, 933.4, 93…
#> $ horaPresMin <chr> "17", "17", "18", "15", "17", "15", "24", "19", "Varias",…
#> $ hrMedia     <dbl> 19, 24, 22, 25, 31, 41, 28, 23, 21, 24
#> $ hrMax       <dbl> 45, 43, 44, 50, 64, 82, 64, 47, 36, 43
#> $ horaHrMax   <chr> "05:30", "04:00", "04:30", "23:59", "05:00", "17:40", "06:…
#> $ hrMin       <dbl> 7, 9, 10, 14, 16, 16, 12, 12, 13, 14
#> $ horaHrMin   <chr> "Varias", "15:50", "16:20", "15:30", "17:00", "14:30", "15…
#> $ pintMax     <dbl> 0.0, 0.0, 0.0, 1.2, 0.0, 6.6, 0.0, 0.0, 0.0, 0.0
#> $ horaPIntMax <time>       NA,       NA,       NA, 11:17:00,       NA, 16:27:00…

# Metadata.
meta <- aemet_daily_clim(c("9434", "3195"), extract_metadata = TRUE)

glimpse(meta$campos)
#> List of 27
#>  $ :List of 4
#>   ..$ id         : chr "fecha"
#>   ..$ descripcion: chr "fecha del dia (AAAA-MM-DD)"
#>   ..$ tipo_datos : chr "string"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 4
#>   ..$ id         : chr "indicativo"
#>   ..$ descripcion: chr "indicativo climatológico"
#>   ..$ tipo_datos : chr "string"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 4
#>   ..$ id         : chr "nombre"
#>   ..$ descripcion: chr "nombre (ubicación) de la estación"
#>   ..$ tipo_datos : chr "string"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 4
#>   ..$ id         : chr "provincia"
#>   ..$ descripcion: chr "provincia de la estación"
#>   ..$ tipo_datos : chr "string"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 5
#>   ..$ id         : chr "altitud"
#>   ..$ descripcion: chr "altitud de la estación en m sobre el nivel del mar"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "m"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 5
#>   ..$ id         : chr "tmed"
#>   ..$ descripcion: chr "Temperatura media diaria"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "°C"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "prec"
#>   ..$ descripcion: chr "Precipitación diaria de 07 a 07"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "mm (Ip = inferior a 0,1 mm) (Acum = Precipitación acumulada)"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "tmin"
#>   ..$ descripcion: chr "Temperatura Mínima del día"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "°C"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horatmin"
#>   ..$ descripcion: chr "Hora y minuto de la temperatura mínima"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "tmax"
#>   ..$ descripcion: chr "Temperatura Máxima del día"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "°C"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horatmax"
#>   ..$ descripcion: chr "Hora y minuto de la temperatura máxima"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "dir"
#>   ..$ descripcion: chr "Dirección de la racha máxima"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "decenas de grado (99 = dirección variable)(88 = sin dato)"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "velmedia"
#>   ..$ descripcion: chr "Velocidad media del viento"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "m/s"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "racha"
#>   ..$ descripcion: chr "Racha máxima del viento"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "m/s"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horaracha"
#>   ..$ descripcion: chr "Hora y minuto de la racha máxima"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "sol"
#>   ..$ descripcion: chr "Insolación"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "horas"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "presmax"
#>   ..$ descripcion: chr "Presión máxima al nivel de referencia de la estación"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "hPa"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horapresmax"
#>   ..$ descripcion: chr "Hora de la presión máxima (redondeada a la hora entera más próxima)"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "presmin"
#>   ..$ descripcion: chr "Presión mínima al nivel de referencia de la estación"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "hPa"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horapresmin"
#>   ..$ descripcion: chr "Hora de la presión mínima (redondeada a la hora entera más próxima)"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "hrmedia"
#>   ..$ descripcion: chr "Humedad relativa media diaria"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "%"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "hrmax"
#>   ..$ descripcion: chr "Humedad relativa máxima diaria"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "%"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horahrmax"
#>   ..$ descripcion: chr "Hora de la humedad relativa máxima diaria"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "hrmin"
#>   ..$ descripcion: chr "Humedad relativa mínima diaria"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "%"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horahrmin"
#>   ..$ descripcion: chr "Hora de la humedad relativa mínima diaria"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "pintmax"
#>   ..$ descripcion: chr "Intensidad máxima de precipitación"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "mm/h (-0,3 = precipitación inapreciable < 0,1 mm/h)"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horapintmax"
#>   ..$ descripcion: chr "Hora de la intensidad máxima de precipitación"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
```
