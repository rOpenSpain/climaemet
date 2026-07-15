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

  A character vector of station identifiers (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md))
  or `"all"` for all stations.

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- return_sf:

  A logical value. If `TRUE`, the function returns an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object. If `FALSE` (the default), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  A logical value. If `TRUE`, displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  unless `verbose = TRUE`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object.

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)
for station identifiers.

Weather observations:
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md)

## Examples

``` r
obs <- aemet_last_obs(c("9434", "3195"))
dplyr::glimpse(obs)
#> Rows: 25
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-07-15 03:00:00, 2026-07-15 04:00:00, 2026-07-15 05:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.8, 2.4, 2.4, 2.2, 2.7, 2.7, 3.0, 2.9, 7.9, 8.6, 9.8, 7.4, …
#> $ vv        <dbl> 1.2, 1.2, 1.4, 0.8, 1.5, 0.9, 1.2, 1.1, 4.5, 3.2, 5.2, 3.4, …
#> $ dv        <dbl> 85, 95, 284, 46, 79, 28, 124, 59, 304, 320, 255, 111, 213, 2…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 93, 75, 268, 250, 90, 118, 78, 340, 313, 288, 255, 245, 219,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 986.0, 986.4, 987.3, 987.6, 988.0, 987.9, 987.7, 987.5, 987.…
#> $ hr        <dbl> 81, 83, 79, 81, 76, 64, 50, 34, 19, 18, 13, 17, 36, 40, 44, …
#> $ stdvv     <dbl> 0.3, 0.4, 0.2, 0.3, 0.3, 0.5, 0.4, 0.5, 1.1, 0.9, 1.5, 1.0, …
#> $ ts        <dbl> 24.4, 24.0, 23.5, 25.7, 29.4, 34.1, 36.1, 40.5, 41.3, 44.1, …
#> $ pres_nmar <dbl> 1014.6, 1015.0, 1016.0, 1016.3, 1016.5, 1016.2, 1015.8, 1015…
#> $ tamin     <dbl> 25.1, 24.7, 24.3, 24.2, 24.8, 26.4, 28.6, 30.9, 34.0, 36.2, …
#> $ ta        <dbl> 25.1, 24.7, 24.3, 24.9, 26.4, 28.6, 30.9, 34.0, 36.2, 38.1, …
#> $ tamax     <dbl> 26.1, 25.2, 24.7, 24.9, 26.4, 28.6, 30.9, 34.0, 36.2, 38.4, …
#> $ tpr       <dbl> 21.6, 21.6, 20.4, 21.4, 21.8, 21.1, 19.3, 16.0, 8.9, 9.7, 6.…
#> $ stddv     <dbl> 15, 21, 15, 25, 11, 71, 28, 118, 18, 24, 14, 21, 17, 10, 10,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 36.4, 60.0, 60.0, 60.0, 60.0, 50.8, 58.3, 58.…
#> $ tss5cm    <dbl> 34.3, 33.7, 33.1, 32.7, 32.5, 33.0, 34.0, 35.4, 36.9, 38.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 35.6, 35.4, 35.2, 34.9, 34.7, 34.4, 34.2, 34.1, 34.1, 34.2, …
```
