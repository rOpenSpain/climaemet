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
#> Rows: 26
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2025-12-15 09:00:00, 2025-12-15 10:00:00, 2025-12-15 11:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 1.9, 2.0, 2.4, 2.5, 1.8, 2.8, 1.9, 2.6, 3.0, 1.5, 2.2, 2.2, …
#> $ vv        <dbl> 1.0, 1.4, 1.1, 1.6, 0.9, 1.3, 1.0, 1.1, 0.4, 0.2, 1.9, 1.5, …
#> $ dv        <dbl> 53, 87, 37, 108, 358, 303, 47, 57, 150, 233, 120, 110, 118, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 98, 75, 95, 113, 350, 305, 318, 73, 340, 113, 113, 125, 110,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.9, 985.8, 985.1, 984.0, 982.8, 981.8, 981.2, 980.6, 980.…
#> $ hr        <dbl> 100, 100, 100, 100, 100, 99, 99, 99, 98, 99, 100, 99, 98, NA…
#> $ stdvv     <dbl> 0.3, 0.2, 0.3, 0.3, 0.3, 0.2, 0.3, 0.3, 0.2, 0.2, 0.2, 0.2, …
#> $ ts        <dbl> 8.2, 8.6, 9.1, 9.5, 10.0, 10.3, 10.6, 10.2, 9.1, 9.4, 9.7, 9…
#> $ pres_nmar <dbl> 1016.5, 1016.3, 1015.5, 1014.4, 1013.1, 1012.0, 1011.4, 1010…
#> $ tamin     <dbl> 7.5, 7.8, 8.2, 8.7, 9.0, 9.3, 9.7, 10.1, 9.9, 9.6, 9.6, 9.8,…
#> $ ta        <dbl> 7.8, 8.2, 8.7, 9.0, 9.3, 9.7, 10.1, 10.1, 9.9, 9.6, 9.8, 9.9…
#> $ tamax     <dbl> 7.8, 8.2, 8.8, 9.0, 9.3, 9.7, 10.1, 10.2, 10.3, 9.9, 9.8, 10…
#> $ tpr       <dbl> 7.8, 8.3, 8.7, 9.0, 9.3, 9.6, 9.9, 9.9, 9.6, 9.4, 9.8, 9.8, …
#> $ stddv     <dbl> 18, 14, 24, 12, 20, 8, 20, 16, 71, 79, 8, 10, 9, NA, NA, NA,…
#> $ inso      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss5cm    <dbl> 8.2, 8.5, 8.8, 9.0, 9.3, 9.5, 9.7, 9.9, 9.8, 9.5, 9.5, 9.5, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 9.1, 9.1, 9.1, 9.2, 9.2, 9.3, 9.4, 9.5, 9.6, 9.7, 9.8, 9.8, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 48, 60, …
```
