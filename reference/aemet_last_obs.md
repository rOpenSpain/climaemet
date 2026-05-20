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
  object? If `FALSE` (the default value), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  Note that you need to have the
  [sf](https://CRAN.R-project.org/package=sf) package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical. Display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE`, it will not be displayed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## API key

You need to set your API key globally using
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
#> $ fint      <dttm> 2026-05-20 05:00:00, 2026-05-20 06:00:00, 2026-05-20 07:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.9, 7.6, 9.3, 9.8, 8.4, 7.0, 6.3, 5.0, 3.3, 3.8, 4.0, 4.0, …
#> $ vv        <dbl> 4.0, 6.0, 7.2, 6.1, 4.8, 4.5, 3.0, 2.2, 1.4, 1.4, 1.1, 1.8, …
#> $ dv        <dbl> 283, 300, 308, 302, 325, 301, 277, 329, 74, 23, 312, 82, 81,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 285, 295, 320, 308, 315, 308, 310, 298, 95, 60, 88, 80, 105,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 994.1, 995.0, 995.4, 995.7, 995.7, 995.5, 995.1, 994.5, 994.…
#> $ hr        <dbl> 77, 72, 65, 59, 56, 50, 45, 42, 38, 32, 32, 30, 27, 75, 74, …
#> $ stdvv     <dbl> 0.4, 0.7, 1.0, 0.7, 0.8, 0.7, 0.7, 0.6, 0.5, 0.6, 0.4, 0.8, …
#> $ ts        <dbl> 15.4, 17.4, 19.4, 22.8, 26.8, 29.4, 33.1, 35.2, 38.6, 37.8, …
#> $ pres_nmar <dbl> 1024.0, 1024.8, 1025.1, 1025.2, 1025.1, 1024.7, 1024.1, 1023…
#> $ tamin     <dbl> 15.8, 15.8, 16.9, 18.0, 20.0, 21.2, 23.0, 25.2, 26.5, 27.9, …
#> $ ta        <dbl> 15.9, 16.9, 18.0, 20.0, 21.2, 23.0, 25.2, 26.5, 27.9, 29.0, …
#> $ tamax     <dbl> 16.8, 16.9, 18.0, 20.0, 21.2, 23.1, 25.2, 26.6, 27.9, 29.0, …
#> $ tpr       <dbl> 11.9, 11.8, 11.3, 11.8, 12.1, 12.0, 12.4, 12.5, 12.2, 10.6, …
#> $ stddv     <dbl> 6, 6, 8, 10, 12, 10, 19, 27, 31, 44, 76, 34, 16, NA, NA, NA,…
#> $ inso      <dbl> 0.0, 59.1, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 59.5, 60.0, 6…
#> $ tss5cm    <dbl> 20.7, 20.4, 20.4, 20.6, 21.3, 22.4, 24.0, 25.8, 27.3, 28.6, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 22.1, 21.9, 21.7, 21.5, 21.4, 21.3, 21.4, 21.6, 21.9, 22.3, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 40, 80, …
```
