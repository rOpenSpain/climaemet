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
a [sf](https://CRAN.R-project.org/package=sf) object

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
#> $ fint      <dttm> 2026-02-17 06:00:00, 2026-02-17 07:00:00, 2026-02-17 08:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 8.4, 8.4, 7.4, 8.0, 6.7, 6.2, 6.5, 6.2, 6.6, 6.3, 5.5, 5.7, …
#> $ vv        <dbl> 6.1, 5.5, 5.6, 5.9, 4.1, 3.8, 2.8, 3.8, 3.8, 4.7, 3.2, 4.5, …
#> $ dv        <dbl> 301, 315, 293, 281, 300, 316, 305, 303, 289, 289, 305, 298, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 295, 313, 308, 280, 285, 300, 320, 313, 305, 285, 283, 300, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 991.3, 991.8, 992.9, 993.1, 993.4, 993.2, 993.3, 992.4, 991.…
#> $ hr        <dbl> 92, 86, 85, 87, 79, 74, 72, 73, 73, 71, 74, 72, 79, 90, 93, …
#> $ stdvv     <dbl> 0.9, 0.9, 0.6, 0.8, 0.4, 0.9, 0.6, 0.6, 0.5, 0.9, 0.5, 0.5, …
#> $ ts        <dbl> 9.8, 9.7, 9.8, 10.0, 11.8, 14.7, 15.6, 16.4, 15.2, 17.4, 15.…
#> $ pres_nmar <dbl> 1021.8, 1022.3, 1023.5, 1023.7, 1023.9, 1023.5, 1023.6, 1022…
#> $ tamin     <dbl> 10.1, 9.9, 10.0, 9.7, 9.8, 11.0, 12.1, 12.6, 13.7, 14.1, 14.…
#> $ ta        <dbl> 10.1, 10.1, 10.0, 9.8, 11.0, 12.1, 12.7, 13.7, 14.1, 15.2, 1…
#> $ tamax     <dbl> 10.2, 10.1, 10.2, 10.0, 11.0, 12.1, 12.7, 13.7, 14.2, 15.3, …
#> $ tpr       <dbl> 8.9, 7.8, 7.6, 7.7, 7.6, 7.6, 7.8, 8.9, 9.3, 9.9, 10.2, 9.9,…
#> $ stddv     <dbl> 7, 8, 7, 6, 8, 11, 20, 12, 12, 9, 12, 6, 5, NA, NA, NA, NA, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 8.0, 23.9, 31.2, 30.7, 11.1, 56.9, 29.2,…
#> $ tss5cm    <dbl> 10.5, 10.3, 10.2, 10.2, 10.5, 11.0, 12.2, 12.9, 13.4, 13.8, …
#> $ pacutp    <dbl> 0.01, 0.00, 0.00, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 11.1, 11.0, 11.0, 10.9, 10.8, 10.8, 10.8, 10.9, 11.1, 11.3, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 54, 76, …
```
