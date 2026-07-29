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
#> Rows: 26
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-07-29 01:00:00, 2026-07-29 02:00:00, 2026-07-29 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.3, 6.6, 6.6, 6.2, 5.6, 5.2, 4.4, 5.1, 5.2, 5.8, 6.1, 6.5, …
#> $ vv        <dbl> 2.3, 4.4, 3.5, 4.1, 3.1, 2.1, 3.0, 3.6, 3.1, 3.9, 3.7, 4.2, …
#> $ dv        <dbl> 103, 135, 136, 136, 133, 120, 104, 114, 111, 115, 98, 113, 1…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 105, 125, 145, 123, 153, 143, 110, 113, 105, 113, 85, 115, 1…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.2, 988.5, 988.7, 988.5, 988.9, 989.2, 989.7, 989.7, 989.…
#> $ hr        <dbl> 56, 59, 59, 59, 60, 62, 58, 53, 47, 39, 37, 31, 27, 32, 34, …
#> $ stdvv     <dbl> 0.3, 0.9, 0.7, 0.7, 0.7, 0.5, 0.5, 0.8, 0.9, 0.7, 0.8, 0.7, …
#> $ ts        <dbl> 25.8, 25.9, 25.2, 24.9, 24.4, 25.4, 27.8, 30.2, 32.5, 35.1, …
#> $ pres_nmar <dbl> 1016.8, 1017.1, 1017.4, 1017.2, 1017.7, 1017.9, 1018.4, 1018…
#> $ tamin     <dbl> 26.3, 25.4, 25.5, 25.2, 24.8, 24.7, 25.1, 26.1, 27.5, 28.9, …
#> $ ta        <dbl> 26.3, 26.0, 25.5, 25.2, 24.8, 25.1, 26.1, 27.5, 28.9, 31.2, …
#> $ tamax     <dbl> 27.5, 26.3, 26.0, 25.5, 25.2, 25.1, 26.1, 27.5, 28.9, 31.2, …
#> $ tpr       <dbl> 16.8, 17.4, 16.9, 16.6, 16.5, 17.3, 17.2, 17.1, 16.5, 15.6, …
#> $ stddv     <dbl> 7, 9, 11, 8, 11, 10, 11, 12, 16, 12, 16, 13, 10, 11, 14, 11,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 20.1, 60.0, 60.0, 60.0, 60.0, 60.0,…
#> $ tss5cm    <dbl> 33.7, 33.1, 32.6, 32.2, 31.7, 31.4, 31.2, 31.5, 32.3, 33.5, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 34.3, 34.2, 34.0, 33.8, 33.6, 33.4, 33.2, 33.0, 32.8, 32.7, …
```
