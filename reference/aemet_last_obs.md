# Latest observations from weather stations

Retrieves the latest observations for one or more weather stations.

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
  [tibble](https://tibble.tidyverse.org/reference/tibble.html). The
  [sf](https://CRAN.R-project.org/package=sf) package must be installed.

- extract_metadata:

  Logical. If `TRUE`, the output is a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html) with the
  description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical. Displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE`, it will not be displayed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object.

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
obs <- aemet_last_obs(c("9434", "3195"))
dplyr::glimpse(obs)
#> Rows: 24
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-06-18 20:00:00, 2026-06-18 21:00:00, 2026-06-18 22:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 8.3, 9.2, 9.0, 9.1, 9.5, 7.7, 7.9, 6.6, 5.3, 3.2, 4.9, 7.0, …
#> $ vv        <dbl> 5.4, 6.2, 5.0, 6.1, 5.5, 4.7, 4.2, 4.0, 2.3, 1.9, 1.9, 4.5, …
#> $ dv        <dbl> 112, 121, 109, 120, 120, 110, 109, 118, 115, 118, 114, 134, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 115, 118, 118, 130, 133, 100, 113, 118, 120, 85, 135, 130, 1…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.2, 985.9, 986.4, 986.7, 986.7, 986.8, 987.1, 987.1, 987.…
#> $ hr        <dbl> 23, 26, 33, 34, 36, 40, 43, 46, 48, 51, 45, 37, 25, 27, 35, …
#> $ stdvv     <dbl> 1.0, 1.1, 0.8, 1.0, 0.9, 0.8, 0.7, 0.6, 0.3, 0.3, 0.4, 1.1, …
#> $ ts        <dbl> 28.5, 26.9, 25.0, 24.2, 23.5, 22.6, 22.1, 21.2, 20.4, 20.1, …
#> $ pres_nmar <dbl> 1013.5, 1014.4, 1015.1, 1015.5, 1015.6, 1015.7, 1016.1, 1016…
#> $ tamin     <dbl> 29.6, 27.8, 25.7, 24.7, 24.0, 23.3, 22.8, 22.1, 21.5, 20.9, …
#> $ ta        <dbl> 29.6, 27.8, 25.7, 24.7, 24.0, 23.3, 22.8, 22.1, 21.5, 20.9, …
#> $ tamax     <dbl> 31.3, 29.6, 27.8, 25.7, 24.8, 24.0, 23.3, 22.8, 22.2, 21.5, …
#> $ tpr       <dbl> 6.2, 6.5, 8.3, 7.8, 8.0, 8.9, 9.6, 9.9, 10.0, 10.4, 10.4, 9.…
#> $ stddv     <dbl> 10, 8, 9, 11, 7, 10, 10, 8, 9, 12, 14, 12, 19, 20, 28, 16, 1…
#> $ inso      <dbl> 8.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 46.4, 60.0…
#> $ tss5cm    <dbl> 37.9, 36.5, 35.2, 34.2, 33.3, 32.5, 31.8, 31.2, 30.7, 30.1, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 34.3, 34.3, 34.3, 34.1, 33.9, 33.6, 33.4, 33.1, 32.8, 32.5, …
```
