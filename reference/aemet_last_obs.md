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
#> $ fint      <dttm> 2025-11-12 01:00:00, 2025-11-12 02:00:00, 2025-11-12 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.1, 6.7, 8.7, 7.6, 9.0, 3.9, 6.4, 7.5, 8.2, 9.1, 8.3, 9.2, …
#> $ vv        <dbl> 2.0, 4.4, 4.6, 5.0, 4.6, 2.5, 3.7, 5.1, 5.3, 5.8, 5.6, 6.1, …
#> $ dv        <dbl> 94, 107, 131, 128, 115, 85, 121, 129, 121, 129, 131, 124, 33…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 83, 113, 130, 130, 135, 93, 153, 133, 123, 128, 143, 120, 48…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.3, 985.3, 985.2, 985.4, 985.2, 985.4, 985.6, 986.1, 986.…
#> $ hr        <dbl> 92, 96, 96, 97, 94, 93, 92, 93, 91, 87, 82, 75, NA, NA, NA, …
#> $ stdvv     <dbl> 0.3, 0.8, 0.9, 1.0, 1.0, 0.5, 0.9, 1.0, 0.9, 1.1, 1.0, 1.1, …
#> $ ts        <dbl> 8.6, 11.2, 11.8, 11.8, 11.9, 10.6, 11.6, 12.3, 12.8, 13.9, 1…
#> $ pres_nmar <dbl> 1015.7, 1015.5, 1015.3, 1015.5, 1015.3, 1015.6, 1015.7, 1016…
#> $ tamin     <dbl> 9.5, 9.3, 11.2, 11.5, 11.9, 10.5, 10.4, 11.5, 12.2, 12.4, 13…
#> $ ta        <dbl> 9.5, 11.2, 11.7, 11.9, 12.0, 10.5, 11.5, 12.2, 12.4, 13.3, 1…
#> $ tamax     <dbl> 10.2, 11.2, 11.8, 11.9, 12.0, 12.0, 11.5, 12.2, 12.5, 13.3, …
#> $ tpr       <dbl> 8.3, 10.5, 11.1, 11.4, 11.1, 9.4, 10.3, 11.1, 11.0, 11.2, 12…
#> $ stddv     <dbl> 8, 10, 9, 10, 13, 11, 14, 10, 11, 9, 11, 12, NA, NA, NA, NA,…
#> $ inso      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 60, NA, NA, NA, NA, NA, NA…
#> $ tss5cm    <dbl> 11.7, 11.5, 11.8, 12.0, 12.1, 12.2, 12.1, 12.2, 12.4, 12.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 13.6, 13.5, 13.4, 13.3, 13.2, 13.2, 13.2, 13.2, 13.1, 13.2, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 116, 101, 12…
```
