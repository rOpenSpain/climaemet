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
  [`tibble`](https://tibble.tidyverse.org/reference/tibble.html). Note
  that you need to have the [sf](https://CRAN.R-project.org/package=sf)
  package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with
  the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical, display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE` won't be displayed.

## Value

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object

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
#> $ fint      <dttm> 2025-11-17 08:00:00, 2025-11-17 09:00:00, 2025-11-17 10:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.9, 6.0, 7.2, 8.2, 9.9, 10.8, 10.9, 11.1, 11.9, 10.4, 9.3, …
#> $ vv        <dbl> 1.8, 4.5, 5.3, 6.0, 7.2, 7.4, 8.0, 6.8, 6.7, 6.2, 5.9, 6.4, …
#> $ dv        <dbl> 315, 308, 313, 303, 305, 315, 311, 319, 312, 311, 294, 303, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 310, 308, 315, 303, 303, 333, 313, 318, 310, 308, 313, 313, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 983.7, 984.4, 984.5, 984.2, 983.6, 983.0, 982.8, 982.9, 983.…
#> $ hr        <dbl> 88, 80, 78, 70, 67, 56, 55, 53, 55, 62, 68, 72, NA, NA, NA, …
#> $ stdvv     <dbl> 0.3, 0.5, 0.8, 0.8, 1.1, 1.2, 1.1, 1.3, 1.0, 1.1, 0.9, 1.1, …
#> $ ts        <dbl> 8.3, 12.2, 14.6, 16.7, 15.4, 18.9, 18.6, 18.7, 16.9, 14.5, 1…
#> $ pres_nmar <dbl> 1014.2, 1014.6, 1014.5, 1014.0, 1013.3, 1012.5, 1012.3, 1012…
#> $ tamin     <dbl> 7.9, 8.3, 11.0, 12.2, 14.1, 14.9, 16.9, 17.2, 16.8, 15.2, 13…
#> $ ta        <dbl> 8.3, 11.0, 12.2, 14.1, 14.9, 16.9, 17.2, 17.7, 16.8, 15.2, 1…
#> $ tamax     <dbl> 8.3, 11.0, 12.2, 14.1, 15.1, 16.9, 17.4, 17.7, 18.2, 16.8, 1…
#> $ tpr       <dbl> 6.4, 7.7, 8.5, 8.7, 8.8, 8.1, 8.1, 8.0, 7.7, 8.0, 8.1, 8.3, …
#> $ stddv     <dbl> 11, 6, 10, 9, 10, 10, 9, 9, 8, 10, 10, 10, NA, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 23.4, 37.0, 60.0, 50.5, 60.0, 60.0, 60.0, 60.0, 24.8, 0…
#> $ tss5cm    <dbl> 10.4, 10.6, 11.4, 12.4, 13.2, 13.8, 14.6, 14.6, 14.7, 14.3, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 13.1, 13.0, 12.8, 12.8, 12.8, 13.0, 13.2, 13.4, 13.6, 13.8, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 22, 22, 21, …
```
