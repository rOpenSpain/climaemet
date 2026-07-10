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
#> $ fint      <dttm> 2026-07-10 08:00:00, 2026-07-10 09:00:00, 2026-07-10 10:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.4, 6.7, 6.5, 5.8, 4.0, 5.0, 10.4, 13.0, 13.8, 12.3, 12.7, …
#> $ vv        <dbl> 1.8, 4.2, 2.8, 2.7, 1.3, 2.7, 6.0, 8.2, 8.5, 7.1, 7.7, 4.2, …
#> $ dv        <dbl> 38, 116, 92, 112, 147, 24, 103, 111, 113, 113, 112, 157, 233…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 83, 108, 133, 80, 123, 15, 105, 105, 125, 110, 128, 125, 224…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 980.6, 980.6, 980.4, 979.9, 979.8, 979.3, 978.9, 978.4, 978.…
#> $ hr        <dbl> 33, 29, 25, 27, 30, 20, 16, 17, 15, 17, 20, 21, 26, 26, 20, …
#> $ stdvv     <dbl> 0.5, 0.9, 0.7, 0.7, 0.3, 0.9, 1.2, 1.8, 1.8, 1.2, 1.3, 1.0, …
#> $ ts        <dbl> 34.0, 34.9, 37.6, 33.8, 34.4, 43.2, 36.7, 37.6, 37.7, 35.4, …
#> $ pres_nmar <dbl> 1008.7, 1008.6, 1008.2, 1007.7, 1007.6, 1006.8, 1006.5, 1005…
#> $ tamin     <dbl> 27.4, 29.3, 30.8, 32.5, 30.8, 32.5, 35.4, 35.4, 35.1, 34.5, …
#> $ ta        <dbl> 29.3, 30.8, 32.6, 32.5, 32.5, 36.3, 35.4, 35.4, 35.3, 34.6, …
#> $ tamax     <dbl> 29.3, 30.9, 32.6, 33.7, 32.5, 36.3, 37.2, 36.2, 35.9, 35.8, …
#> $ tpr       <dbl> 11.3, 10.8, 10.0, 11.1, 12.6, 9.8, 5.8, 6.7, 4.8, 5.9, 7.8, …
#> $ stddv     <dbl> 23, 10, 21, 10, 25, 26, 11, 11, 9, 10, 10, 21, 25, 27, 19, 2…
#> $ inso      <dbl> 60.0, 60.0, 60.0, 39.6, 7.3, 41.6, 37.7, 35.8, 60.0, 40.5, 3…
#> $ tss5cm    <dbl> 32.1, 33.1, 34.4, 35.9, 35.8, 35.8, 37.6, 37.8, 38.1, 38.1, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.05, 0.32, 0.00, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 33.2, 33.1, 33.0, 33.0, 33.1, 33.2, 33.4, 33.6, 33.8, 34.0, …
```
