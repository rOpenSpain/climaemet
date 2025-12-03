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
#> HTTP 429: Límite de peticiones o caudal por minuto excedido para este usuario. Espere al siguiente minuto. Retrying...
#> Waiting 4s for retry backoff ■■■■■■■■■■                      
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 7s for retry backoff ■■■■■                           
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■                   
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 8s for retry backoff ■■■■■■■                         
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■            
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
glimpse(obs)
#> Rows: 8
#> Columns: 25
#> $ fecha       <date> 2025-11-26, 2025-11-27, 2025-11-28, 2025-11-29, 2025-11-2…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 8.0, 10.8, 10.3, 7.4, NA, NA, NA, NA
#> $ prec        <dbl> 0.0, 0.0, 0.0, 0.8, 0.0, 0.0, 0.0, 3.3
#> $ tmin        <dbl> 5.0, 6.0, 5.5, 1.9, NA, NA, NA, NA
#> $ horatmin    <time> 07:20:00, 03:40:00, 23:59:00, 06:50:00,       NA,       NA…
#> $ tmax        <dbl> 11.1, 15.5, 15.1, 12.9, NA, NA, NA, NA
#> $ horatmax    <time> 14:20:00, 14:10:00, 14:50:00, 14:30:00,       NA,       NA…
#> $ dir         <chr> "31", "32", "24", "24", "11", "06", "03", "03"
#> $ velmedia    <dbl> 8.9, 7.8, 4.2, 1.7, 1.1, 0.3, 0.8, 1.1
#> $ racha       <dbl> 15.8, 16.9, 10.0, 5.0, 7.2, 3.6, 5.0, 6.7
#> $ horaracha   <time> 12:10:00, 10:30:00, 03:10:00, 17:50:00, 15:40:00, 13:10:00…
#> $ sol         <dbl> 9.0, 9.1, 8.6, 7.5, NA, NA, NA, NA
#> $ presMax     <dbl> 993.1, 992.4, 991.8, 989.5, 946.4, 945.8, 944.8, 941.9
#> $ horaPresMax <chr> "10", "00", "00", "00", "10", "02", "10", "00"
#> $ presMin     <dbl> 989.6, 990.0, 989.0, 982.7, 943.1, 943.1, 941.5, 936.2
#> $ horaPresMin <chr> "Varias", "14", "15", "22", "00", "15", "16", "24"
#> $ hrMedia     <dbl> 68, 65, 71, 78, NA, NA, NA, NA
#> $ hrMax       <dbl> 89, 81, 88, 95, NA, NA, NA, NA
#> $ horaHrMax   <chr> "02:30", "23:10", "Varias", "07:30", NA, NA, NA, NA
#> $ hrMin       <dbl> 49, 50, 53, 59, NA, NA, NA, NA
#> $ horaHrMin   <chr> "14:00", "13:30", "Varias", "14:30", NA, NA, NA, NA

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
