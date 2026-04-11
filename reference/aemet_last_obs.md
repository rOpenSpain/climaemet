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
#> $ fint      <dttm> 2026-04-10 19:00:00, 2026-04-10 20:00:00, 2026-04-10 21:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.3, 4.2, 3.9, 4.5, 4.4, 4.0, 3.8, 3.1, 2.2, 2.8, 2.5, 4.6, …
#> $ vv        <dbl> 2.8, 2.2, 2.5, 2.7, 2.1, 2.7, 2.6, 1.9, 1.0, 1.7, 1.5, 1.5, …
#> $ dv        <dbl> 143, 116, 99, 85, 91, 98, 94, 101, 59, 80, 101, 76, 110, 134…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 165, 150, 105, 115, 90, 103, 110, 83, 100, 108, 70, 73, 88, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 983.1, 983.2, 983.4, 983.5, 983.3, 983.3, 983.0, 982.7, 982.…
#> $ hr        <dbl> 27, 32, 37, 41, 46, 45, 52, 58, 54, 56, 56, 52, 53, 23, 31, …
#> $ stdvv     <dbl> 0.4, 0.3, 0.3, 0.5, 0.3, 0.3, 0.3, 0.2, 0.4, 0.3, 0.2, 0.4, …
#> $ ts        <dbl> 21.3, 19.3, 17.3, 17.2, 14.9, 14.7, 14.4, 12.3, 13.5, 13.9, …
#> $ pres_nmar <dbl> 1011.7, 1012.0, 1012.4, 1012.7, 1012.6, 1012.7, 1012.5, 1012…
#> $ tamin     <dbl> 25.5, 23.8, 21.8, 20.4, 18.9, 18.1, 17.4, 16.0, 15.9, 15.5, …
#> $ ta        <dbl> 25.5, 23.8, 21.8, 20.4, 18.9, 18.1, 17.4, 16.0, 16.1, 15.5, …
#> $ tamax     <dbl> 27.2, 25.5, 23.8, 21.8, 20.4, 18.9, 18.1, 17.4, 16.1, 16.1, …
#> $ tpr       <dbl> 5.1, 6.1, 6.4, 6.7, 7.0, 5.9, 7.4, 7.7, 6.8, 6.7, 6.4, 5.5, …
#> $ stddv     <dbl> 9, 7, 9, 9, 5, 11, 7, 7, 19, 10, 7, 19, 17, NA, NA, NA, NA, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ tss5cm    <dbl> 23.1, 22.2, 21.4, 20.7, 20.1, 19.6, 19.1, 18.7, 18.3, 18.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 20.1, 20.2, 20.3, 20.2, 20.1, 20.0, 19.8, 19.7, 19.5, 19.3, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 82, 62, …
```
