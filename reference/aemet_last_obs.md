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
#> $ fint      <dttm> 2026-05-13 02:00:00, 2026-05-13 03:00:00, 2026-05-13 04:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 12.3, 11.1, 11.1, 7.2, 10.5, 10.5, 14.7, 14.9, 16.3, 15.5, 1…
#> $ vv        <dbl> 7.9, 6.8, 5.7, 3.8, 7.1, 7.6, 9.1, 9.4, 10.5, 10.9, 10.1, 9.…
#> $ dv        <dbl> 305, 308, 298, 290, 301, 297, 313, 321, 315, 306, 312, 317, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 303, 293, 323, 288, 295, 298, 313, 298, 308, 313, 313, 310, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 986.8, 986.8, 986.9, 987.1, 987.4, 987.6, 987.7, 987.6, 987.…
#> $ hr        <dbl> 67, 67, 73, 75, 64, 60, 60, 55, 49, 43, 43, 42, 79, 83, 84, …
#> $ stdvv     <dbl> 1.2, 0.8, 0.6, 0.5, 0.9, 1.0, 1.7, 1.6, 1.7, 2.2, 1.6, 2.2, …
#> $ ts        <dbl> 11.9, 11.5, 10.8, 10.0, 12.5, 14.8, 16.8, 19.6, 21.0, 22.8, …
#> $ pres_nmar <dbl> 1016.9, 1017.0, 1017.1, 1017.4, 1017.6, 1017.6, 1017.6, 1017…
#> $ tamin     <dbl> 12.1, 11.9, 11.2, 10.6, 10.6, 12.1, 13.5, 14.6, 15.8, 16.9, …
#> $ ta        <dbl> 12.1, 11.9, 11.2, 10.6, 12.2, 13.5, 14.6, 15.9, 17.0, 18.5, …
#> $ tamax     <dbl> 12.7, 12.1, 11.9, 11.2, 12.2, 13.5, 14.6, 15.9, 17.1, 18.6, …
#> $ tpr       <dbl> 6.1, 5.9, 6.5, 6.4, 5.6, 5.9, 7.0, 6.8, 6.2, 5.6, 6.4, 6.1, …
#> $ stddv     <dbl> 6, 7, 6, 5, 7, 7, 8, 10, 10, 9, 8, 12, NA, NA, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.7, 56.3, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0…
#> $ tss5cm    <dbl> 16.4, 16.0, 15.7, 15.4, 15.2, 15.2, 15.5, 16.3, 17.5, 19.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 18.6, 18.4, 18.2, 18.0, 17.8, 17.6, 17.5, 17.4, 17.3, 17.4, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 90, 51, 63, …
```
