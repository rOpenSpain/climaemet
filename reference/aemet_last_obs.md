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
#> $ fint      <dttm> 2026-02-24 07:00:00, 2026-02-24 08:00:00, 2026-02-24 09:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.4, 2.9, 3.5, 3.6, 3.6, 4.3, 5.0, 5.2, 5.9, 6.1, 5.4, 4.6, …
#> $ vv        <dbl> 2.5, 1.6, 2.1, 2.0, 1.9, 2.6, 3.3, 3.5, 4.1, 3.5, 2.9, 3.2, …
#> $ dv        <dbl> 120, 123, 120, 102, 110, 96, 95, 118, 113, 103, 115, 129, 47…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 118, 120, 123, 108, 103, 98, 98, 120, 103, 113, 113, 140, 44…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 992.3, 992.4, 992.4, 992.1, 991.5, 990.7, 989.5, 988.4, 987.…
#> $ hr        <dbl> 84, 79, 75, 69, 61, 51, 47, 42, 40, 40, 42, 47, 60, 62, 54, …
#> $ stdvv     <dbl> 0.3, 0.3, 0.4, 0.5, 0.6, 0.6, 0.5, 0.6, 0.5, 0.7, 0.5, 0.4, …
#> $ ts        <dbl> 5.3, 9.2, 10.9, 14.4, 17.2, 19.5, 20.6, 22.0, 22.2, 22.0, 18…
#> $ pres_nmar <dbl> 1023.2, 1023.2, 1023.0, 1022.5, 1021.6, 1020.5, 1019.1, 1017…
#> $ tamin     <dbl> 6.1, 6.0, 7.6, 9.3, 11.4, 13.7, 16.5, 18.1, 19.7, 20.6, 19.9…
#> $ ta        <dbl> 6.1, 7.6, 9.3, 11.4, 13.7, 16.5, 18.1, 19.7, 20.6, 21.2, 19.…
#> $ tamax     <dbl> 6.4, 7.6, 9.3, 11.4, 13.7, 16.5, 18.1, 19.7, 20.6, 21.2, 21.…
#> $ tpr       <dbl> 3.6, 4.1, 5.1, 5.9, 6.2, 6.4, 6.5, 6.4, 6.5, 7.0, 6.5, 6.4, …
#> $ stddv     <dbl> 7, 13, 14, 15, 22, 13, 10, 12, 12, 12, 8, 8, NA, NA, NA, NA,…
#> $ inso      <dbl> 0.0, 51.5, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 4…
#> $ tss5cm    <dbl> 8.5, 8.3, 8.8, 9.5, 11.2, 12.9, 14.3, 15.5, 16.3, 16.6, 16.3…
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 10.7, 10.5, 10.4, 10.2, 10.2, 10.3, 10.5, 10.9, 11.3, 11.7, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 78, 85, 73, …
```
