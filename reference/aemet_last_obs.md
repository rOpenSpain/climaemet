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
a [sf](https://CRAN.R-project.org/package=sf) object.

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
#> Rows: 26
#> Columns: 26
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-05-02 09:00:00, 2026-05-02 10:00:00, 2026-05-02 11:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.8, 1.2, 0.2, 0.0, 15.4, 0.2,…
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 9.7, 10.3, 9.5, 13.0, 13.1, 13.1, 8.4, 11.8, 12.3, 11.6, 15.…
#> $ vv        <dbl> 6.2, 6.6, 6.1, 8.8, 7.9, 7.0, 5.0, 6.9, 7.5, 3.6, 3.0, 3.3, …
#> $ dv        <dbl> 126, 121, 110, 112, 106, 113, 91, 103, 104, 81, 106, 103, 11…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 133, 120, 108, 118, 120, 130, 125, 113, 120, 105, 295, 120, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 990.8, 990.5, 989.5, 988.3, 987.3, 987.2, 986.3, 986.3, 985.…
#> $ hr        <dbl> 70, 69, 66, 59, 57, 56, 81, 81, 73, 73, 98, 98, 95, 97, 97, …
#> $ stdvv     <dbl> 1.1, 1.1, 1.2, 1.8, 1.4, 1.5, 0.8, 1.6, 1.8, 1.5, 1.9, 0.7, …
#> $ ts        <dbl> 24.4, 23.9, 26.2, 29.9, 25.6, 22.1, 16.6, 17.4, 18.2, 17.5, …
#> $ pres_nmar <dbl> 1020.3, 1019.9, 1018.8, 1017.4, 1016.4, 1016.4, 1015.8, 1015…
#> $ tamin     <dbl> 17.9, 19.0, 19.2, 20.6, 21.8, 21.0, 16.7, 17.2, 17.9, 18.4, …
#> $ ta        <dbl> 19.1, 19.4, 20.6, 22.2, 21.8, 21.0, 17.2, 17.9, 18.6, 18.5, …
#> $ tamax     <dbl> 19.1, 19.8, 20.6, 22.2, 22.7, 21.8, 21.0, 18.0, 18.6, 18.6, …
#> $ tpr       <dbl> 13.5, 13.6, 14.0, 13.9, 13.0, 11.9, 13.9, 14.6, 13.7, 13.6, …
#> $ stddv     <dbl> 11, 11, 13, 10, 12, 10, 14, 11, 11, 42, 80, 12, 9, NA, NA, N…
#> $ inso      <dbl> 22.7, 37.1, 24.4, 34.7, 22.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ tss5cm    <dbl> 19.7, 20.9, 21.7, 22.8, 24.6, 24.3, 22.9, 21.8, 21.5, 21.3, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 5.67, 1.19, 0.00, 0.00, …
#> $ tss20cm   <dbl> 20.3, 20.3, 20.3, 20.5, 20.7, 21.0, 21.3, 21.5, 21.5, 21.5, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 54, 68, …
```
