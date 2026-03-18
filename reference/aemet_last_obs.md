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
#> $ fint      <dttm> 2026-03-18 00:00:00, 2026-03-18 01:00:00, 2026-03-18 02:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.7, 3.1, 3.3, 1.8, 2.0, 2.8, 2.0, 1.6, 2.3, 2.0, 3.2, 3.7, …
#> $ vv        <dbl> 1.7, 2.0, 1.6, 1.1, 1.0, 1.5, 0.6, 0.6, 0.7, 1.0, 1.5, 0.9, …
#> $ dv        <dbl> 105, 100, 81, 182, 209, 150, 137, 12, 101, 16, 60, 118, 99, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 93, 103, 113, 93, 193, 140, 163, 23, 303, 110, 60, 60, 105, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 981.4, 981.4, 981.2, 980.7, 980.8, 980.6, 980.8, 981.1, 981.…
#> $ hr        <dbl> 77, 79, 83, 82, 83, 85, 84, 86, 76, 70, 62, 51, 43, 36, 36, …
#> $ stdvv     <dbl> 0.2, 0.3, 0.2, 0.2, 0.2, 0.4, 0.3, 0.1, 0.2, 0.3, 0.6, 0.6, …
#> $ ts        <dbl> 7.7, 7.5, 6.9, 5.6, 5.2, 5.4, 3.9, 7.1, 12.0, 15.6, 17.9, 20…
#> $ pres_nmar <dbl> 1011.5, 1011.6, 1011.5, 1011.1, 1011.3, 1011.1, 1011.3, 1011…
#> $ tamin     <dbl> 10.5, 9.8, 8.8, 8.1, 7.1, 6.8, 6.9, 6.4, 6.9, 9.7, 11.6, 14.…
#> $ ta        <dbl> 10.5, 9.8, 8.8, 8.1, 7.1, 7.3, 6.9, 6.9, 9.7, 11.6, 14.0, 16…
#> $ tamax     <dbl> 11.4, 10.5, 9.8, 8.8, 8.1, 7.3, 7.4, 7.0, 9.7, 12.0, 14.0, 1…
#> $ tpr       <dbl> 6.7, 6.4, 6.1, 5.1, 4.5, 5.0, 4.3, 4.6, 5.6, 6.2, 6.8, 5.9, …
#> $ stddv     <dbl> 8, 7, 9, 14, 13, 20, 33, 26, 33, 56, 33, 86, 23, NA, NA, NA,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 40.6, 60.0, 60.0, 60.0, 6…
#> $ tss5cm    <dbl> 12.6, 12.2, 11.8, 11.3, 10.9, 10.5, 10.2, 9.9, 10.0, 10.8, 1…
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 14.0, 13.8, 13.6, 13.4, 13.2, 13.0, 12.8, 12.5, 12.3, 12.2, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 83, 83, …
```
