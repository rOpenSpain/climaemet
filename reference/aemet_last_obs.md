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
#> $ fint      <dttm> 2026-07-16 12:00:00, 2026-07-16 13:00:00, 2026-07-16 14:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.8, 6.5, 8.0, 7.6, 7.7, 8.0, 9.5, 9.9, 7.8, 5.7, 12.5, 15.2…
#> $ vv        <dbl> 2.9, 3.9, 5.2, 4.9, 4.5, 5.0, 3.9, 2.1, 4.5, 3.1, 7.9, 11.7,…
#> $ dv        <dbl> 102, 109, 108, 104, 112, 115, 105, 112, 112, 141, 312, 301, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 123, 100, 100, 123, 105, 120, 128, 128, 123, 115, 310, 313, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.6, 984.8, 983.8, 983.0, 982.3, 981.8, 981.7, 982.4, 983.…
#> $ hr        <dbl> 36, 34, 29, 23, 25, 26, 29, 34, 38, 38, 49, 56, 23, 20, 22, …
#> $ stdvv     <dbl> 0.7, 0.8, 1.0, 0.9, 0.7, 0.9, 1.0, 0.8, 0.8, 1.1, 1.4, 1.2, …
#> $ ts        <dbl> 38.6, 38.6, 40.1, 40.9, 41.5, 40.6, 38.8, 35.8, 32.4, 31.3, …
#> $ pres_nmar <dbl> 1013.5, 1012.6, 1011.4, 1010.5, 1009.7, 1009.1, 1009.1, 1009…
#> $ tamin     <dbl> 30.8, 32.5, 33.9, 36.0, 37.0, 37.9, 37.0, 35.9, 33.0, 31.7, …
#> $ ta        <dbl> 32.8, 33.9, 36.0, 37.1, 37.9, 37.9, 37.0, 35.9, 33.0, 32.1, …
#> $ tamax     <dbl> 32.9, 33.9, 36.0, 37.1, 37.9, 38.2, 37.9, 37.3, 35.9, 33.0, …
#> $ tpr       <dbl> 15.8, 15.9, 15.2, 12.5, 14.4, 15.1, 16.0, 17.6, 16.8, 16.0, …
#> $ stddv     <dbl> 24, 13, 12, 12, 14, 10, 16, 48, 9, 11, 8, 6, 30, 33, 28, 30,…
#> $ inso      <dbl> 56.1, 41.4, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 1.5, 0.0, 0.…
#> $ tss5cm    <dbl> 37.6, 38.8, 40.1, 40.9, 41.4, 41.5, 41.1, 40.3, 39.3, 38.2, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 34.3, 34.4, 34.6, 34.9, 35.2, 35.6, 35.9, 36.1, 36.3, 36.4, …
```
