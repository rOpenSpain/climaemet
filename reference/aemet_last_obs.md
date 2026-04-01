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
#> $ fint      <dttm> 2026-04-01 01:00:00, 2026-04-01 02:00:00, 2026-04-01 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 16.3, 15.2, 14.4, 15.5, 19.5, 16.8, 19.6, 18.0, 19.8, 19.4, …
#> $ vv        <dbl> 10.4, 9.0, 9.2, 10.5, 10.6, 11.7, 10.6, 11.4, 11.5, 10.7, 11…
#> $ dv        <dbl> 313, 320, 311, 324, 319, 323, 323, 323, 325, 324, 320, 318, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 310, 318, 320, 325, 303, 305, 333, 320, 338, 325, 328, 320, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 993.4, 993.0, 992.4, 991.8, 991.9, 992.0, 992.3, 992.1, 992.…
#> $ hr        <dbl> 70, 72, 72, 72, 72, 70, 68, 65, 60, 56, 49, 43, 57, 59, 53, …
#> $ stdvv     <dbl> 1.5, 1.5, 1.4, 2.2, 1.8, 1.9, 2.3, 2.0, 2.2, 2.0, 2.3, 2.1, …
#> $ ts        <dbl> 9.6, 9.3, 9.3, 9.6, 9.6, 10.0, 11.3, 13.2, 14.9, 16.7, 18.2,…
#> $ pres_nmar <dbl> 1024.0, 1023.6, 1023.0, 1022.3, 1022.4, 1022.5, 1022.7, 1022…
#> $ tamin     <dbl> 9.9, 9.7, 9.7, 9.8, 10.1, 10.1, 10.6, 11.3, 12.6, 13.8, 15.1…
#> $ ta        <dbl> 9.9, 9.7, 9.8, 10.1, 10.1, 10.6, 11.3, 12.6, 13.8, 15.1, 16.…
#> $ tamax     <dbl> 10.0, 9.9, 9.8, 10.1, 10.2, 10.6, 11.3, 12.6, 13.8, 15.1, 16…
#> $ tpr       <dbl> 4.6, 5.0, 5.0, 5.3, 5.3, 5.3, 5.6, 6.2, 6.1, 6.4, 5.6, 4.5, …
#> $ stddv     <dbl> 8, 10, 8, 11, 9, 10, 9, 10, 11, 11, 11, 13, NA, NA, NA, NA, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 5.1, 60.0, 60.0, 60.0, 60.0, 60.0, …
#> $ tss5cm    <dbl> 12.3, 12.1, 11.9, 11.8, 11.6, 11.5, 11.5, 11.6, 12.1, 12.9, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 13.6, 13.5, 13.4, 13.3, 13.2, 13.0, 12.9, 12.8, 12.8, 12.7, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 121, 120, 12…
```
