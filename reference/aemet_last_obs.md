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
#> $ fint      <dttm> 2026-04-24 21:00:00, 2026-04-24 22:00:00, 2026-04-24 23:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.3, 2.7, 2.9, 3.2, 2.5, 3.3, 1.4, 2.1, 2.3, 2.9, 4.7, 8.6, …
#> $ vv        <dbl> 2.0, 2.2, 1.5, 1.1, 1.4, 1.2, 1.0, 1.3, 0.9, 1.1, 3.1, 5.6, …
#> $ dv        <dbl> 106, 107, 66, 72, 121, 96, 66, 121, 253, 325, 314, 304, 330,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 103, 95, 110, 85, 85, 138, 318, 138, 303, 310, 315, 290, 303…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 987.5, 988.0, 988.3, 988.2, 988.0, 988.0, 988.2, 988.1, 988.…
#> $ hr        <dbl> 55, 59, 63, 71, 74, 73, 75, 78, 78, 78, 78, 70, 65, 75, 63, …
#> $ stdvv     <dbl> 0.5, 0.2, 0.4, 0.3, 0.2, 0.1, 0.2, 0.3, 0.4, 0.4, 0.8, 1.0, …
#> $ ts        <dbl> 17.1, 15.7, 15.1, 15.9, 13.2, 15.4, 13.3, 12.3, 12.4, 14.1, …
#> $ pres_nmar <dbl> 1016.8, 1017.4, 1017.8, 1017.8, 1017.7, 1017.7, 1018.0, 1018…
#> $ tamin     <dbl> 20.1, 19.0, 18.1, 16.9, 16.0, 15.9, 15.5, 14.7, 14.4, 14.2, …
#> $ ta        <dbl> 20.1, 19.0, 18.1, 16.9, 16.0, 16.1, 15.5, 14.7, 14.4, 14.8, …
#> $ tamax     <dbl> 21.5, 20.1, 19.0, 18.1, 16.9, 16.2, 16.1, 15.5, 14.7, 14.8, …
#> $ tpr       <dbl> 10.8, 10.8, 11.0, 11.6, 11.3, 11.2, 11.1, 10.9, 10.6, 11.0, …
#> $ stddv     <dbl> 11, 7, 13, 23, 18, 14, 11, 19, 24, 124, 11, 11, 13, NA, NA, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.7, 58.9, 60.0…
#> $ tss5cm    <dbl> 24.7, 23.8, 23.1, 22.6, 22.1, 21.6, 21.4, 20.9, 20.4, 20.1, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 23.9, 23.9, 23.7, 23.5, 23.3, 23.1, 22.9, 22.6, 22.4, 22.2, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 27, 60, …
```
