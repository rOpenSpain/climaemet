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
#> $ fint      <dttm> 2026-07-06 08:00:00, 2026-07-06 09:00:00, 2026-07-06 10:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.7, 3.3, 3.4, 3.2, 3.3, 3.4, 3.4, 3.2, 3.1, 2.8, 3.3, 2.4, …
#> $ vv        <dbl> 1.7, 1.9, 1.1, 1.7, 2.0, 1.9, 1.4, 2.1, 1.7, 1.2, 2.2, 1.5, …
#> $ dv        <dbl> 302, 341, 332, 112, 107, 88, 93, 122, 104, 98, 103, 114, 87,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 318, 338, 338, 108, 83, 83, 113, 140, 105, 93, 113, 85, 92, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 991.1, 990.8, 990.4, 989.7, 989.0, 988.2, 987.6, 986.9, 986.…
#> $ hr        <dbl> 40, 31, 25, 22, 20, 19, 15, 12, 9, 10, 12, 15, 32, 33, 28, 2…
#> $ stdvv     <dbl> 0.4, 0.5, 0.4, 0.4, 0.4, 0.5, 0.5, 0.3, 0.4, 0.3, 0.4, 0.1, …
#> $ ts        <dbl> 31.3, 35.3, 38.3, 39.8, 41.6, 43.7, 45.0, 44.9, 45.3, 44.7, …
#> $ pres_nmar <dbl> 1019.8, 1019.3, 1018.6, 1017.7, 1016.8, 1015.8, 1015.0, 1014…
#> $ tamin     <dbl> 23.7, 26.3, 29.0, 31.8, 34.3, 36.1, 37.8, 39.3, 40.2, 40.5, …
#> $ ta        <dbl> 26.3, 29.0, 31.8, 34.3, 36.1, 37.8, 39.3, 40.2, 40.9, 40.6, …
#> $ tamax     <dbl> 26.3, 29.0, 31.8, 34.3, 36.1, 37.9, 39.3, 40.6, 41.0, 40.9, …
#> $ tpr       <dbl> 11.7, 10.2, 9.3, 9.6, 9.6, 10.2, 7.8, 5.3, 1.9, 3.0, 5.1, 7.…
#> $ stddv     <dbl> 22, 24, 53, 22, 18, 24, 49, 13, 18, 35, 10, 5, 16, 31, 26, 2…
#> $ inso      <dbl> 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, NA, NA, NA, …
#> $ tss5cm    <dbl> 29.3, 30.3, 31.9, 33.7, 35.6, 37.4, 39.0, 40.1, 40.7, 40.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 31.0, 30.8, 30.7, 30.7, 30.9, 31.2, 31.6, 32.1, 32.6, 33.1, …
```
