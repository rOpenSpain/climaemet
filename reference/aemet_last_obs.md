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
#> $ fint      <dttm> 2026-06-01 10:00:00, 2026-06-01 11:00:00, 2026-06-01 12:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 7.6, 6.8, 6.6, 4.0, 3.7, 4.3, 4.8, 4.4, 3.5, 4.5, 4.2, 3.3, …
#> $ vv        <dbl> 5.4, 3.2, 1.3, 1.3, 1.7, 2.6, 2.9, 1.8, 1.5, 2.9, 2.5, 2.1, …
#> $ dv        <dbl> 299, 320, 303, 259, 78, 79, 129, 124, 249, 328, 319, 293, 33…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 285, 320, 305, 320, 308, 103, 125, 98, 80, 313, 325, 243, 33…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.4, 987.9, 986.9, 985.7, 984.8, 983.7, 982.9, 982.4, 982.…
#> $ hr        <dbl> 28, 27, 22, 20, 17, 19, 20, 21, 20, 29, 29, 34, 34, 29, 21, …
#> $ stdvv     <dbl> 0.7, 1.0, 0.9, 0.4, 0.5, 0.7, 0.6, 0.4, 0.5, 0.5, 0.5, 0.2, …
#> $ ts        <dbl> 31.2, 33.7, 39.8, 43.4, 45.0, 44.5, 40.2, 39.6, 33.8, 30.6, …
#> $ pres_nmar <dbl> 1017.3, 1016.7, 1015.5, 1014.0, 1013.0, 1011.7, 1010.9, 1010…
#> $ tamin     <dbl> 21.5, 23.8, 25.5, 27.5, 29.7, 31.0, 31.9, 32.3, 32.5, 30.5, …
#> $ ta        <dbl> 24.1, 25.5, 27.6, 29.8, 31.0, 32.1, 32.3, 32.9, 32.7, 30.5, …
#> $ tamax     <dbl> 24.1, 25.5, 27.7, 29.8, 31.1, 32.4, 32.5, 33.1, 32.9, 32.7, …
#> $ tpr       <dbl> 4.5, 5.1, 3.9, 4.5, 3.0, 5.6, 6.5, 7.7, 6.8, 10.4, 9.4, 10.0…
#> $ stddv     <dbl> 12, 20, 84, 67, 30, 20, 11, 30, 34, 10, 9, 6, NA, NA, NA, NA…
#> $ inso      <dbl> 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 57.5, 56.4, 3.8, 0.0, 0.…
#> $ tss5cm    <dbl> 27.1, 28.6, 30.4, 32.5, 34.3, 35.6, 36.1, 35.9, 35.2, 34.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 26.9, 26.9, 26.9, 27.1, 27.5, 27.9, 28.4, 28.9, 29.4, 29.7, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 44, 51, 78, …
```
