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
#> Rows: 24
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-07-15 01:00:00, 2026-07-15 02:00:00, 2026-07-15 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.8, 3.9, 2.8, 2.4, 2.4, 2.2, 2.7, 2.7, 3.0, 2.9, 7.9, 8.6, …
#> $ vv        <dbl> 2.9, 1.7, 1.2, 1.2, 1.4, 0.8, 1.5, 0.9, 1.2, 1.1, 4.5, 3.2, …
#> $ dv        <dbl> 107, 70, 85, 95, 284, 46, 79, 28, 124, 59, 304, 320, 185, 20…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 98, 123, 93, 75, 268, 250, 90, 118, 78, 340, 313, 288, 185, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.3, 985.6, 986.0, 986.4, 987.3, 987.6, 988.0, 987.9, 987.…
#> $ hr        <dbl> 72, 77, 81, 83, 79, 81, 76, 64, 50, 34, 19, 18, 37, 36, 36, …
#> $ stdvv     <dbl> 0.5, 0.4, 0.3, 0.4, 0.2, 0.3, 0.3, 0.5, 0.4, 0.5, 1.1, 0.9, …
#> $ ts        <dbl> 26.8, 25.4, 24.4, 24.0, 23.5, 25.7, 29.4, 34.1, 36.1, 40.5, …
#> $ pres_nmar <dbl> 1013.7, 1014.1, 1014.6, 1015.0, 1016.0, 1016.3, 1016.5, 1016…
#> $ tamin     <dbl> 27.1, 26.1, 25.1, 24.7, 24.3, 24.2, 24.8, 26.4, 28.6, 30.9, …
#> $ ta        <dbl> 27.1, 26.1, 25.1, 24.7, 24.3, 24.9, 26.4, 28.6, 30.9, 34.0, …
#> $ tamax     <dbl> 27.9, 27.1, 26.1, 25.2, 24.7, 24.9, 26.4, 28.6, 30.9, 34.0, …
#> $ tpr       <dbl> 21.6, 21.8, 21.6, 21.6, 20.4, 21.4, 21.8, 21.1, 19.3, 16.0, …
#> $ stddv     <dbl> 11, 21, 15, 21, 15, 25, 11, 71, 28, 118, 18, 24, 14, 12, 17,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 36.4, 60.0, 60.0, 60.0, 60.0, 50.8,…
#> $ tss5cm    <dbl> 35.5, 34.9, 34.3, 33.7, 33.1, 32.7, 32.5, 33.0, 34.0, 35.4, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 36.0, 35.8, 35.6, 35.4, 35.2, 34.9, 34.7, 34.4, 34.2, 34.1, …
```
