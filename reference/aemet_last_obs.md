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
#> Rows: 24
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-04-08 01:00:00, 2026-04-08 02:00:00, 2026-04-08 03:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.1, 2.1, 2.4, 1.7, 2.6, 1.2, 1.9, 1.6, 2.1, 2.8, 4.2, 5.5, …
#> $ vv        <dbl> 1.2, 0.8, 0.4, 0.6, 0.3, 0.4, 0.8, 0.7, 1.0, 1.3, 2.0, 3.2, …
#> $ dv        <dbl> 51, 311, 227, 273, 202, 34, 356, 115, 330, 157, 102, 116, 12…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 130, 75, 253, 150, 235, 275, 298, 105, 15, 83, 90, 85, 84, 1…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 989.3, 989.4, 989.2, 989.3, 989.6, 990.0, 990.6, 990.7, 990.…
#> $ hr        <dbl> 52, 51, 56, 59, 62, 66, 61, 53, 48, 39, 31, 27, 96, 95, 96, …
#> $ stdvv     <dbl> 0.3, 0.1, 0.2, 0.2, 0.2, 0.3, 0.2, 0.2, 0.3, 0.4, 0.5, 0.8, …
#> $ ts        <dbl> 8.6, 7.7, 7.1, 6.5, 6.8, 6.1, 12.0, 17.7, 21.4, 24.0, 27.6, …
#> $ pres_nmar <dbl> 1019.4, 1019.6, 1019.5, 1019.7, 1020.1, 1020.6, 1021.0, 1020…
#> $ tamin     <dbl> 13.3, 12.6, 11.4, 10.5, 9.9, 9.5, 9.5, 10.8, 14.1, 16.3, 19.…
#> $ ta        <dbl> 13.3, 12.6, 11.4, 10.5, 9.9, 9.5, 10.8, 14.1, 16.3, 19.0, 20…
#> $ tamax     <dbl> 15.3, 13.3, 12.6, 11.4, 10.5, 9.9, 10.8, 14.1, 16.3, 19.0, 2…
#> $ tpr       <dbl> 3.6, 2.7, 2.9, 2.9, 3.0, 3.4, 3.6, 4.6, 5.3, 4.6, 3.0, 3.4, …
#> $ stddv     <dbl> 21, 26, 50, 8, 25, 82, 20, 63, 76, 37, 33, 26, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 52.5, 60.0, 60.0, 60.0, 60.0, …
#> $ tss5cm    <dbl> 16.5, 15.9, 15.4, 14.9, 14.5, 14.1, 13.8, 14.0, 14.9, 16.1, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 17.6, 17.4, 17.2, 17.0, 16.8, 16.6, 16.3, 16.1, 15.9, 15.8, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 45, 62, 53, …
```
