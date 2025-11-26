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
#> $ fint      <dttm> 2025-11-26 01:00:00, 2025-11-26 02:00:00, 2025-11-26 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 12.2, 9.9, 10.5, 9.9, 11.2, 11.5, 11.2, 11.8, 13.5, 13.7, 15…
#> $ vv        <dbl> 7.5, 8.0, 8.6, 6.8, 8.2, 7.4, 5.5, 8.9, 8.9, 9.4, 8.5, 10.2,…
#> $ dv        <dbl> 309, 292, 287, 297, 304, 310, 291, 300, 308, 305, 316, 314, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 288, 290, 288, 280, 305, 303, 313, 298, 298, 310, 313, 313, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 990.3, 990.3, 990.2, 990.3, 990.9, 991.4, 992.0, 992.6, 993.…
#> $ hr        <dbl> 81, 87, 85, 88, 84, 82, 83, 79, 74, 66, 60, 54, NA, NA, NA, …
#> $ stdvv     <dbl> 1.1, 0.7, 0.9, 0.7, 1.0, 1.2, 0.7, 1.2, 1.5, 1.7, 1.5, 1.5, …
#> $ ts        <dbl> 5.8, 5.2, 5.5, 5.0, 5.2, 5.0, 4.6, 5.4, 7.9, 9.5, 11.0, 12.0…
#> $ pres_nmar <dbl> 1021.1, 1021.2, 1021.1, 1021.2, 1021.8, 1022.3, 1023.0, 1023…
#> $ tamin     <dbl> 6.0, 5.6, 5.4, 5.2, 5.6, 5.6, 5.2, 5.0, 6.1, 7.1, 8.3, 9.3, …
#> $ ta        <dbl> 6.4, 5.6, 5.9, 5.5, 5.8, 5.7, 5.2, 6.1, 7.1, 8.3, 9.3, 10.1,…
#> $ tamax     <dbl> 6.4, 6.4, 5.9, 5.9, 6.3, 5.8, 5.7, 6.1, 7.1, 8.3, 9.4, 10.2,…
#> $ tpr       <dbl> 3.4, 3.6, 3.6, 3.6, 3.2, 2.9, 2.5, 2.7, 2.9, 2.3, 1.9, 1.3, …
#> $ stddv     <dbl> 9, 5, 7, 6, 7, 7, 7, 7, 8, 9, 10, 10, NA, NA, NA, NA, NA, NA…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 44.2, 60.0, 60.0, 59.9, 5…
#> $ tss5cm    <dbl> 8.0, 7.8, 7.6, 7.4, 7.3, 7.1, 7.0, 6.8, 6.9, 7.3, 7.9, 8.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 10.4, 10.3, 10.1, 10.0, 9.9, 9.7, 9.6, 9.5, 9.4, 9.2, 9.2, 9…
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 51, 47, 44, …
```
