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
#> $ fint      <dttm> 2026-06-09 08:00:00, 2026-06-09 09:00:00, 2026-06-09 10:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 14.3, 13.6, 13.2, 12.8, 11.4, 11.6, 15.3, 11.8, 12.1, 14.1, …
#> $ vv        <dbl> 10.1, 9.3, 8.8, 8.0, 8.5, 8.4, 8.8, 8.4, 8.7, 9.8, 10.2, 10.…
#> $ dv        <dbl> 314, 314, 307, 316, 309, 312, 309, 314, 314, 311, 315, 313, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 300, 305, 313, 305, 313, 318, 310, 295, 310, 295, 325, 315, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 990.6, 990.3, 990.0, 989.7, 989.0, 988.4, 987.9, 987.3, 987.…
#> $ hr        <dbl> 58, 53, 46, 44, 40, 36, 34, 33, 35, 37, 42, 46, 50, 45, 39, …
#> $ stdvv     <dbl> 1.9, 1.5, 1.1, 1.2, 1.3, 1.4, 1.2, 1.3, 1.3, 1.5, 1.7, 1.9, …
#> $ ts        <dbl> 22.3, 25.8, 28.8, 30.2, 32.2, 34.1, 34.0, 34.9, 32.4, 29.9, …
#> $ pres_nmar <dbl> 1020.0, 1019.5, 1019.0, 1018.7, 1017.9, 1017.2, 1016.6, 1016…
#> $ tamin     <dbl> 18.5, 19.7, 21.2, 23.0, 23.5, 24.5, 25.4, 26.1, 25.7, 24.8, …
#> $ ta        <dbl> 19.7, 21.3, 23.3, 23.5, 24.6, 25.4, 26.3, 26.4, 25.9, 24.8, …
#> $ tamax     <dbl> 19.7, 21.4, 23.3, 23.6, 24.8, 25.8, 26.3, 26.6, 26.7, 26.0, …
#> $ tpr       <dbl> 11.2, 11.3, 11.0, 10.5, 10.0, 9.3, 9.2, 8.8, 9.3, 9.2, 9.0, …
#> $ stddv     <dbl> 8, 8, 8, 8, 9, 10, 9, 10, 10, 9, 11, 9, NA, NA, NA, NA, NA, …
#> $ inso      <dbl> 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 43, NA, NA, NA, …
#> $ tss5cm    <dbl> 26.3, 26.8, 27.8, 29.2, 30.7, 32.3, 33.5, 34.2, 34.6, 34.2, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 28.1, 27.9, 27.7, 27.7, 27.7, 27.9, 28.1, 28.4, 28.8, 29.1, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 164, 141, 10…
```
