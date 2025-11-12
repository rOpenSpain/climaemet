# Daily/annual climatology values

Get climatology values for a station or for all the available stations.
Note that `aemet_daily_period()` and `aemet_daily_period_all()` are
shortcuts of `aemet_daily_clim()`.

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

  Character string with station identifier code(s) (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md))
  or "all" for all the stations.

- start, end:

  Character string with start and end date. See **Details**.

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

- return_sf:

  Logical `TRUE` or `FALSE`. Should the function return an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object? If `FALSE` (the default value) it returns a
  [`tibble`](https://tibble.tidyverse.org/reference/tibble.html). Note
  that you need to have the [sf](https://CRAN.R-project.org/package=sf)
  package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with
  the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical, display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE` won't be displayed.

## Value

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object.

## Details

`start` and `end` parameters should be:

- For `aemet_daily_clim()`: A `Date` object or a string with format:
  `YYYY-MM-DD` (`"2020-12-31"`) coercible with
  [`as.Date()`](https://rdrr.io/r/base/as.Date.html).

- For `aemet_daily_period()` and `aemet_daily_period_all()`: A string
  representing the year(s) to be extracted: `"2020"`, `"2018"`.

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md),
[`as.Date()`](https://rdrr.io/r/base/as.Date.html)

Other aemet_api_data:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md),
[`aemet_monthly`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md),
[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)

## Examples

``` r
library(tibble)
obs <- aemet_daily_clim(c("9434", "3195"))
glimpse(obs)
#> Rows: 8
#> Columns: 25
#> $ fecha       <date> 2025-11-05, 2025-11-06, 2025-11-07, 2025-11-08, 2025-11-0…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 15.0, 14.6, 13.1, 13.2, NA, NA, NA, NA
#> $ prec        <dbl> 12.4, 0.0, 0.8, 0.0, 10.0, 0.0, 5.5, 0.0
#> $ tmin        <dbl> 11.7, 11.6, 8.5, 10.6, NA, NA, NA, NA
#> $ horatmin    <chr> "Varias", "23:59", "06:00", "07:00", NA, NA, NA, NA
#> $ tmax        <dbl> 18.4, 17.5, 17.7, 15.8, NA, NA, NA, NA
#> $ horatmax    <time> 16:10:00, 13:10:00, 15:10:00, 14:20:00,       NA,       NA…
#> $ dir         <chr> "12", "28", "22", "31", "35", "04", "35", "10"
#> $ velmedia    <dbl> 4.4, 6.4, 1.7, 8.6, 2.2, 2.8, 1.9, 1.4
#> $ racha       <dbl> 12.8, 17.2, 8.9, 17.5, 10.0, 9.4, 7.5, 9.2
#> $ horaracha   <time> 17:30:00, 12:10:00, 03:20:00, 13:20:00, 22:30:00, 02:10:00…
#> $ sol         <dbl> 0.2, 4.3, 3.6, 5.2, NA, NA, NA, NA
#> $ presMax     <dbl> 990.0, 983.2, 984.6, 990.7, 941.5, 939.0, 938.8, 944.6
#> $ horaPresMax <chr> "00", "Varias", "10", "22", "00", "21", "Varias", "Varias"
#> $ presMin     <dbl> 980.4, 978.8, 981.3, 981.9, 931.3, 934.4, 935.9, 936.5
#> $ horaPresMin <chr> "24", "Varias", "17", "02", "18", "00", "18", "03"
#> $ hrMedia     <dbl> 88, 66, 70, 69, NA, NA, NA, NA
#> $ hrMax       <dbl> 95, 95, 91, 95, NA, NA, NA, NA
#> $ horaHrMax   <chr> "Varias", "00:00", "23:59", "01:00", NA, NA, NA, NA
#> $ hrMin       <dbl> 74, 51, 57, 57, NA, NA, NA, NA
#> $ horaHrMin   <chr> "16:50", "Varias", "Varias", "13:30", NA, NA, NA, NA

# Metadata
meta <- aemet_daily_clim(c("9434", "3195"), extract_metadata = TRUE)

glimpse(meta$campos)
#> Rows: 25
#> Columns: 5
#> $ id          <chr> "fecha", "indicativo", "nombre", "provincia", "altitud", "…
#> $ descripcion <chr> "fecha del dia (AAAA-MM-DD)", "indicativo climatológico", …
#> $ tipo_datos  <chr> "string", "string", "string", "string", "float", "float", …
#> $ requerido   <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, …
#> $ unidad      <chr> NA, NA, NA, NA, "m", "°C", "mm (Ip = inferior a 0,1 mm) (A…
```
