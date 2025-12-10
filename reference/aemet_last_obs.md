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
#> Rows: 24
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2025-12-10 01:00:00, 2025-12-10 02:00:00, 2025-12-10 03:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.2, 0.0, 0.4, 0.0, 0.2, 0.6, 0.8, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.6, 2.9, 4.1, 3.5, 4.1, 3.4, 2.3, 1.4, 3.6, 2.2, 3.1, 2.2, …
#> $ vv        <dbl> 1.9, 1.9, 3.0, 2.2, 2.9, 2.3, 0.7, 0.9, 0.4, 1.2, 1.6, 0.7, …
#> $ dv        <dbl> 112, 116, 111, 90, 122, 127, 99, 41, 128, 308, 289, 287, 320…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 113, 103, 110, 105, 123, 100, 135, 28, 128, 308, 320, 203, 3…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 990.1, 990.0, 989.9, 989.8, 990.4, 990.8, 991.0, 991.7, 992.…
#> $ hr        <dbl> 86, 88, 88, 91, 93, 94, 96, 97, 96, 95, 93, 89, NA, NA, NA, …
#> $ stdvv     <dbl> 0.3, 0.2, 0.3, 0.4, 0.5, 0.2, 0.2, 0.2, 0.2, 0.3, 0.2, 0.2, …
#> $ ts        <dbl> 9.3, 9.0, 8.7, 8.5, 8.5, 8.4, 8.3, 8.4, 9.3, 10.7, 12.3, 12.…
#> $ pres_nmar <dbl> 1020.6, 1020.6, 1020.5, 1020.4, 1021.0, 1021.5, 1021.7, 1022…
#> $ tamin     <dbl> 9.6, 9.2, 9.0, 8.6, 8.5, 8.4, 8.4, 8.3, 8.3, 8.9, 9.8, 10.7,…
#> $ ta        <dbl> 9.6, 9.2, 9.0, 8.6, 8.6, 8.4, 8.4, 8.4, 8.9, 9.8, 10.7, 11.3…
#> $ tamax     <dbl> 9.8, 9.6, 9.2, 9.0, 8.6, 8.6, 8.6, 8.4, 9.0, 9.8, 10.7, 11.3…
#> $ tpr       <dbl> 7.4, 7.3, 7.1, 7.3, 7.6, 7.4, 7.8, 8.0, 8.3, 9.0, 9.6, 9.6, …
#> $ stddv     <dbl> 45, 20, 7, 13, 8, 7, 24, 20, 39, 16, 23, 57, NA, NA, NA, NA,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 8.4, 0.0, …
#> $ tss5cm    <dbl> 9.5, 9.5, 9.5, 9.4, 9.3, 9.3, 9.3, 9.2, 9.3, 9.6, 10.4, 11.0…
#> $ pacutp    <dbl> 0.04, 0.00, 0.25, 0.04, 0.36, 0.06, 0.05, 0.61, 0.57, 0.03, …
#> $ tss20cm   <dbl> 10.3, 10.3, 10.3, 10.2, 10.2, 10.2, 10.2, 10.1, 10.1, 10.1, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 28, 34, 33, …
```
