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
a [sf](https://CRAN.R-project.org/package=sf) object

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
#> $ fint      <dttm> 2026-03-23 19:00:00, 2026-03-23 20:00:00, 2026-03-23 21:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.6, 6.0, 5.4, 4.5, 6.3, 5.2, 3.5, 4.1, 3.3, 2.1, 2.3, 2.7, …
#> $ vv        <dbl> 3.8, 3.9, 3.3, 2.5, 4.3, 2.9, 2.0, 1.6, 1.3, 0.9, 1.3, 0.9, …
#> $ dv        <dbl> 291, 280, 296, 288, 272, 298, 298, 295, 272, 322, 248, 356, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 275, 293, 285, 285, 275, 273, 280, 298, 225, 260, 243, 265, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 989.0, 989.9, 990.7, 991.2, 991.4, 991.9, 992.3, 992.3, 992.…
#> $ hr        <dbl> 45, 51, 56, 60, 60, 61, 66, 69, 74, 75, 77, 81, 32, 39, 40, …
#> $ stdvv     <dbl> 0.5, 0.4, 0.5, 0.4, 0.5, 0.6, 0.3, 0.3, 0.1, 0.4, 0.4, 0.1, …
#> $ ts        <dbl> 13.8, 12.0, 11.3, 9.9, 9.6, 9.3, 8.0, 7.1, 5.1, 4.2, 3.5, 2.…
#> $ pres_nmar <dbl> 1018.9, 1020.0, 1021.0, 1021.6, 1021.9, 1022.4, 1023.0, 1023…
#> $ tamin     <dbl> 15.0, 13.4, 12.2, 11.2, 10.7, 10.2, 9.2, 8.3, 7.0, 6.6, 6.0,…
#> $ ta        <dbl> 15.0, 13.4, 12.2, 11.2, 10.8, 10.4, 9.2, 8.3, 7.0, 6.6, 6.0,…
#> $ tamax     <dbl> 17.0, 15.0, 13.4, 12.2, 11.2, 10.8, 10.4, 9.2, 8.3, 7.0, 6.6…
#> $ tpr       <dbl> 3.2, 3.4, 3.6, 3.8, 3.4, 3.2, 3.2, 2.9, 2.7, 2.5, 2.3, 2.3, …
#> $ stddv     <dbl> 10, 7, 9, 9, 5, 11, 11, 12, 13, 29, 17, 8, NA, NA, NA, NA, N…
#> $ inso      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss5cm    <dbl> 16.6, 15.7, 14.9, 14.2, 13.7, 13.2, 12.7, 12.3, 11.8, 11.4, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 14.9, 15.0, 15.0, 14.9, 14.7, 14.6, 14.4, 14.2, 14.0, 13.8, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 60, 90, 136,…
```
