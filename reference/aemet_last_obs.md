# Last observation values for a station

Get last observation values for a station.

## Usage

``` r
aemet_last_obs(
  station = "all",
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
[sf](https://CRAN.R-project.org/package=sf) object

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

Other aemet_api_data:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_monthly`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md),
[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)

## Examples

``` r
library(tibble)
obs <- aemet_last_obs(c("9434", "3195"))
#> ! HTTP 500:
#>   Hit API Limits.
#> ℹ Retrying...
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■                      
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 9s for retry backoff ■■■■                            
#> Waiting 9s for retry backoff ■■■■■                           
#> Waiting 9s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 9s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■       
#> Waiting 9s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 23s for retry backoff ■■                              
#> Waiting 23s for retry backoff ■■■■■■                          
#> Waiting 23s for retry backoff ■■■■■■■■■■                      
#> Waiting 23s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 23s for retry backoff ■■■■■■■■■■■■■■■■■■              
#> Waiting 23s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■          
#> Waiting 23s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■      
#> Waiting 23s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 23s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> 
glimpse(obs)
#> Rows: 24
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2025-12-24 01:00:00, 2025-12-24 02:00:00, 2025-12-24 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.0, 4.4, 4.5, 4.0, 3.4, 5.9, 6.1, 5.0, 4.5, 9.2, 11.0, 11.1…
#> $ vv        <dbl> 3.4, 3.8, 3.8, 2.2, 0.9, 4.5, 3.5, 2.0, 2.7, 6.8, 6.1, 7.4, …
#> $ dv        <dbl> 269, 270, 268, 294, 302, 292, 285, 293, 303, 298, 302, 307, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 295, 275, 270, 295, 293, 295, 293, 278, 285, 300, 305, 298, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 979.1, 979.7, 979.8, 979.8, 979.7, 979.9, 980.3, 980.6, 980.…
#> $ hr        <dbl> 85, 87, 89, 90, 94, 93, 92, 95, 89, 77, 75, 71, 92, 98, 97, …
#> $ stdvv     <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.4, 0.3, 0.2, 1.0, 0.8, 1.2, …
#> $ ts        <dbl> 5.3, 4.5, 4.1, 3.2, 1.8, 3.9, 3.4, 3.0, 6.3, 9.5, 11.4, 11.9…
#> $ pres_nmar <dbl> 1009.7, 1010.4, 1010.6, 1010.6, 1010.5, 1010.7, 1011.1, 1011…
#> $ tamin     <dbl> 6.0, 5.3, 4.8, 3.9, 3.2, 3.4, 3.8, 3.2, 3.5, 5.0, 8.5, 9.9, …
#> $ ta        <dbl> 6.1, 5.3, 4.8, 3.9, 3.4, 4.6, 3.8, 3.5, 5.0, 8.5, 9.8, 10.6,…
#> $ tamax     <dbl> 7.3, 6.1, 5.3, 4.8, 3.9, 4.6, 4.8, 3.8, 5.0, 8.5, 9.8, 10.6,…
#> $ tpr       <dbl> 3.8, 3.2, 3.2, 2.5, 2.5, 3.6, 2.7, 2.9, 3.4, 4.6, 5.6, 5.6, …
#> $ stddv     <dbl> 5, 3, 3, 8, 14, 5, 4, 12, 6, 9, 9, 8, NA, NA, NA, NA, NA, NA…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 20.4, 55.9, 60.0, 60.0, 4…
#> $ tss5cm    <dbl> 6.6, 6.3, 6.0, 5.7, 5.4, 5.1, 5.0, 4.9, 4.9, 5.5, 6.4, 7.4, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 7.9, 7.8, 7.8, 7.7, 7.6, 7.5, 7.3, 7.2, 7.1, 7.0, 6.9, 7.0, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 74, 71, 39, …
```
