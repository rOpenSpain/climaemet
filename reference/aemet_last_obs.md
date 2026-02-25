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
#> $ fint      <dttm> 2026-02-25 00:00:00, 2026-02-25 01:00:00, 2026-02-25 02:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.5, 4.4, 4.0, 4.4, 4.1, 3.7, 3.4, 3.3, 2.9, 3.4, 3.4, 3.4, …
#> $ vv        <dbl> 3.6, 2.2, 3.3, 3.4, 1.9, 2.4, 2.3, 1.2, 1.7, 2.5, 2.3, 1.9, …
#> $ dv        <dbl> 120, 140, 118, 111, 133, 140, 109, 164, 132, 116, 95, 85, 10…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 123, 148, 120, 115, 118, 128, 123, 118, 128, 115, 103, 65, 1…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.3, 988.5, 988.5, 988.3, 988.5, 988.7, 989.1, 989.4, 990.…
#> $ hr        <dbl> 76, 72, 76, 75, 79, 85, 88, 83, 79, 75, 69, 62, 53, 48, 49, …
#> $ stdvv     <dbl> 0.4, 0.4, 0.3, 0.4, 0.4, 0.3, 0.1, 0.3, 0.4, 0.4, 0.4, 0.6, …
#> $ ts        <dbl> 9.4, 10.0, 8.6, 8.3, 6.4, 7.1, 6.0, 4.9, 9.6, 11.0, 14.7, 17…
#> $ pres_nmar <dbl> 1018.6, 1018.8, 1018.9, 1018.8, 1019.2, 1019.4, 1019.9, 1020…
#> $ tamin     <dbl> 10.6, 10.8, 9.9, 9.1, 7.9, 7.8, 7.1, 6.4, 6.3, 8.5, 10.0, 12…
#> $ ta        <dbl> 10.8, 11.2, 9.9, 9.1, 7.9, 7.9, 7.1, 6.4, 8.5, 10.0, 12.0, 1…
#> $ tamax     <dbl> 10.9, 11.4, 11.2, 10.0, 9.1, 8.0, 7.9, 7.1, 8.5, 10.0, 12.0,…
#> $ tpr       <dbl> 6.7, 6.4, 5.9, 5.0, 4.5, 5.5, 5.3, 3.8, 5.1, 5.8, 6.5, 7.0, …
#> $ stddv     <dbl> 5, 14, 6, 6, 10, 8, 5, 19, 14, 9, 8, 23, 11, NA, NA, NA, NA,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 52.5, 60.0, 60.0, 60…
#> $ tss5cm    <dbl> 11.3, 11.0, 10.7, 10.4, 10.1, 9.7, 9.4, 9.1, 8.9, 9.2, 9.9, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 12.4, 12.2, 12.1, 11.9, 11.8, 11.6, 11.4, 11.2, 11.1, 10.9, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 52, 71, …
```
