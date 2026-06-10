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
#> $ fint      <dttm> 2026-06-10 02:00:00, 2026-06-10 03:00:00, 2026-06-10 04:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 13.8, 15.4, 14.0, 12.9, 13.2, 14.6, 14.3, 14.3, 14.1, 15.7, …
#> $ vv        <dbl> 9.9, 9.0, 9.5, 8.3, 8.0, 9.0, 9.2, 8.9, 9.4, 9.3, 8.3, 8.2, …
#> $ dv        <dbl> 305, 302, 301, 304, 307, 312, 318, 314, 316, 311, 315, 324, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 298, 298, 310, 293, 308, 313, 313, 298, 305, 305, 310, 310, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 990.0, 990.3, 990.7, 991.2, 991.6, 991.9, 992.1, 992.0, 992.…
#> $ hr        <dbl> 56, 57, 57, 57, 56, 54, 49, 47, 42, 36, 30, 27, 30, 50, 56, …
#> $ stdvv     <dbl> 1.5, 1.2, 1.1, 1.4, 1.3, 1.6, 1.6, 2.0, 1.9, 2.1, 1.7, 1.6, …
#> $ ts        <dbl> 15.1, 14.8, 14.6, 14.5, 15.7, 17.9, 20.6, 23.5, 25.5, 27.1, …
#> $ pres_nmar <dbl> 1020.0, 1020.3, 1020.7, 1021.2, 1021.6, 1021.8, 1021.9, 1021…
#> $ tamin     <dbl> 14.5, 14.3, 14.2, 14.1, 14.2, 14.7, 15.8, 17.1, 18.4, 19.4, …
#> $ ta        <dbl> 14.6, 14.3, 14.2, 14.3, 14.8, 15.8, 17.1, 18.5, 19.5, 21.2, …
#> $ tamax     <dbl> 15.0, 14.6, 14.3, 14.3, 14.8, 15.9, 17.2, 18.5, 19.5, 21.2, …
#> $ tpr       <dbl> 5.9, 5.9, 5.8, 5.9, 6.1, 6.5, 6.2, 7.0, 6.2, 5.5, 3.9, 3.2, …
#> $ stddv     <dbl> 8, 7, 6, 7, 9, 10, 10, 11, 12, 11, 11, 14, 11, NA, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 11.2, 57.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.…
#> $ tss5cm    <dbl> 26.1, 25.5, 24.9, 24.5, 24.1, 23.9, 24.1, 24.9, 26.0, 27.4, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 28.7, 28.5, 28.2, 27.9, 27.6, 27.3, 27.0, 26.8, 26.6, 26.5, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 107, 107…
```
