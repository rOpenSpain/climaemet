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
#> $ fint      <dttm> 2026-02-26 21:00:00, 2026-02-26 22:00:00, 2026-02-26 23:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.7, 3.1, 3.7, 3.6, 3.3, 2.8, 3.4, 2.9, 2.5, 3.9, 3.8, 4.0, …
#> $ vv        <dbl> 2.4, 1.6, 2.9, 2.2, 1.5, 1.7, 2.0, 1.8, 1.9, 2.4, 1.5, 2.0, …
#> $ dv        <dbl> 111, 116, 115, 133, 130, 105, 131, 116, 121, 83, 130, 134, 1…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 100, 110, 118, 138, 128, 93, 125, 133, 123, 80, 125, 135, 10…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 995.4, 995.4, 995.4, 995.4, 995.1, 994.9, 994.6, 994.3, 994.…
#> $ hr        <dbl> 77, 81, 82, 81, 84, 87, 89, 91, 93, 95, 95, 92, 85, 34, 37, …
#> $ stdvv     <dbl> 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.4, 0.2, 0.2, 0.4, 0.3, 0.3, …
#> $ ts        <dbl> 11.0, 9.8, 9.6, 9.0, 8.1, 7.2, 7.3, 6.4, 5.9, 6.1, 5.7, 8.6,…
#> $ pres_nmar <dbl> 1025.8, 1025.9, 1026.0, 1026.0, 1025.8, 1025.7, 1025.4, 1025…
#> $ tamin     <dbl> 12.2, 11.5, 10.6, 10.2, 9.4, 8.6, 8.0, 7.3, 6.9, 6.4, 6.3, 6…
#> $ ta        <dbl> 12.2, 11.5, 10.6, 10.2, 9.4, 8.6, 8.1, 7.3, 6.9, 6.4, 6.4, 7…
#> $ tamax     <dbl> 13.2, 12.2, 11.5, 10.9, 10.2, 9.4, 8.6, 8.1, 7.4, 6.9, 6.4, …
#> $ tpr       <dbl> 8.3, 8.4, 7.7, 7.1, 6.8, 6.5, 6.4, 5.9, 5.8, 5.6, 5.6, 6.5, …
#> $ stddv     <dbl> 6, 11, 6, 7, 7, 9, 8, 6, 6, 10, 10, 9, 8, NA, NA, NA, NA, NA…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 52.2,…
#> $ tss5cm    <dbl> 13.4, 12.9, 12.4, 12.0, 11.6, 11.2, 10.8, 10.5, 10.1, 9.8, 9…
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 13.4, 13.3, 13.2, 13.1, 12.9, 12.7, 12.6, 12.4, 12.2, 12.0, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 39, 42, …
```
