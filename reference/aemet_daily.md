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
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  Note that you need to have the
  [sf](https://CRAN.R-project.org/package=sf) package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical, display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE` won't be displayed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## Details

`start` and `end` arguments should be:

- For `aemet_daily_clim()`: A `Date` object or a string with format
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
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying...
#> Waiting 3s for retry backoff ■■■■■■■■■■■                     
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 16s for retry backoff ■■■                             
#> Waiting 16s for retry backoff ■■■■                            
#> Waiting 16s for retry backoff ■■■■■■■■■■                      
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> 
glimpse(obs)
#> Rows: 8
#> Columns: 25
#> $ fecha       <date> 2026-04-29, 2026-04-30, 2026-05-01, 2026-05-02, 2026-04-2…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 19.2, 19.8, 20.0, 17.5, 18.3, 16.8, 18.8, 16.6
#> $ prec        <chr> "8,8", "Ip", "0,0", "23,4", "0,5", "0,0", "1,9", "13,9"
#> $ tmin        <dbl> 15.2, 13.8, 15.5, 12.3, 13.8, 12.1, 12.1, 13.9
#> $ horatmin    <chr> "Varias", "Varias", "23:50", "18:40", "08:00", "05:00", "0…
#> $ tmax        <dbl> 23.1, 25.7, 24.5, 22.7, 22.8, 21.5, 25.5, 19.3
#> $ horatmax    <time> 15:20:00, 16:30:00, 13:50:00, 12:20:00, 15:50:00, 16:30:00…
#> $ dir         <chr> "10", "14", "12", "30", "08", "13", "35", "15"
#> $ velmedia    <dbl> 4.7, 1.9, 4.4, 5.3, 3.1, 1.1, 2.2, 1.4
#> $ racha       <dbl> 11.9, 8.3, 11.1, 15.3, 12.2, 5.3, 9.7, 12.2
#> $ horaracha   <time> 16:50:00, 23:59:00, 15:10:00, 18:10:00, 19:40:00, 09:50:00…
#> $ sol         <dbl> 4.5, 9.9, 2.7, 2.7, NA, NA, NA, NA
#> $ presMax     <dbl> 985.1, 988.1, 991.6, 991.4, 935.9, 939.9, 941.9, 941.7
#> $ horaPresMax <chr> "24", "24", "22", "00", "24", "24", "23", "00"
#> $ presMin     <dbl> 978.1, 983.8, 988.1, 984.3, 930.3, 935.9, 939.2, 936.6
#> $ horaPresMin <chr> "17", "02", "00", "18", "15", "00", "17", "19"
#> $ hrMedia     <dbl> 64, 53, 62, 69, 66, 55, 44, 89
#> $ hrMax       <dbl> 96, 97, 83, 99, 91, 87, 78, 98
#> $ horaHrMax   <time> 23:59:00, 00:40:00, 03:10:00, 19:10:00, 07:30:00, 05:20:00…
#> $ hrMin       <dbl> 51, 34, 47, 55, 42, 35, 27, 69
#> $ horaHrMin   <time> 16:00:00, 17:50:00, 14:40:00, 13:30:00, 16:10:00, 16:30:00…

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
