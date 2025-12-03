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
#> $ fint      <dttm> 2025-12-03 01:00:00, 2025-12-03 02:00:00, 2025-12-03 03:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 1.4, 2.0, 4.0, 5.7, 4.4, 6.0, 6.0, 3.1, 6.8, 9.9, 10.1, 10.4…
#> $ vv        <dbl> 1.0, 0.8, 2.3, 3.5, 1.4, 3.9, 2.0, 2.3, 4.6, 6.5, 7.2, 7.6, …
#> $ dv        <dbl> 244, 253, 313, 314, 334, 305, 299, 299, 313, 303, 298, 308, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 283, 260, 275, 315, 305, 328, 298, 303, 303, 298, 300, 300, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 982.9, 983.2, 983.1, 983.2, 983.7, 984.4, 984.9, 985.7, 986.…
#> $ hr        <dbl> 95, 96, 97, 98, 99, 99, 99, 100, 90, 77, 75, 61, NA, NA, NA,…
#> $ stdvv     <dbl> 0.2, 0.3, 0.6, 0.5, 0.5, 0.5, 0.4, 0.4, 0.5, 1.1, 1.2, 0.8, …
#> $ ts        <dbl> 0.3, -0.1, 0.3, 0.9, 0.6, 0.3, 0.1, 0.3, 5.0, 8.3, 9.8, 12.2…
#> $ pres_nmar <dbl> 1014.1, 1014.5, 1014.3, 1014.4, 1014.9, 1015.8, 1016.3, 1017…
#> $ tamin     <dbl> 1.0, 0.7, 0.5, 0.5, 1.0, 0.0, -0.1, -0.4, 0.5, 3.9, 7.1, 8.4…
#> $ ta        <dbl> 1.0, 0.7, 1.0, 1.0, 1.1, 0.1, 0.0, 0.5, 3.9, 7.1, 8.4, 10.4,…
#> $ tamax     <dbl> 1.7, 1.0, 1.0, 1.2, 1.8, 1.1, 0.2, 0.5, 3.9, 7.1, 8.4, 10.4,…
#> $ tpr       <dbl> 0.2, 0.2, 0.6, 0.6, 1.1, 0.0, 0.0, 0.4, 2.5, 3.4, 4.3, 3.2, …
#> $ stddv     <dbl> 26, 11, 11, 7, 21, 7, 14, 10, 6, 12, 9, 8, NA, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 35.5, 60.0, 60.0, 60.0, 6…
#> $ tss5cm    <dbl> 4.9, 4.6, 4.4, 4.2, 4.2, 4.1, 4.0, 3.8, 3.9, 4.7, 5.7, 6.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 7.9, 7.7, 7.6, 7.4, 7.2, 7.1, 7.0, 6.8, 6.7, 6.6, 6.5, 6.6, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 42, 57, 76, …
```
