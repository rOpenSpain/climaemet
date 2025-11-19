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
glimpse(obs)
#> Rows: 26
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2025-11-19 00:00:00, 2025-11-19 01:00:00, 2025-11-19 02:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 6.6, 6.9, 6.4, 8.4, 2.1, 2.0, 1.1, 2.2, 2.2, 1.9, 7.9, 7.6, …
#> $ vv        <dbl> 5.1, 4.8, 4.6, 1.5, 1.2, 1.0, 0.9, 0.6, 1.5, 0.4, 5.5, 4.5, …
#> $ dv        <dbl> 276, 273, 273, 345, 6, 253, 299, 246, 313, 52, 273, 307, 316…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 280, 280, 275, 235, 3, 350, 295, 348, 313, 355, 270, 288, 31…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.8, 988.5, 988.3, 987.9, 987.4, 987.3, 987.1, 987.1, 986.…
#> $ hr        <dbl> 67, 68, 68, 74, 82, 83, 84, 83, 79, 74, 56, 50, 50, NA, NA, …
#> $ stdvv     <dbl> 0.5, 0.4, 0.4, 0.3, 0.3, 0.1, 0.1, 0.2, 0.3, 0.2, 0.6, 0.7, …
#> $ ts        <dbl> 5.2, 4.9, 4.7, 3.0, 1.2, 1.2, 0.6, 0.9, 2.7, 9.1, 10.8, 12.9…
#> $ pres_nmar <dbl> 1019.7, 1019.4, 1019.2, 1019.0, 1018.6, 1018.6, 1018.4, 1018…
#> $ tamin     <dbl> 5.5, 5.2, 5.1, 3.7, 2.4, 1.9, 1.6, 1.4, 1.6, 3.0, 5.8, 9.1, …
#> $ ta        <dbl> 5.6, 5.2, 5.2, 3.7, 2.4, 1.9, 1.6, 1.8, 3.0, 5.8, 9.1, 10.0,…
#> $ tamax     <dbl> 5.7, 5.6, 5.2, 5.5, 3.7, 2.4, 1.9, 1.9, 3.0, 5.8, 9.1, 10.0,…
#> $ tpr       <dbl> 0.0, -0.3, -0.3, -0.5, -0.3, -0.7, -0.7, -0.7, -0.3, 1.5, 0.…
#> $ stddv     <dbl> 5, 5, 5, 124, 18, 11, 13, 36, 14, 62, 9, 13, 10, NA, NA, NA,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 52.0, 60.0, 60.0, 60…
#> $ tss5cm    <dbl> 9.1, 8.8, 8.5, 8.3, 7.9, 7.5, 7.1, 6.8, 6.6, 6.8, 7.7, 8.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 12.1, 11.9, 11.7, 11.6, 11.4, 11.2, 11.0, 10.8, 10.6, 10.3, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 38, 32, …
```
