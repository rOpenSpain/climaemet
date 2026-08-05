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
#> Rows: 8
#> Columns: 26
#> $ fecha       <date> 2026-07-29, 2026-07-30, 2026-07-31, 2026-08-01, 2026-07-2…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 32.6, 32.3, 29.2, 29.3, 31.3, 30.8, 30.6, 30.1
#> $ prec        <dbl> 0, 0, 0, 0, 0, 0, 0, 0
#> $ tmin        <dbl> 24.7, 23.7, 22.9, 21.3, 24.8, 23.6, 24.5, 22.6
#> $ horatmin    <chr> "05:10", "05:30", "06:10", "Varias", "05:50", "06:40", "06…
#> $ tmax        <dbl> 40.4, 40.9, 35.6, 37.3, 37.8, 37.9, 36.6, 37.6
#> $ horatmax    <time> 16:00:00, 16:00:00, 15:30:00, 17:00:00, 14:50:00, 15:00:00…
#> $ dir         <dbl> 12, 12, 31, 30, 26, 21, 22, 23
#> $ velmedia    <dbl> 4.7, 3.6, 5.6, 3.3, 2.5, 2.8, 3.9, 3.1
#> $ racha       <dbl> 11.1, 10.0, 13.6, 11.1, 8.9, 8.6, 12.2, 12.8
#> $ horaracha   <time> 17:40:00, 17:50:00, 18:50:00, 01:40:00, 16:10:00, 15:20:00…
#> $ sol         <dbl> 13.0, 13.2, 11.8, 13.3, NA, NA, NA, NA
#> $ presMax     <dbl> 989.1, 988.6, 987.8, 987.6, 943.9, 943.8, 942.1, 940.3
#> $ horaPresMax <chr> "Varias", "07", "08", "06", "10", "08", "09", "08"
#> $ presMin     <dbl> 984.1, 982.4, 983.3, 980.6, 940.8, 939.9, 938.7, 936.0
#> $ horaPresMin <chr> "18", "18", "18", "18", "18", "Varias", "18", "18"
#> $ hrMedia     <dbl> 37, 34, 47, 40, 28, 32, 20, 23
#> $ hrMax       <dbl> 62, 61, 73, 66, 43, 58, 39, 40
#> $ horaHrMax   <chr> "Varias", "05:30", "06:40", "06:10", "07:10", "06:20", "06…
#> $ hrMin       <dbl> 18, 17, 31, 19, 20, 13, 9, 14
#> $ horaHrMin   <chr> "16:40", "15:30", "15:20", "15:50", "Varias", "14:20", "16…
#> $ pintMax     <dbl> 0, 0, 0, 0, 0, 0, 0, 0

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
