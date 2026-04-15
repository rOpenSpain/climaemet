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
a [sf](https://CRAN.R-project.org/package=sf) object.

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
#> Rows: 25
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-04-15 01:00:00, 2026-04-15 02:00:00, 2026-04-15 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 9.7, 9.2, 10.3, 9.4, 5.3, 5.8, 7.8, 8.0, 6.8, 8.6, 8.3, 10.2…
#> $ vv        <dbl> 6.4, 6.8, 7.0, 5.6, 3.0, 4.8, 4.9, 3.9, 4.2, 5.4, 4.4, 5.6, …
#> $ dv        <dbl> 296, 292, 295, 301, 290, 281, 304, 313, 306, 312, 316, 316, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 305, 293, 288, 305, 290, 283, 283, 328, 303, 303, 308, 323, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 990.8, 990.2, 989.9, 989.7, 990.0, 990.4, 990.7, 991.1, 991.…
#> $ hr        <dbl> 79, 79, 76, 75, 81, 76, 68, 64, 55, 49, 42, 37, 70, 70, 75, …
#> $ stdvv     <dbl> 0.8, 0.7, 0.8, 0.7, 0.4, 0.3, 0.9, 0.8, 0.8, 1.0, 0.8, 1.2, …
#> $ ts        <dbl> 13.0, 12.6, 12.7, 12.4, 10.1, 11.3, 15.0, 17.9, 21.4, 23.2, …
#> $ pres_nmar <dbl> 1020.9, 1020.3, 1020.0, 1019.8, 1020.3, 1020.6, 1020.7, 1021…
#> $ tamin     <dbl> 13.7, 13.3, 13.0, 13.2, 11.6, 11.6, 12.8, 14.5, 15.5, 17.8, …
#> $ ta        <dbl> 13.7, 13.4, 13.6, 13.2, 11.7, 12.8, 14.5, 15.6, 17.8, 19.8, …
#> $ tamax     <dbl> 14.2, 13.7, 13.7, 13.6, 13.2, 12.8, 14.5, 15.6, 17.8, 19.8, …
#> $ tpr       <dbl> 10.2, 9.8, 9.4, 8.9, 8.5, 8.7, 8.7, 8.8, 8.7, 8.8, 8.1, 7.7,…
#> $ stddv     <dbl> 5, 5, 6, 9, 7, 4, 9, 14, 9, 9, 13, 11, NA, NA, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 25.9, 60.0, 60.0, 60.0, 60.0, 60.0,…
#> $ tss5cm    <dbl> 15.0, 14.7, 14.4, 14.2, 13.9, 13.6, 13.5, 13.8, 14.5, 15.8, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 15.9, 15.8, 15.7, 15.6, 15.5, 15.3, 15.2, 15.1, 15.0, 14.9, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 18, 35, 31, …
```
