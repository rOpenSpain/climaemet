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
#> Rows: 24
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-06-07 18:00:00, 2026-06-07 19:00:00, 2026-06-07 20:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 9.3, 12.0, 10.0, 8.6, 8.3, 9.0, 7.5, 6.2, 4.8, 4.8, 4.7, 2.8…
#> $ vv        <dbl> 6.1, 7.0, 4.8, 6.0, 5.9, 3.9, 4.2, 3.3, 3.0, 3.0, 2.4, 1.3, …
#> $ dv        <dbl> 112, 128, 126, 115, 113, 105, 113, 112, 128, 137, 130, 111, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 105, 125, 118, 120, 115, 95, 125, 118, 145, 143, 150, 148, 1…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 987.8, 988.4, 988.6, 989.2, 989.3, 989.5, 989.4, 989.4, 989.…
#> $ hr        <dbl> 33, 38, 42, 51, 56, 60, 62, 65, 66, 67, 67, 69, 22, 25, 27, …
#> $ stdvv     <dbl> 1.0, 1.4, 0.9, 0.8, 0.9, 0.7, 0.7, 0.4, 0.5, 0.6, 0.5, 0.3, …
#> $ ts        <dbl> 32.1, 29.0, 26.3, 25.1, 23.8, 21.9, 21.3, 20.4, 19.6, 19.0, …
#> $ pres_nmar <dbl> 1016.0, 1016.8, 1017.2, 1018.0, 1018.2, 1018.6, 1018.5, 1018…
#> $ tamin     <dbl> 30.6, 28.6, 26.6, 25.0, 23.7, 22.5, 21.8, 21.2, 20.5, 19.9, …
#> $ ta        <dbl> 30.6, 28.6, 26.6, 25.0, 23.7, 22.5, 21.8, 21.2, 20.5, 19.9, …
#> $ tamax     <dbl> 31.8, 30.6, 28.6, 26.6, 25.0, 23.7, 22.5, 21.8, 21.2, 20.5, …
#> $ tpr       <dbl> 12.5, 12.8, 12.6, 14.1, 14.4, 14.3, 14.2, 14.3, 13.9, 13.6, …
#> $ stddv     <dbl> 10, 9, 10, 8, 8, 10, 9, 8, 10, 10, 11, 15, NA, NA, NA, NA, N…
#> $ inso      <dbl> 49.3, 48.4, 3.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.9…
#> $ tss5cm    <dbl> 36.5, 35.2, 33.8, 32.5, 31.6, 30.7, 29.9, 29.2, 28.6, 28.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 29.6, 29.9, 30.2, 30.2, 30.2, 30.1, 30.0, 29.8, 29.6, 29.3, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 66, 67, 67, …
```
