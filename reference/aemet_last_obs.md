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
#> $ fint      <dttm> 2026-06-02 09:00:00, 2026-06-02 10:00:00, 2026-06-02 11:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 13.4, 14.2, 14.3, 13.7, 14.3, 12.5, 12.1, 13.4, 13.4, 13.7, …
#> $ vv        <dbl> 9.0, 9.4, 8.6, 9.2, 8.7, 7.2, 6.8, 7.1, 7.8, 6.5, 6.8, 8.9, …
#> $ dv        <dbl> 316, 313, 317, 316, 316, 323, 328, 332, 327, 332, 329, 321, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 303, 313, 310, 313, 313, 320, 323, 310, 330, 313, 335, 320, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.7, 986.1, 986.1, 986.0, 985.7, 985.7, 985.5, 985.7, 986.…
#> $ hr        <dbl> 41, 45, 43, 41, 40, 40, 39, 40, 40, 44, 47, 52, 42, 34, 27, …
#> $ stdvv     <dbl> 1.6, 1.6, 1.7, 1.7, 1.8, 1.8, 1.4, 1.9, 1.7, 1.5, 1.9, 1.5, …
#> $ ts        <dbl> 27.8, 29.3, 29.8, 31.6, 31.8, 36.5, 35.6, 33.5, 29.1, 25.7, …
#> $ pres_nmar <dbl> 1014.6, 1014.9, 1014.8, 1014.6, 1014.3, 1014.2, 1014.1, 1014…
#> $ tamin     <dbl> 22.0, 23.5, 24.5, 25.0, 25.8, 26.0, 26.0, 25.6, 24.1, 23.0, …
#> $ ta        <dbl> 23.5, 24.5, 25.1, 26.0, 26.3, 27.0, 26.5, 25.6, 24.1, 23.0, …
#> $ tamax     <dbl> 23.7, 24.6, 25.2, 26.0, 26.6, 27.0, 27.1, 26.8, 25.7, 24.1, …
#> $ tpr       <dbl> 9.4, 11.8, 11.7, 11.7, 11.7, 12.2, 11.4, 11.0, 9.7, 10.0, 9.…
#> $ stddv     <dbl> 11, 10, 11, 10, 12, 13, 16, 18, 13, 15, 13, 9, NA, NA, NA, N…
#> $ inso      <dbl> 60.0, 60.0, 54.9, 46.3, 24.2, 36.1, 55.6, 59.5, 60.0, 60.0, …
#> $ tss5cm    <dbl> 27.0, 28.0, 29.0, 29.8, 30.9, 31.5, 32.6, 33.2, 33.1, 32.3, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 27.9, 27.7, 27.6, 27.7, 27.8, 27.9, 28.2, 28.4, 28.7, 29.0, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 48, 74, 86, …
```
