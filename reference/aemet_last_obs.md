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
  or `"all"` for all the stations.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

- return_sf:

  Logical. If `TRUE`, the function returns an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object. If `FALSE` (the default value), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  The [sf](https://CRAN.R-project.org/package=sf) package must be
  installed.

- extract_metadata:

  Logical. If `TRUE`, the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical. Displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE`, it will not be displayed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## API key

You need to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).
Query timeout can be controlled with `options(climaemet_timeout = 60)`
(default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

AEMET data functions:
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
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-06-17 02:00:00, 2026-06-17 03:00:00, 2026-06-17 04:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.1, 5.9, 3.9, 3.3, 4.8, 4.3, 4.7, 4.7, 5.2, 5.3, 4.2, 4.6, …
#> $ vv        <dbl> 3.5, 2.9, 1.9, 1.8, 1.9, 2.8, 2.5, 2.8, 3.0, 2.4, 1.7, 2.2, …
#> $ dv        <dbl> 107, 113, 102, 64, 95, 92, 97, 97, 107, 94, 43, 103, 118, 77…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 113, 113, 110, 100, 118, 90, 90, 78, 115, 90, 90, 133, 125, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 989.1, 989.2, 989.3, 989.6, 990.1, 990.5, 990.6, 990.4, 990.…
#> $ hr        <dbl> 43, 45, 46, 54, 50, 47, 42, 37, 31, 27, 24, 18, 15, 39, 44, …
#> $ stdvv     <dbl> 0.5, 0.5, 0.3, 0.3, 0.4, 0.6, 0.6, 0.5, 0.7, 0.6, 0.5, 0.7, …
#> $ ts        <dbl> 23.2, 23.5, 21.9, 20.5, 25.2, 30.1, 35.8, 40.2, 44.5, 44.8, …
#> $ pres_nmar <dbl> 1018.0, 1018.1, 1018.3, 1018.8, 1019.1, 1019.3, 1019.2, 1018…
#> $ tamin     <dbl> 24.3, 23.9, 23.3, 21.7, 21.7, 23.6, 25.5, 27.2, 29.1, 31.1, …
#> $ ta        <dbl> 24.3, 24.0, 23.3, 21.7, 23.6, 25.5, 27.2, 29.1, 31.1, 32.7, …
#> $ tamax     <dbl> 24.9, 24.3, 24.0, 23.3, 23.6, 25.5, 27.2, 29.1, 31.1, 32.7, …
#> $ tpr       <dbl> 10.9, 11.3, 11.0, 12.0, 12.5, 13.4, 13.2, 13.0, 12.0, 11.2, …
#> $ stddv     <dbl> 8, 10, 11, 16, 13, 12, 17, 21, 13, 25, 36, 18, 23, 16, 19, 2…
#> $ inso      <dbl> 0, 0, 0, 2, 60, 60, 60, 60, 60, 60, 60, 60, 60, NA, NA, NA, …
#> $ tss5cm    <dbl> 31.4, 30.9, 30.5, 30.0, 29.5, 29.4, 30.0, 31.2, 32.9, 35.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 32.5, 32.2, 32.0, 31.7, 31.4, 31.2, 30.9, 30.8, 30.7, 30.7, …
```
