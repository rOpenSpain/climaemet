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
#> Rows: 24
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-05-27 03:00:00, 2026-05-27 04:00:00, 2026-05-27 05:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.3, 2.1, 1.5, 1.8, 1.7, 2.2, 2.9, 2.8, 3.2, 3.1, 3.5, 4.7, …
#> $ vv        <dbl> 1.0, 1.2, 0.7, 1.0, 0.9, 1.5, 1.2, 1.1, 1.4, 1.6, 1.3, 1.8, …
#> $ dv        <dbl> 186, 131, 107, 25, 79, 107, 65, 273, 58, 290, 91, 1, 321, 32…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 183, 175, 168, 20, 103, 128, 98, 293, 298, 303, 303, 30, 319…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 993.8, 993.8, 994.0, 994.0, 994.2, 994.0, 993.7, 993.2, 992.…
#> $ hr        <dbl> 45, 52, 54, 53, 50, 43, 36, 33, 28, 23, 18, 12, 40, 40, 44, …
#> $ stdvv     <dbl> 0.2, 0.2, 0.2, 0.3, 0.3, 0.2, 0.3, 0.5, 0.5, 0.6, 0.6, 0.7, …
#> $ ts        <dbl> 14.1, 13.2, 13.1, 17.5, 23.6, 30.1, 34.1, 35.5, 41.1, 42.8, …
#> $ pres_nmar <dbl> 1023.5, 1023.6, 1023.8, 1023.8, 1023.7, 1023.2, 1022.7, 1021…
#> $ tamin     <dbl> 18.0, 17.6, 17.0, 17.0, 17.6, 20.3, 22.8, 24.9, 27.4, 29.5, …
#> $ ta        <dbl> 18.0, 17.6, 17.0, 17.6, 20.3, 22.8, 24.9, 27.4, 29.6, 31.9, …
#> $ tamax     <dbl> 19.3, 18.1, 17.6, 17.6, 20.3, 22.8, 24.9, 27.4, 29.6, 31.9, …
#> $ tpr       <dbl> 5.9, 7.6, 7.6, 7.8, 9.6, 9.6, 8.8, 9.7, 9.2, 8.3, NA, NA, 6.…
#> $ stddv     <dbl> 15, 12, 17, 31, 22, 25, 51, 25, 41, 30, 116, 49, NA, NA, NA,…
#> $ inso      <dbl> 0.0, 0.0, 5.9, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.…
#> $ tss5cm    <dbl> 25.2, 24.6, 24.1, 23.7, 23.6, 24.1, 25.1, 26.4, 28.1, 30.2, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 27.3, 27.0, 26.7, 26.4, 26.1, 25.8, 25.6, 25.5, 25.5, 25.7, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 63, 65, 57, …
```
