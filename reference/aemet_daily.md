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
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  A logical value. If `TRUE`, displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  unless `verbose = TRUE`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
an [`sf`](https://r-spatial.github.io/sf/reference/sf.html) object.

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
#> $ fecha       <date> 2026-10-02, 2026-10-03, 2026-10-04, 2026-10-05, 2026-10-0…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 20.3, 22.3, 22.0, 23.3, 21.8, 20.8, 18.8, 19.6, 19.4, 17.8
#> $ prec        <dbl> 0.0, 0.0, 0.0, 0.2, 22.0, 3.4, 0.2, 0.7, 5.2, 9.1
#> $ tmin        <dbl> 16.9, 18.7, 17.0, 18.7, 18.0, 17.5, 17.0, 16.0, 14.9, 15.0
#> $ horatmin    <chr> "06:10", "03:30", "06:30", "02:30", "Varias", "06:00", "08…
#> $ tmax        <dbl> 23.7, 25.9, 27.0, 27.9, 25.5, 24.0, 20.7, 23.3, 24.0, 20.6
#> $ horatmax    <chr> "16:00", "Varias", "15:00", "14:20", "13:50", "14:30", "15…
#> $ dir         <chr> "11", "99", "12", "11", "14", "16", "05", "22", "17", "32"
#> $ velmedia    <dbl> 3.6, 3.3, 1.7, 2.8, 3.1, 2.5, 1.4, 1.9, 1.9, 1.9
#> $ racha       <dbl> 8.9, 8.9, 6.9, 6.7, 7.2, 9.2, 5.8, 11.7, 9.7, 9.4
#> $ horaracha   <chr> "15:50", "Varias", "13:10", "14:30", "19:40", "16:10", "08…
#> $ sol         <dbl> 1.3, 4.2, 7.6, 8.9, 3.9, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 997.0, 994.6, 992.5, 991.5, 988.5, 948.3, 947.1, 945.2, 94…
#> $ horaPresMax <chr> "09", "00", "00", "09", "Varias", "10", "00", "09", "Varia…
#> $ presMin     <dbl> 993.6, 991.2, 988.9, 987.6, 983.0, 944.9, 944.2, 942.7, 94…
#> $ horaPresMin <dbl> 15, 15, 16, 17, 17, 16, 16, 17, 16, 17
#> $ hrMedia     <dbl> 75, 68, 63, 61, 75, 75, 84, 74, 71, 87
#> $ hrMax       <dbl> 88, 89, 88, 86, 97, 85, 93, 92, 93, 96
#> $ horaHrMax   <chr> "22:30", "Varias", "06:20", "02:10", "09:00", "07:00", "Va…
#> $ hrMin       <dbl> 66, 53, 44, 44, 58, 60, 74, 55, 54, 70
#> $ horaHrMin   <time> 16:00:00, 14:00:00, 14:50:00, 17:50:00, 14:30:00, 15:40:00…
#> $ pintMax     <dbl> 0.0, 0.0, 0.0, 0.0, 28.8, 0.6, 8.4, 3.6, 6.0, 31.2
#> $ horaPIntMax <time>       NA,       NA,       NA,       NA, 23:45:00, 05:04:00…

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
