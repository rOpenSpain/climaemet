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
#> $ fint      <dttm> 2026-07-01 02:00:00, 2026-07-01 03:00:00, 2026-07-01 04:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 17.4, 16.9, 15.5, 16.0, 16.6, 18.0, 17.4, 18.2, 18.3, 17.3, …
#> $ vv        <dbl> 13.0, 9.0, 10.8, 10.9, 11.4, 10.7, 10.9, 11.8, 13.8, 10.9, 1…
#> $ dv        <dbl> 303, 301, 313, 304, 312, 311, 314, 314, 312, 312, 314, 312, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 303, 293, 303, 318, 313, 323, 310, 318, 310, 320, 300, 300, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 992.9, 993.1, 992.8, 993.2, 993.4, 993.8, 993.9, 993.5, 993.…
#> $ hr        <dbl> 57, 58, 60, 61, 59, 56, 50, 45, 41, 38, 32, 30, 47, 48, 50, …
#> $ stdvv     <dbl> 1.5, 1.8, 1.7, 1.3, 1.7, 1.6, 2.1, 2.2, 2.0, 1.7, 1.7, 1.9, …
#> $ ts        <dbl> 21.4, 20.9, 20.4, 20.2, 21.2, 22.8, 24.9, 26.4, 28.1, 30.6, …
#> $ pres_nmar <dbl> 1022.2, 1022.5, 1022.2, 1022.6, 1022.8, 1023.2, 1023.2, 1022…
#> $ tamin     <dbl> 21.2, 20.7, 20.2, 20.0, 20.1, 20.5, 21.1, 22.2, 23.2, 24.6, …
#> $ ta        <dbl> 21.2, 20.7, 20.2, 20.1, 20.5, 21.1, 22.2, 23.2, 24.6, 25.9, …
#> $ tamax     <dbl> 21.6, 21.2, 20.7, 20.2, 20.5, 21.1, 22.3, 23.3, 24.7, 26.0, …
#> $ tpr       <dbl> 12.3, 12.1, 12.2, 12.3, 12.2, 12.0, 11.2, 10.6, 10.5, 10.5, …
#> $ stddv     <dbl> 6, 8, 8, 7, 8, 9, 10, 9, 7, 9, 10, 22, 21, 18, 21, 19, 15, 1…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.5, 54.7, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0…
#> $ tss5cm    <dbl> 27.6, 27.1, 26.6, 26.1, 25.8, 25.8, 26.1, 26.8, 27.9, 29.3, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 30.6, 30.3, 30.1, 29.8, 29.5, 29.2, 29.0, 28.7, 28.6, 28.5, …
```
