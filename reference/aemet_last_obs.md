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
#> Rows: 24
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-06-24 02:00:00, 2026-06-24 03:00:00, 2026-06-24 04:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.2, 2.5, 2.7, 1.7, 1.9, 3.2, 2.9, 3.6, 4.8, 4.8, 5.8, 6.9, …
#> $ vv        <dbl> 2.0, 1.9, 1.5, 1.1, 1.0, 1.9, 1.7, 1.0, 2.2, 3.0, 4.0, 4.9, …
#> $ dv        <dbl> 105, 109, 116, 88, 102, 92, 76, 43, 76, 88, 119, 129, 76, 83…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 100, 105, 113, 98, 68, 100, 93, 80, 60, 95, 98, 140, 100, 76…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 986.3, 986.3, 986.5, 986.9, 987.2, 987.3, 987.2, 986.8, 986.…
#> $ hr        <dbl> 45, 45, 45, 45, 46, 40, 36, 30, 26, 19, 19, 18, 29, 29, 30, …
#> $ stdvv     <dbl> 0.2, 0.2, 0.3, 0.2, 0.3, 0.4, 0.4, 0.5, 0.7, 0.7, 0.8, 0.8, …
#> $ ts        <dbl> 23.5, 22.5, 22.2, 21.9, 25.3, 33.1, 38.3, 41.4, 46.3, 46.8, …
#> $ pres_nmar <dbl> 1014.9, 1015.0, 1015.3, 1015.7, 1015.9, 1015.8, 1015.5, 1014…
#> $ tamin     <dbl> 25.9, 24.9, 24.6, 24.6, 24.9, 25.2, 27.9, 30.0, 32.4, 34.6, …
#> $ ta        <dbl> 25.9, 24.9, 24.7, 24.9, 25.2, 27.9, 30.0, 32.4, 34.6, 36.4, …
#> $ tamax     <dbl> 27.4, 25.9, 24.9, 24.9, 25.2, 27.9, 30.0, 32.4, 34.6, 36.4, …
#> $ tpr       <dbl> 13.1, 12.1, 12.0, 12.1, 12.7, 13.1, 13.3, 12.6, 12.3, 9.0, N…
#> $ stddv     <dbl> 7, 8, 8, 10, 15, 14, 18, 64, 28, 14, 21, 10, 10, 14, 12, 20,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 18.9, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0…
#> $ tss5cm    <dbl> 33.4, 32.7, 32.1, 31.5, 31.0, 31.0, 31.7, 32.9, 34.6, 36.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 34.3, 34.0, 33.8, 33.5, 33.2, 32.9, 32.7, 32.4, 32.3, 32.3, …
```
