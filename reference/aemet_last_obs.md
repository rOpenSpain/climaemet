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
#> $ fint      <dttm> 2026-03-22 04:00:00, 2026-03-22 05:00:00, 2026-03-22 06:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.0, 1.8, 2.3, 1.7, 1.5, 4.5, 8.8, 8.6, 8.4, 9.8, 10.7, 12.5…
#> $ vv        <dbl> 1.6, 0.9, 0.9, 0.5, 0.4, 3.2, 5.8, 5.8, 5.2, 6.1, 6.1, 8.4, …
#> $ dv        <dbl> 218, 14, 226, 7, 182, 316, 292, 314, 316, 323, 321, 308, 60,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 208, 20, 280, 13, 53, 323, 283, 330, 313, 310, 315, 308, 65,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 982.0, 982.2, 982.3, 982.9, 982.6, 982.8, 982.5, 982.1, 981.…
#> $ hr        <dbl> 79, 85, 83, 85, 75, 67, 53, 47, 39, 31, 25, 27, 91, 93, 95, …
#> $ stdvv     <dbl> 0.1, 0.1, 0.3, 0.2, 0.2, 0.5, 0.9, 1.1, 0.7, 1.2, 1.2, 1.0, …
#> $ ts        <dbl> 4.0, 2.7, 2.8, 5.0, 9.9, 12.3, 14.4, 16.9, 19.5, 21.5, 21.7,…
#> $ pres_nmar <dbl> 1012.8, 1013.0, 1013.1, 1013.7, 1013.2, 1013.1, 1012.5, 1011…
#> $ tamin     <dbl> 5.5, 4.5, 4.1, 3.9, 4.4, 7.1, 9.7, 12.3, 14.0, 16.3, 18.0, 1…
#> $ ta        <dbl> 5.5, 4.5, 4.1, 4.4, 7.2, 9.7, 12.4, 14.0, 16.3, 18.1, 18.8, …
#> $ tamax     <dbl> 5.8, 5.5, 4.5, 4.4, 7.2, 9.7, 12.4, 14.0, 16.3, 18.3, 19.0, …
#> $ tpr       <dbl> 2.1, 2.3, 1.5, 2.1, 3.0, 3.9, 3.0, 2.9, 2.3, 0.6, -1.7, -0.3…
#> $ stddv     <dbl> 6, 10, 34, 29, 101, 10, 10, 10, 13, 13, 12, 10, NA, NA, NA, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 38.3, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.…
#> $ tss5cm    <dbl> 10.4, 10.1, 9.7, 9.4, 9.6, 10.3, 11.4, 12.7, 14.2, 15.7, 16.…
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 13.2, 12.9, 12.7, 12.5, 12.3, 12.1, 12.0, 12.0, 12.1, 12.3, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 45, 45, 22, …
```
