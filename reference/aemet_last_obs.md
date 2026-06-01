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
#> $ fint      <dttm> 2026-06-01 05:00:00, 2026-06-01 06:00:00, 2026-06-01 07:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 9.4, 9.3, 9.4, 8.2, 8.2, 7.6, 6.8, 6.6, 4.0, 3.7, 4.3, 4.8, …
#> $ vv        <dbl> 7.5, 7.2, 6.1, 5.7, 5.2, 5.4, 3.2, 1.3, 1.3, 1.7, 2.6, 2.9, …
#> $ dv        <dbl> 281, 288, 313, 315, 314, 299, 320, 303, 259, 78, 79, 129, 27…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 285, 275, 290, 308, 308, 285, 320, 305, 320, 308, 103, 125, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.9, 989.1, 989.2, 989.2, 988.9, 988.4, 987.9, 986.9, 985.…
#> $ hr        <dbl> 47, 40, 43, 33, 34, 28, 27, 22, 20, 17, 19, 20, 52, 52, 50, …
#> $ stdvv     <dbl> 0.8, 0.8, 0.8, 0.9, 0.7, 0.7, 1.0, 0.9, 0.4, 0.5, 0.7, 0.6, …
#> $ ts        <dbl> 17.2, 18.9, 21.1, 24.5, 28.3, 31.2, 33.7, 39.8, 43.4, 45.0, …
#> $ pres_nmar <dbl> 1018.6, 1018.7, 1018.7, 1018.6, 1018.1, 1017.3, 1016.7, 1015…
#> $ tamin     <dbl> 16.8, 17.1, 18.2, 18.7, 20.4, 21.5, 23.8, 25.5, 27.5, 29.7, …
#> $ ta        <dbl> 17.1, 18.2, 18.7, 20.4, 21.6, 24.1, 25.5, 27.6, 29.8, 31.0, …
#> $ tamax     <dbl> 17.1, 18.3, 18.7, 20.4, 21.6, 24.1, 25.5, 27.7, 29.8, 31.1, …
#> $ tpr       <dbl> 5.6, 4.3, 5.9, 3.6, 5.1, 4.5, 5.1, 3.9, 4.5, 3.0, 5.6, 6.5, …
#> $ stddv     <dbl> 6, 9, 9, 8, 9, 12, 20, 84, 67, 30, 20, 11, NA, NA, NA, NA, N…
#> $ inso      <dbl> 0.8, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 6…
#> $ tss5cm    <dbl> 25.4, 25.0, 24.9, 25.1, 25.8, 27.1, 28.6, 30.4, 32.5, 34.3, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 28.0, 27.8, 27.5, 27.2, 27.0, 26.9, 26.9, 26.9, 27.1, 27.5, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 82, 84, 84, …
```
