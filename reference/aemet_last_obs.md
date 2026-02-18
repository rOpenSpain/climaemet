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
#> Rows: 26
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-02-17 18:00:00, 2026-02-17 19:00:00, 2026-02-17 20:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.5, 4.4, 6.1, 6.3, 4.1, 2.5, 0.9, 1.9, 3.3, 2.6, 3.5, 3.9, …
#> $ vv        <dbl> 3.5, 3.2, 3.6, 3.2, 1.4, 0.8, 0.3, 0.7, 1.8, 1.0, 2.2, 1.4, …
#> $ dv        <dbl> 279, 255, 242, 242, 70, 208, 108, 158, 68, 56, 283, 238, 111…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 308, 258, 235, 218, 233, 320, 223, 118, 88, 85, 263, 283, 12…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 991.0, 991.0, 990.5, 990.5, 990.3, 989.9, 989.5, 988.9, 988.…
#> $ hr        <dbl> 79, 85, 87, 88, 89, 92, 93, 95, 98, 97, 95, 99, 100, 77, 81,…
#> $ stdvv     <dbl> 0.2, 0.2, 0.7, 0.2, 0.3, 0.2, 0.2, 0.3, 0.5, 0.2, 0.3, 0.6, …
#> $ ts        <dbl> 12.2, 11.1, 10.2, 10.2, 8.9, 8.2, 6.6, 6.7, 6.5, 5.9, 5.4, 4…
#> $ pres_nmar <dbl> 1021.1, 1021.3, 1020.9, 1020.9, 1020.8, 1020.4, 1020.2, 1019…
#> $ tamin     <dbl> 13.3, 12.0, 10.9, 10.8, 9.9, 9.2, 8.2, 7.6, 7.2, 6.7, 6.0, 4…
#> $ ta        <dbl> 13.3, 12.0, 10.9, 10.9, 9.9, 9.2, 8.2, 7.6, 7.2, 6.7, 6.0, 4…
#> $ tamax     <dbl> 14.9, 13.3, 12.0, 11.0, 10.9, 9.9, 9.2, 8.2, 7.6, 7.2, 6.8, …
#> $ tpr       <dbl> 9.7, 9.6, 8.8, 9.0, 8.1, 8.0, 7.1, 6.8, 6.8, 6.2, 5.3, 4.8, …
#> $ stddv     <dbl> 5, 6, 9, 5, 12, 22, 37, 52, 15, 25, 9, 61, 8, NA, NA, NA, NA…
#> $ inso      <dbl> 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss5cm    <dbl> 12.9, 12.4, 11.8, 11.4, 11.1, 10.6, 10.2, 9.8, 9.4, 9.1, 8.7…
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 11.9, 12.0, 12.0, 12.0, 11.9, 11.8, 11.6, 11.5, 11.3, 11.1, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 88, 73, …
```
