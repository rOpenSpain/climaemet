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
a [sf](https://CRAN.R-project.org/package=sf) object

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
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying...
#> 
glimpse(obs)
#> Rows: 26
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-03-24 09:00:00, 2026-03-24 10:00:00, 2026-03-24 11:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 1.5, 2.7, 2.8, 3.7, 3.6, 4.0, 4.5, 4.6, 4.7, 3.9, 3.6, 2.6, …
#> $ vv        <dbl> 0.5, 1.3, 1.0, 2.2, 2.0, 1.4, 2.5, 2.2, 2.8, 2.6, 1.6, 1.3, …
#> $ dv        <dbl> 294, 312, 165, 86, 81, 145, 83, 72, 114, 138, 175, 290, 244,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 290, 313, 308, 80, 95, 78, 83, 83, 93, 138, 140, 198, 235, 3…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 994.7, 994.5, 994.1, 993.3, 992.2, 991.4, 990.7, 990.3, 990.…
#> $ hr        <dbl> 67, 58, 50, 49, 45, 41, 40, 38, 39, 41, 45, 52, 59, 64, 57, …
#> $ stdvv     <dbl> 0.3, 0.4, 0.4, 0.6, 0.6, 0.4, 0.6, 0.5, 0.4, 0.4, 0.3, 0.1, …
#> $ ts        <dbl> 14.0, 17.0, 20.0, 20.8, 22.1, 23.0, 23.2, 22.3, 19.9, 16.5, …
#> $ pres_nmar <dbl> 1025.4, 1024.9, 1024.2, 1023.2, 1021.9, 1021.0, 1020.2, 1019…
#> $ tamin     <dbl> 7.0, 9.9, 12.1, 14.8, 15.9, 17.5, 18.9, 19.6, 19.4, 18.2, 16…
#> $ ta        <dbl> 9.9, 12.1, 14.9, 15.9, 17.6, 19.0, 19.6, 19.8, 19.4, 18.2, 1…
#> $ tamax     <dbl> 9.9, 12.2, 14.9, 16.0, 17.6, 19.1, 19.7, 19.9, 20.0, 19.4, 1…
#> $ tpr       <dbl> 4.1, 4.1, 4.6, 5.1, 5.5, 5.5, 5.6, 5.1, 5.1, 4.6, 4.8, 5.0, …
#> $ stddv     <dbl> 76, 31, 118, 17, 25, 80, 28, 23, 9, 9, 14, 7, 19, NA, NA, NA…
#> $ inso      <dbl> 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 58.8, …
#> $ tss5cm    <dbl> 11.0, 12.3, 14.0, 15.8, 17.5, 18.8, 19.5, 19.8, 19.5, 18.5, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.21, 0.00, 0.01, …
#> $ tss20cm   <dbl> 12.7, 12.6, 12.6, 12.7, 13.0, 13.4, 13.8, 14.3, 14.7, 15.1, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 62, 80, …
```
