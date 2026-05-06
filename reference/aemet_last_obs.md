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
#> Rows: 26
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-05-06 01:00:00, 2026-05-06 02:00:00, 2026-05-06 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 6.2, 6.3, 7.5, 6.7, 3.5, 2.7, 2.7, 5.0, 6.9, 8.2, 8.2, 10.6,…
#> $ vv        <dbl> 5.0, 3.6, 5.0, 3.1, 1.1, 1.7, 0.9, 3.4, 4.8, 3.9, 5.1, 4.9, …
#> $ dv        <dbl> 279, 299, 275, 287, 9, 334, 298, 307, 297, 307, 318, 313, 30…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 280, 283, 280, 278, 295, 325, 348, 310, 290, 305, 328, 295, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 983.9, 983.6, 983.8, 984.0, 984.1, 984.4, 984.7, 984.6, 984.…
#> $ hr        <dbl> 76, 77, 76, 78, 89, 84, 78, 65, 56, 48, 45, 42, 36, 62, 64, …
#> $ stdvv     <dbl> 0.4, 0.3, 0.7, 0.4, 0.2, 0.3, 0.2, 0.7, 0.8, 1.0, 1.1, 1.0, …
#> $ ts        <dbl> 10.4, 10.0, 9.6, 9.3, 7.1, 9.3, 13.9, 17.6, 19.6, 21.7, 23.3…
#> $ pres_nmar <dbl> 1014.1, 1013.8, 1014.0, 1014.3, 1014.6, 1014.8, 1014.9, 1014…
#> $ tamin     <dbl> 11.0, 10.6, 10.3, 10.0, 8.1, 8.1, 9.3, 10.9, 13.0, 14.7, 16.…
#> $ ta        <dbl> 11.0, 10.6, 10.5, 10.0, 8.1, 9.3, 10.9, 13.0, 14.7, 16.2, 17…
#> $ tamax     <dbl> 11.5, 11.0, 10.7, 10.6, 10.1, 9.3, 10.9, 13.0, 14.7, 16.2, 1…
#> $ tpr       <dbl> 7.0, 6.7, 6.4, 6.4, 6.4, 6.7, 7.3, 6.5, 5.9, 5.1, 5.1, 5.1, …
#> $ stddv     <dbl> 5, 7, 7, 6, 16, 12, 19, 12, 9, 15, 18, 14, 16, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 53.8, 60.0, 60.0, 60.0, 60.0, 60.0,…
#> $ tss5cm    <dbl> 15.9, 15.4, 15.0, 14.7, 14.4, 14.1, 14.0, 14.5, 15.4, 16.6, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 18.7, 18.5, 18.2, 18.0, 17.7, 17.5, 17.2, 17.0, 16.9, 16.8, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 62, 58, …
```
