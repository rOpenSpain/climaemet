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
#> $ fint      <dttm> 2026-03-11 00:00:00, 2026-03-11 01:00:00, 2026-03-11 02:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 1.6, 2.2, 1.3, 1.7, 2.0, 1.5, 1.5, 1.2, 1.5, 2.2, 2.2, 2.3, …
#> $ vv        <dbl> 0.7, 1.7, 0.6, 0.9, 0.4, 0.8, 0.5, 0.9, 0.6, 0.9, 0.5, 1.2, …
#> $ dv        <dbl> 17, 230, 20, 266, 298, 235, 165, 113, 119, 91, 48, 310, 319,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 10, 243, 115, 263, 268, 73, 110, 113, 15, 155, 105, 113, 13,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 993.8, 993.8, 993.8, 993.8, 994.1, 994.5, 994.7, 995.0, 995.…
#> $ hr        <dbl> 91, 91, 94, 92, 95, 94, 95, 97, 92, 83, 74, 69, 65, 96, 97, …
#> $ stdvv     <dbl> 0.3, 0.3, 0.2, 0.3, 0.2, 0.1, 0.3, 0.2, 0.2, 0.3, 0.3, 0.4, …
#> $ ts        <dbl> 6.7, 6.6, 5.7, 5.6, 5.1, 5.0, 4.4, 5.2, 8.0, 11.4, 15.0, 17.…
#> $ pres_nmar <dbl> 1024.6, 1024.6, 1024.6, 1024.7, 1025.0, 1025.5, 1025.7, 1026…
#> $ tamin     <dbl> 8.1, 7.5, 7.0, 6.5, 6.2, 6.0, 5.5, 5.3, 5.5, 6.9, 9.8, 12.1,…
#> $ ta        <dbl> 8.1, 7.5, 7.0, 6.5, 6.3, 6.0, 5.5, 5.5, 6.9, 9.8, 12.1, 13.7…
#> $ tamax     <dbl> 8.9, 8.2, 7.5, 7.0, 6.5, 6.4, 6.0, 5.6, 6.9, 9.8, 12.1, 13.7…
#> $ tpr       <dbl> 6.7, 6.1, 6.1, 5.3, 5.6, 5.1, 4.8, 5.1, 5.6, 7.0, 7.6, 8.1, …
#> $ stddv     <dbl> 52, 8, 19, 17, 74, 21, 37, 11, 24, 46, 80, 49, 49, NA, NA, N…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 56.4, 60.0, 60.0, 60…
#> $ tss5cm    <dbl> 11.4, 11.0, 10.6, 10.2, 9.8, 9.5, 9.2, 8.9, 9.0, 9.7, 11.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 13.2, 13.1, 12.8, 12.6, 12.4, 12.2, 12.0, 11.8, 11.6, 11.4, …
#> $ rviento   <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 42, 33, …
```
