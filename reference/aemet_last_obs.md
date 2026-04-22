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
#> Rows: 24
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-04-22 01:00:00, 2026-04-22 02:00:00, 2026-04-22 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.0, 7.9, 4.1, 3.9, 2.9, 2.8, 2.8, 4.2, 4.2, 4.0, 5.9, 7.5, …
#> $ vv        <dbl> 3.2, 3.3, 2.0, 2.6, 1.5, 1.6, 1.7, 2.7, 2.4, 2.6, 2.7, 2.7, …
#> $ dv        <dbl> 97, 103, 82, 102, 77, 201, 163, 96, 80, 96, 252, 215, 226, 2…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 98, 143, 108, 110, 85, 128, 130, 98, 90, 85, 268, 265, 87, 2…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 980.1, 980.0, 980.2, 980.3, 980.8, 982.0, 982.8, 983.2, 983.…
#> $ hr        <dbl> 62, 60, 69, 68, 66, 65, 60, 58, 52, 46, 29, 26, 75, 70, 65, …
#> $ stdvv     <dbl> 0.6, 0.5, 0.4, 0.4, 0.3, 0.4, 0.4, 0.5, 0.5, 0.5, 1.2, 1.2, …
#> $ ts        <dbl> 15.5, 15.5, 13.9, 12.6, 12.0, 13.0, 16.9, 21.5, 28.5, 31.1, …
#> $ pres_nmar <dbl> 1009.3, 1009.3, 1009.7, 1009.9, 1010.5, 1011.7, 1012.3, 1012…
#> $ tamin     <dbl> 18.5, 18.1, 16.2, 15.2, 14.7, 14.5, 14.9, 16.5, 18.1, 20.2, …
#> $ ta        <dbl> 18.5, 18.1, 16.2, 15.2, 14.7, 14.9, 16.5, 18.1, 20.2, 22.8, …
#> $ tamax     <dbl> 19.6, 19.0, 18.1, 16.2, 15.2, 14.9, 16.5, 18.1, 20.2, 22.8, …
#> $ tpr       <dbl> 11.1, 10.2, 10.5, 9.3, 8.4, 8.4, 8.7, 9.7, 10.0, 10.5, 6.5, …
#> $ stddv     <dbl> 10, 9, 12, 9, 14, 19, 27, 11, 15, 17, 81, 33, NA, NA, NA, NA…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 3.1, 59.4, 60.0, 60.0, 60.0, 60.0, …
#> $ tss5cm    <dbl> 22.2, 21.6, 21.1, 20.6, 20.1, 19.6, 19.4, 19.5, 20.0, 21.1, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 22.8, 22.7, 22.5, 22.2, 22.0, 21.8, 21.5, 21.3, 21.1, 20.9, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 35, 62, 92, …
```
