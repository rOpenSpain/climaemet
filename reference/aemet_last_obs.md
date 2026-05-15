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
  object? If `FALSE` (the default value), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  Note that you need to have the
  [sf](https://CRAN.R-project.org/package=sf) package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical. Display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE`, it will not be displayed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## API key

You need to set your API key globally using
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
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying...
#> Waiting 3s for retry backoff ■■■■■■■■■■■                     
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> 
glimpse(obs)
#> Rows: 26
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-05-14 18:00:00, 2026-05-14 19:00:00, 2026-05-14 20:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 8.6, 8.7, 10.9, 10.5, 9.5, 6.7, 6.3, 3.6, 3.8, 6.5, 10.4, 8.…
#> $ vv        <dbl> 4.3, 4.3, 6.4, 6.2, 5.2, 4.2, 2.7, 1.7, 2.8, 4.7, 6.3, 5.9, …
#> $ dv        <dbl> 344, 334, 325, 326, 300, 302, 257, 234, 297, 306, 316, 318, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 340, 345, 315, 355, 313, 308, 290, 260, 295, 310, 305, 310, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 977.9, 978.2, 978.3, 979.1, 978.6, 978.3, 977.7, 976.9, 976.…
#> $ hr        <dbl> 49, 53, 51, 65, 70, 71, 73, 78, 75, 69, 68, 71, 72, 34, 36, …
#> $ stdvv     <dbl> 1.1, 0.9, 1.5, 1.3, 0.8, 0.6, 0.3, 0.3, 0.3, 0.7, 1.4, 1.0, …
#> $ ts        <dbl> 16.9, 15.2, 14.5, 12.2, 12.8, 12.5, 11.8, 10.1, 11.1, 11.4, …
#> $ pres_nmar <dbl> 1007.4, 1007.8, 1008.0, 1009.0, 1008.5, 1008.2, 1007.6, 1006…
#> $ tamin     <dbl> 15.9, 14.8, 14.0, 12.2, 11.9, 11.7, 11.7, 11.0, 10.9, 11.3, …
#> $ ta        <dbl> 15.9, 14.8, 14.0, 12.2, 12.0, 11.7, 11.7, 11.0, 11.3, 11.6, …
#> $ tamax     <dbl> 17.1, 15.9, 14.8, 14.0, 12.2, 12.0, 12.0, 11.7, 11.3, 11.7, …
#> $ tpr       <dbl> 5.1, 5.3, 3.9, 5.8, 6.7, 6.5, 7.0, 7.3, 7.0, 6.1, 5.8, 6.2, …
#> $ stddv     <dbl> 17, 13, 13, 10, 7, 11, 7, 14, 7, 8, 10, 10, 10, NA, NA, NA, …
#> $ inso      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss5cm    <dbl> 21.4, 20.7, 20.0, 19.4, 18.8, 18.4, 18.0, 17.7, 17.3, 17.0, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.06, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 20.0, 20.1, 20.1, 20.0, 19.9, 19.7, 19.6, 19.4, 19.2, 19.0, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 159, 149…
```
