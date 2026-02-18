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
glimpse(obs)
#> Rows: 20
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-02-18 02:00:00, 2026-02-18 03:00:00, 2026-02-18 04:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 667, 667, …
#> $ vmax      <dbl> 3.3, 2.6, 3.5, 3.9, 4.3, 4.9, 3.8, 4.8, 5.1, 8.8, 2.4, 2.6, …
#> $ vv        <dbl> 1.8, 1.0, 2.2, 1.4, 3.0, 2.9, 2.5, 2.9, 3.2, 4.5, 1.1, 1.1, …
#> $ dv        <dbl> 68, 56, 283, 238, 111, 118, 92, 100, 100, 245, 211, 202, 224…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 88, 85, 263, 283, 120, 133, 93, 88, 113, 230, 282, 211, 221,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.5, 988.2, 987.5, 987.1, 986.7, 986.4, 986.3, 986.2, 985.…
#> $ hr        <dbl> 98, 97, 95, 99, 100, 97, 95, 93, 93, 63, 96, 97, 97, 97, 93,…
#> $ stdvv     <dbl> 0.5, 0.2, 0.3, 0.6, 0.6, 0.4, 0.5, 0.6, 1.1, 1.4, NA, NA, NA…
#> $ ts        <dbl> 6.5, 5.9, 5.4, 4.6, 5.3, 6.0, 6.8, 7.7, 9.4, 15.5, NA, NA, N…
#> $ pres_nmar <dbl> 1019.2, 1019.0, 1018.3, 1018.0, 1017.4, 1017.2, 1017.0, 1016…
#> $ tamin     <dbl> 7.2, 6.7, 6.0, 4.8, 5.0, 5.8, 6.4, 6.8, 7.3, 8.7, 7.5, 7.4, …
#> $ ta        <dbl> 7.2, 6.7, 6.0, 4.9, 5.8, 6.4, 6.8, 7.3, 8.7, 14.3, 7.6, 8.0,…
#> $ tamax     <dbl> 7.6, 7.2, 6.8, 6.0, 5.8, 6.4, 6.9, 7.5, 8.7, 14.3, 8.2, 8.0,…
#> $ tpr       <dbl> 6.8, 6.2, 5.3, 4.8, 5.8, 5.9, 6.1, 6.2, 7.6, 7.3, 7.0, 7.6, …
#> $ stddv     <dbl> 15, 25, 9, 61, 8, 7, 8, 9, 37, 33, NA, NA, NA, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 9.3, 40.4, 0.0, 34.1, NA, NA, …
#> $ tss5cm    <dbl> 9.4, 9.1, 8.7, 8.5, 8.2, 8.0, 7.9, 8.3, 8.8, 9.5, NA, NA, NA…
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.01, 0.00, 0.00, …
#> $ tss20cm   <dbl> 11.3, 11.1, 10.9, 10.7, 10.5, 10.3, 10.2, 10.0, 9.9, 9.8, NA…
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 32, 38, 44, 62, 95, …
```
