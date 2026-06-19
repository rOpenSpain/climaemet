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
  [tibble](https://tibble.tidyverse.org/reference/tibble.html). The
  [sf](https://CRAN.R-project.org/package=sf) package must be installed.

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

## Examples

``` r
obs <- aemet_last_obs(c("9434", "3195"))
dplyr::glimpse(obs)
#> Rows: 26
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-06-19 01:00:00, 2026-06-19 02:00:00, 2026-06-19 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 7.7, 7.9, 6.6, 5.3, 3.2, 4.9, 7.0, 6.5, 8.1, 8.2, 9.1, 9.1, …
#> $ vv        <dbl> 4.7, 4.2, 4.0, 2.3, 1.9, 1.9, 4.5, 4.4, 4.5, 5.4, 5.1, 5.7, …
#> $ dv        <dbl> 110, 109, 118, 115, 118, 114, 134, 112, 112, 122, 105, 113, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 100, 113, 118, 120, 85, 135, 130, 113, 118, 125, 88, 123, 13…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 986.8, 987.1, 987.1, 987.2, 987.3, 987.6, 987.8, 987.9, 987.…
#> $ hr        <dbl> 40, 43, 46, 48, 51, 45, 37, 36, 34, 28, 26, 21, 20, 31, 31, …
#> $ stdvv     <dbl> 0.8, 0.7, 0.6, 0.3, 0.3, 0.4, 1.1, 0.9, 0.8, 1.0, 1.0, 0.9, …
#> $ ts        <dbl> 22.6, 22.1, 21.2, 20.4, 20.1, 24.6, 29.4, 32.7, 37.6, 40.9, …
#> $ pres_nmar <dbl> 1015.7, 1016.1, 1016.2, 1016.3, 1016.5, 1016.6, 1016.6, 1016…
#> $ tamin     <dbl> 23.3, 22.8, 22.1, 21.5, 20.9, 20.9, 23.0, 24.7, 26.1, 27.8, …
#> $ ta        <dbl> 23.3, 22.8, 22.1, 21.5, 20.9, 23.0, 24.7, 26.1, 27.8, 29.6, …
#> $ tamax     <dbl> 24.0, 23.3, 22.8, 22.2, 21.5, 23.0, 24.7, 26.1, 27.8, 29.6, …
#> $ tpr       <dbl> 8.9, 9.6, 9.9, 10.0, 10.4, 10.4, 9.0, 9.8, 10.5, 9.2, 9.6, 8…
#> $ stddv     <dbl> 10, 10, 8, 9, 12, 14, 12, 11, 18, 12, 12, 13, 13, 16, 18, 10…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 46.4, 60.0, 60.0, 60.0, 60.0, 60.0,…
#> $ tss5cm    <dbl> 32.5, 31.8, 31.2, 30.7, 30.1, 29.7, 29.7, 30.2, 31.2, 32.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 33.6, 33.4, 33.1, 32.8, 32.5, 32.2, 31.9, 31.6, 31.4, 31.3, …
```
