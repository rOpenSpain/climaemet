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
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying...
#> Waiting 4s for retry backoff ■■■■■■■■■■                      
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 7s for retry backoff ■■■■■■■■                        
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 8s for retry backoff ■■■■■                           
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■    
#> Waiting 8s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 27s for retry backoff ■■■                             
#> Waiting 27s for retry backoff ■■■■■■■                         
#> Waiting 27s for retry backoff ■■■■■■■■■■                      
#> Waiting 27s for retry backoff ■■■■■■■■■■■■■                   
#> Waiting 27s for retry backoff ■■■■■■■■■■■■■■■■■               
#> Waiting 27s for retry backoff ■■■■■■■■■■■■■■■■■■■■            
#> Waiting 27s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■        
#> Waiting 27s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 27s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 27s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> 
glimpse(obs)
#> Rows: 10
#> Columns: 25
#> $ fecha       <date> 2025-12-08, 2025-12-09, 2025-12-10, 2025-12-11, 2025-12-1…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 9.7, 9.9, 10.8, 9.4, 9.2, NA, NA, NA, NA, NA
#> $ prec        <dbl> 0.0, 0.8, 1.4, 0.0, 0.0, 0.0, 7.9, 3.5, 0.0, 0.2
#> $ tmin        <dbl> 4.3, 4.5, 8.3, 8.0, 7.3, NA, NA, NA, NA, NA
#> $ horatmin    <chr> "Varias", "05:30", "07:10", "22:40", "05:30", NA, NA, NA, …
#> $ tmax        <dbl> 15.1, 15.3, 13.4, 10.9, 11.2, NA, NA, NA, NA, NA
#> $ horatmax    <time> 14:10:00, 14:40:00, 22:20:00, 00:00:00, 15:00:00,       NA…
#> $ dir         <dbl> 12, 11, 22, 12, 14, 21, 99, 36, 24, 99
#> $ velmedia    <dbl> 1.9, 2.8, 1.7, 3.1, 2.8, 0.6, 1.1, 1.1, 1.1, 1.9
#> $ racha       <dbl> 5.6, 7.8, 8.3, 7.8, 6.1, 4.7, 3.3, 4.7, 5.3, 6.1
#> $ horaracha   <chr> "13:30", "09:40", "19:40", "16:10", "07:20", "15:20", "Var…
#> $ sol         <dbl> 8.5, 7.5, 0.1, 0.0, 2.2, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 993.1, 991.5, 995.2, 995.0, 994.0, 945.6, 944.5, 945.6, 94…
#> $ horaPresMax <chr> "09", "Varias", "23", "10", "Varias", "09", "Varias", "23"…
#> $ presMin     <dbl> 989.8, 989.0, 989.2, 990.4, 989.3, 943.1, 942.6, 942.4, 94…
#> $ horaPresMin <chr> "Varias", "16", "Varias", "16", "07", "14", "14", "05", "…
#> $ hrMedia     <dbl> 78, 75, 95, 92, 92, NA, NA, NA, NA, NA
#> $ hrMax       <dbl> 95, 95, 98, 99, 100, NA, NA, NA, NA, NA
#> $ horaHrMax   <time> 06:30:00, 05:50:00, 08:20:00, 08:30:00, 05:30:00,       NA…
#> $ hrMin       <dbl> 58, 58, 82, 88, 82, NA, NA, NA, NA, NA
#> $ horaHrMin   <time> 14:10:00, 15:00:00, 00:00:00, 12:00:00, 14:50:00,       NA…

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
