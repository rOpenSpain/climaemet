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
#> $ fint      <dttm> 2026-03-23 07:00:00, 2026-03-23 08:00:00, 2026-03-23 09:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 8.1, 8.3, 9.3, 8.0, 6.6, 8.2, 7.8, 6.4, 5.2, 5.5, 6.0, 6.2, …
#> $ vv        <dbl> 3.7, 5.6, 6.2, 4.5, 3.6, 4.2, 3.4, 2.9, 1.9, 2.8, 3.9, 3.7, …
#> $ dv        <dbl> 310, 307, 314, 320, 331, 311, 315, 297, 261, 288, 317, 305, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 305, 303, 298, 330, 325, 290, 325, 308, 315, 275, 305, 318, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 986.3, 986.8, 987.4, 987.9, 988.2, 988.0, 987.7, 987.2, 987.…
#> $ hr        <dbl> 67, 64, 57, 52, 50, 45, 42, 38, 35, 35, 35, 38, 45, 70, 66, …
#> $ stdvv     <dbl> 0.6, 1.1, 1.2, 0.9, 0.9, 1.2, 1.1, 0.7, 1.0, 0.8, 0.7, 0.7, …
#> $ ts        <dbl> 7.9, 9.6, 11.8, 14.9, 17.6, 18.9, 21.1, 21.5, 22.8, 21.6, 19…
#> $ pres_nmar <dbl> 1016.9, 1017.3, 1017.8, 1018.1, 1018.3, 1017.9, 1017.4, 1016…
#> $ tamin     <dbl> 7.7, 7.8, 8.7, 10.6, 12.2, 13.5, 14.9, 16.2, 17.4, 18.3, 17.…
#> $ ta        <dbl> 7.9, 8.7, 10.6, 12.2, 13.5, 14.9, 16.3, 17.4, 18.3, 18.5, 17…
#> $ tamax     <dbl> 8.1, 8.7, 10.6, 12.2, 13.5, 15.0, 16.5, 17.4, 18.3, 18.7, 18…
#> $ tpr       <dbl> 2.1, 2.3, 2.5, 2.7, 3.2, 3.0, 3.4, 2.9, 2.5, 2.7, 2.3, 2.5, …
#> $ stddv     <dbl> 12, 11, 11, 12, 23, 13, 17, 15, 30, 18, 11, 10, 10, NA, NA, …
#> $ inso      <dbl> 34.9, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, …
#> $ tss5cm    <dbl> 10.9, 10.9, 11.3, 12.1, 13.5, 15.0, 16.4, 17.7, 18.6, 18.9, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 13.0, 12.9, 12.7, 12.6, 12.6, 12.7, 12.9, 13.2, 13.6, 14.0, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 90, 99, …
```
