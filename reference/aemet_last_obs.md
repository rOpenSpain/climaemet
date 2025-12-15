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
#> $ fint      <dttm> 2025-12-15 04:00:00, 2025-12-15 05:00:00, 2025-12-15 06:00:…
#> $ prec      <dbl> 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.0, 2.3, 1.6, 3.1, 2.4, 1.9, 2.0, 2.4, 2.5, 1.8, 2.8, 1.9, …
#> $ vv        <dbl> 1.3, 0.6, 1.1, 1.1, 1.1, 1.0, 1.4, 1.1, 1.6, 0.9, 1.3, 1.0, …
#> $ dv        <dbl> 83, 76, 115, 106, 90, 53, 87, 37, 108, 358, 303, 47, 4, 16, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 188, 128, 95, 118, 93, 98, 75, 95, 113, 350, 305, 318, 12, 3…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.0, 987.0, 986.6, 986.5, 986.4, 985.9, 985.8, 985.1, 984.…
#> $ hr        <dbl> 99, 100, 100, 100, 100, 100, 100, 100, 100, 100, 99, 99, NA,…
#> $ stdvv     <dbl> 0.2, 0.1, 0.1, 0.2, 0.2, 0.3, 0.2, 0.3, 0.3, 0.3, 0.2, 0.3, …
#> $ ts        <dbl> 7.2, 7.2, 7.3, 7.5, 7.7, 8.2, 8.6, 9.1, 9.5, 10.0, 10.3, 10.…
#> $ pres_nmar <dbl> 1018.7, 1017.7, 1017.3, 1017.1, 1017.0, 1016.5, 1016.3, 1015…
#> $ tamin     <dbl> 6.8, 7.0, 7.1, 7.1, 7.4, 7.5, 7.8, 8.2, 8.7, 9.0, 9.3, 9.7, …
#> $ ta        <dbl> 7.1, 7.1, 7.1, 7.4, 7.6, 7.8, 8.2, 8.7, 9.0, 9.3, 9.7, 10.1,…
#> $ tamax     <dbl> 7.1, 7.1, 7.1, 7.4, 7.6, 7.8, 8.2, 8.8, 9.0, 9.3, 9.7, 10.1,…
#> $ tpr       <dbl> 7.0, 7.1, 7.1, 7.4, 7.6, 7.8, 8.3, 8.7, 9.0, 9.3, 9.6, 9.9, …
#> $ stddv     <dbl> 8, 17, 9, 11, 11, 18, 14, 24, 12, 20, 8, 20, NA, NA, NA, NA,…
#> $ inso      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss5cm    <dbl> 8.0, 8.0, 8.1, 8.1, 8.2, 8.2, 8.5, 8.8, 9.0, 9.3, 9.5, 9.7, …
#> $ pacutp    <dbl> 0.07, 0.01, 0.00, 0.00, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 9.1, 9.1, 9.1, 9.1, 9.1, 9.1, 9.1, 9.1, 9.2, 9.2, 9.3, 9.4, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 66, 70, 54, …
```
