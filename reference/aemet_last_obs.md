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
a [sf](https://CRAN.R-project.org/package=sf) object.

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
#> $ fint      <dttm> 2026-04-29 01:00:00, 2026-04-29 02:00:00, 2026-04-29 03:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 10.5, 6.0, 6.5, 6.1, 5.4, 6.2, 8.5, 8.5, 7.6, 7.6, 10.1, 9.8…
#> $ vv        <dbl> 3.6, 3.3, 4.0, 3.3, 2.9, 3.9, 3.2, 5.4, 3.9, 4.7, 6.2, 5.9, …
#> $ dv        <dbl> 124, 103, 110, 108, 112, 121, 148, 116, 140, 121, 121, 107, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 120, 125, 123, 108, 123, 125, 110, 108, 120, 130, 113, 128, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 980.9, 980.5, 980.5, 980.4, 980.3, 980.8, 981.5, 981.5, 982.…
#> $ hr        <dbl> 69, 69, 71, 74, 75, 75, 79, 86, 84, 77, 57, 58, 55, 73, 75, …
#> $ stdvv     <dbl> 0.6, 0.6, 0.9, 0.5, 0.5, 0.6, 0.8, 1.0, 0.7, 0.8, 1.4, 1.2, …
#> $ ts        <dbl> 15.5, 15.1, 14.8, 14.8, 14.6, 15.4, 15.6, 16.3, 16.8, 24.5, …
#> $ pres_nmar <dbl> 1010.4, 1010.0, 1010.0, 1009.9, 1009.9, 1010.3, 1011.0, 1011…
#> $ tamin     <dbl> 16.2, 15.8, 15.7, 15.6, 15.3, 15.3, 15.6, 15.2, 15.4, 15.9, …
#> $ ta        <dbl> 16.2, 16.0, 15.9, 15.6, 15.3, 15.7, 15.6, 15.4, 15.9, 18.2, …
#> $ tamax     <dbl> 17.4, 16.2, 16.0, 15.9, 15.6, 15.7, 15.9, 15.6, 16.0, 18.2, …
#> $ tpr       <dbl> 10.5, 10.3, 10.6, 11.0, 10.9, 11.2, 12.0, 13.1, 13.2, 14.1, …
#> $ stddv     <dbl> 15, 11, 9, 12, 9, 11, 15, 9, 13, 15, 17, 12, 19, NA, NA, NA,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.0, 0.0, 20.5, 59.0, 58.…
#> $ tss5cm    <dbl> 23.4, 23.0, 22.5, 22.1, 21.7, 21.4, 21.2, 21.1, 21.2, 21.4, …
#> $ pacutp    <dbl> 0.10, 0.22, 0.13, 0.00, 0.00, 0.02, 0.11, 0.20, 0.05, 0.03, …
#> $ tss20cm   <dbl> 24.3, 24.1, 23.9, 23.7, 23.5, 23.3, 23.1, 22.9, 22.7, 22.5, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 44, 61, …
```
