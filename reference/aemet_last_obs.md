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
#> $ fint      <dttm> 2025-12-16 06:00:00, 2025-12-16 07:00:00, 2025-12-16 08:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.2, 2.1, 5.8, 2.6, 5.5, 5.8, 4.1, 2.4, 2.5, 2.7, 4.6, 5.5, …
#> $ vv        <dbl> 1.2, 1.1, 1.8, 1.4, 3.8, 3.4, 1.7, 1.0, 1.7, 2.1, 3.1, 4.0, …
#> $ dv        <dbl> 88, 87, 75, 107, 138, 121, 112, 330, 333, 308, 315, 305, 57,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 80, 90, 343, 128, 140, 140, 130, 98, 355, 303, 305, 325, 49,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 977.6, 978.2, 978.8, 979.4, 979.9, 980.1, 980.0, 979.8, 980.…
#> $ hr        <dbl> 100, 100, 98, 99, 95, 94, 92, 91, 88, 87, 89, 91, NA, NA, NA…
#> $ stdvv     <dbl> 0.2, 0.2, 0.3, 0.5, 0.9, 0.7, 0.4, 0.2, 0.3, 0.2, 0.5, 0.4, …
#> $ ts        <dbl> 7.9, 8.2, 8.8, 9.2, 10.1, 11.3, 11.4, 13.0, 13.1, 13.1, 12.0…
#> $ pres_nmar <dbl> 1007.9, 1008.5, 1009.0, 1009.6, 1010.1, 1010.2, 1010.1, 1009…
#> $ tamin     <dbl> 8.0, 8.1, 8.3, 8.9, 9.1, 9.7, 10.4, 10.7, 11.4, 12.0, 12.0, …
#> $ ta        <dbl> 8.1, 8.3, 8.9, 9.1, 9.8, 10.4, 10.7, 11.4, 12.0, 12.5, 12.0,…
#> $ tamax     <dbl> 8.1, 8.3, 10.0, 9.1, 9.8, 10.4, 10.7, 11.4, 12.1, 12.5, 12.5…
#> $ tpr       <dbl> 8.1, 8.3, 8.7, 8.9, 9.0, 9.4, 9.4, 9.9, 10.0, 10.4, 10.3, 10…
#> $ stddv     <dbl> 9, 11, 11, 31, 11, 9, 13, 19, 13, 6, 7, 5, NA, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 2.3, 1.6, 0.0, 0.0, 0.0, …
#> $ tss5cm    <dbl> 8.5, 8.5, 8.6, 8.8, 9.1, 9.5, 10.1, 10.4, 11.2, 11.4, 11.4, …
#> $ pacutp    <dbl> 0.00, 0.02, 0.00, 0.00, 0.00, 0.00, 0.05, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 9.6, 9.6, 9.6, 9.5, 9.5, 9.6, 9.6, 9.7, 9.9, 10.0, 10.2, 10.…
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 80, 91, 111,…
```
