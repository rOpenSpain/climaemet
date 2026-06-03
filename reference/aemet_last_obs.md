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
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-06-03 01:00:00, 2026-06-03 02:00:00, 2026-06-03 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 11.2, 12.8, 10.6, 12.0, 11.9, 12.5, 12.1, 12.4, 13.3, 12.2, …
#> $ vv        <dbl> 8.4, 8.1, 7.6, 7.1, 8.0, 7.7, 7.8, 9.9, 8.5, 7.9, 6.1, 6.6, …
#> $ dv        <dbl> 300, 305, 300, 317, 312, 308, 316, 312, 306, 310, 312, 323, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 290, 305, 303, 295, 313, 318, 303, 303, 290, 303, 310, 320, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 990.1, 989.9, 989.9, 989.9, 990.2, 990.4, 990.6, 990.3, 989.…
#> $ hr        <dbl> 55, 59, 62, 63, 63, 60, 57, 49, 42, 38, 33, 29, 32, 40, 52, …
#> $ stdvv     <dbl> 1.1, 1.2, 1.2, 1.6, 1.1, 1.1, 1.5, 1.3, 1.5, 1.2, 1.0, 1.3, …
#> $ ts        <dbl> 17.6, 17.0, 16.3, 16.0, 15.9, 17.1, 19.7, 22.2, 25.4, 28.4, …
#> $ pres_nmar <dbl> 1019.8, 1019.6, 1019.7, 1019.7, 1020.0, 1020.2, 1020.3, 1019…
#> $ tamin     <dbl> 17.3, 16.7, 16.1, 15.9, 15.8, 15.8, 16.3, 17.2, 19.1, 20.6, …
#> $ ta        <dbl> 17.3, 16.7, 16.1, 15.9, 15.8, 16.3, 17.2, 19.1, 20.7, 22.0, …
#> $ tamax     <dbl> 17.8, 17.3, 16.7, 16.2, 15.9, 16.4, 17.3, 19.2, 20.8, 22.3, …
#> $ tpr       <dbl> 8.1, 8.7, 8.8, 8.9, 8.8, 8.5, 8.7, 8.1, 7.3, 7.0, 6.7, 5.9, …
#> $ stddv     <dbl> 7, 8, 8, 10, 7, 8, 10, 10, 11, 13, 14, 13, 10, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 15.7, 57.6, 60.0, 60.0, 60.0, 60.0, 60.0…
#> $ tss5cm    <dbl> 26.2, 25.7, 25.3, 24.8, 24.4, 24.1, 23.9, 24.2, 24.8, 26.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 28.4, 28.1, 27.9, 27.6, 27.4, 27.1, 26.8, 26.6, 26.4, 26.2, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 80, 85, …
```
