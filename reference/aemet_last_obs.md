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
#> $ fint      <dttm> 2025-12-14 11:00:00, 2025-12-14 12:00:00, 2025-12-14 13:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.2, 2.4, 3.2, 3.5, 4.7, 3.8, 3.0, 4.6, 3.2, 2.8, 2.5, 2.1, …
#> $ vv        <dbl> 1.1, 1.3, 1.4, 1.2, 3.1, 1.7, 1.8, 2.2, 1.4, 1.2, 1.3, 1.2, …
#> $ dv        <dbl> 84, 109, 77, 110, 131, 103, 106, 145, 96, 109, 101, 117, 125…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 98, 88, 93, 95, 133, 128, 123, 298, 110, 105, 100, 105, 123,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 996.3, 995.4, 994.5, 993.7, 993.2, 992.8, 992.5, 992.4, 992.…
#> $ hr        <dbl> 99, 98, 96, 91, 86, 87, 90, 90, 93, 96, 97, 98, 97, NA, NA, …
#> $ stdvv     <dbl> 0.3, 0.3, 0.3, 0.4, 0.6, 0.3, 0.4, 0.4, 0.3, 0.2, 0.2, 0.2, …
#> $ ts        <dbl> 7.0, 7.5, 8.2, 9.2, 9.6, 9.7, 8.6, 7.4, 6.5, 5.4, 5.1, 6.1, …
#> $ pres_nmar <dbl> 1027.3, 1026.3, 1025.3, 1024.5, 1023.9, 1023.4, 1023.2, 1023…
#> $ tamin     <dbl> 5.1, 5.9, 6.5, 7.2, 8.1, 8.9, 8.8, 8.1, 7.1, 6.3, 5.8, 5.7, …
#> $ ta        <dbl> 5.9, 6.5, 7.2, 8.1, 9.2, 9.2, 8.8, 8.1, 7.1, 6.3, 5.8, 6.0, …
#> $ tamax     <dbl> 5.9, 6.5, 7.2, 8.1, 9.2, 9.2, 9.3, 9.2, 8.1, 7.1, 6.4, 6.0, …
#> $ tpr       <dbl> 5.8, 6.2, 6.5, 6.7, 7.0, 7.1, 7.3, 6.5, 6.1, 5.8, 5.3, 5.8, …
#> $ stddv     <dbl> 15, 21, 16, 17, 13, 12, 9, 10, 12, 18, 10, 9, 7, NA, NA, NA,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 2.1, 22.8, 26.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0…
#> $ tss5cm    <dbl> 7.5, 8.1, 8.4, 8.8, 9.1, 9.2, 9.1, 8.8, 8.5, 8.1, 7.8, 7.6, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 8.9, 8.9, 8.9, 9.0, 9.1, 9.2, 9.3, 9.4, 9.4, 9.5, 9.4, 9.4, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 78, 79, …
```
