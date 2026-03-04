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
#> Rows: 26
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-03-04 00:00:00, 2026-03-04 01:00:00, 2026-03-04 02:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 1.5, 1.7, 2.5, 1.8, 1.7, 1.9, 1.6, 2.3, 2.5, 2.9, 3.2, 2.7, …
#> $ vv        <dbl> 1.0, 1.2, 1.1, 1.3, 0.1, 1.2, 0.9, 0.8, 1.9, 1.5, 1.7, 1.1, …
#> $ dv        <dbl> 198, 271, 247, 221, 233, 271, 293, 7, 282, 313, 303, 344, 29…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 220, 305, 240, 220, 223, 250, 245, 303, 280, 285, 300, 350, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 991.4, 991.1, 991.0, 990.5, 990.4, 990.3, 990.8, 990.9, 991.…
#> $ hr        <dbl> 90, 90, 93, 95, 93, 94, 98, 99, 97, 95, 93, 92, 85, 74, 75, …
#> $ stdvv     <dbl> 0.1, 0.2, 0.5, 0.2, 0.2, 0.2, 0.1, 0.2, 0.3, 0.2, 0.2, 0.3, …
#> $ ts        <dbl> 8.1, 7.3, 6.9, 7.0, 6.0, 5.9, 6.4, 6.7, 7.3, 8.4, 9.5, 10.9,…
#> $ pres_nmar <dbl> 1022.0, 1021.8, 1021.8, 1021.3, 1021.2, 1021.1, 1021.6, 1021…
#> $ tamin     <dbl> 9.3, 8.4, 7.6, 7.5, 7.1, 6.7, 6.6, 6.5, 6.3, 6.7, 7.8, 8.8, …
#> $ ta        <dbl> 9.3, 8.4, 7.7, 7.5, 7.1, 6.7, 6.8, 6.8, 6.8, 7.8, 8.8, 9.4, …
#> $ tamax     <dbl> 10.3, 9.3, 8.4, 7.7, 7.6, 7.1, 6.8, 6.8, 6.8, 7.8, 8.8, 9.4,…
#> $ tpr       <dbl> 7.7, 6.8, 6.7, 6.7, 6.1, 5.8, 6.5, 6.7, 6.4, 7.0, 7.7, 8.1, …
#> $ stddv     <dbl> 12, 10, 12, 11, 48, 13, 13, 49, 9, 15, 17, 15, 21, NA, NA, N…
#> $ inso      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss5cm    <dbl> 11.5, 11.2, 10.8, 10.5, 10.3, 10.0, 9.8, 9.7, 9.7, 9.9, 10.1…
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 12.8, 12.7, 12.5, 12.4, 12.2, 12.1, 11.9, 11.7, 11.6, 11.5, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 103, 103…
```
