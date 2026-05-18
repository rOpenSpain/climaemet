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
  object? If `FALSE` (the default value), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  Note that you need to have the
  [sf](https://CRAN.R-project.org/package=sf) package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical. Display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE`, it will not be displayed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## API key

You need to set your API key globally using
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
#> $ fint      <dttm> 2026-05-18 10:00:00, 2026-05-18 11:00:00, 2026-05-18 12:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.9, 2.8, 3.7, 3.8, 4.8, 4.3, 5.4, 6.5, 6.8, 5.4, 3.6, 4.2, …
#> $ vv        <dbl> 0.9, 1.2, 1.9, 1.3, 2.1, 1.7, 2.1, 4.6, 3.3, 1.4, 2.7, 3.0, …
#> $ dv        <dbl> 174, 32, 97, 31, 80, 337, 328, 324, 326, 350, 316, 273, 98, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 313, 285, 83, 65, 63, 70, 298, 330, 310, 345, 310, 313, 16, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.3, 988.0, 987.4, 986.8, 986.3, 985.8, 985.8, 986.0, 986.…
#> $ hr        <dbl> 55, 47, 45, 41, 41, 33, 34, 42, 45, 46, 49, 56, 47, 43, 34, …
#> $ stdvv     <dbl> 0.4, 0.5, 0.6, 0.8, 0.9, 0.6, 0.7, 0.7, 0.6, 0.4, 0.3, 0.4, …
#> $ ts        <dbl> 26.9, 28.2, 32.1, 33.2, 32.8, 31.1, 28.8, 24.5, 23.9, 20.6, …
#> $ pres_nmar <dbl> 1017.8, 1017.3, 1016.6, 1015.8, 1015.3, 1014.6, 1014.6, 1015…
#> $ tamin     <dbl> 16.3, 18.0, 19.8, 21.1, 22.2, 23.0, 24.2, 22.9, 22.5, 21.6, …
#> $ ta        <dbl> 18.0, 19.9, 21.1, 22.6, 23.0, 24.2, 24.3, 22.9, 22.6, 21.6, …
#> $ tamax     <dbl> 18.0, 19.9, 21.2, 22.6, 23.0, 24.2, 25.1, 24.3, 22.9, 22.8, …
#> $ tpr       <dbl> 8.8, 8.3, 8.7, 8.7, 9.0, 6.8, 7.4, 9.3, 10.0, 9.4, 9.7, 10.2…
#> $ stddv     <dbl> 55, 52, 45, 78, 23, 23, 38, 10, 11, 21, 8, 5, NA, NA, NA, NA…
#> $ inso      <dbl> 60.0, 60.0, 60.0, 59.2, 33.5, 60.0, 40.9, 0.0, 4.3, 6.7, 0.0…
#> $ tss5cm    <dbl> 19.6, 21.1, 22.6, 24.5, 25.2, 25.9, 26.1, 25.6, 24.7, 24.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 19.1, 19.1, 19.3, 19.6, 20.0, 20.4, 20.8, 21.3, 21.6, 21.7, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 52, 74, 113,…
```
