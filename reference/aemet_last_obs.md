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
#> $ fint      <dttm> 2026-08-12 00:00:00, 2026-08-12 01:00:00, 2026-08-12 02:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 8.4, 6.4, 4.9, 4.0, 3.5, 2.5, 2.0, 2.8, 3.3, 4.3, 6.0, 6.0, …
#> $ vv        <dbl> 5.0, 3.8, 3.6, 2.3, 1.2, 1.1, 1.1, 1.8, 1.6, 2.3, 3.4, 2.5, …
#> $ dv        <dbl> 116, 126, 117, 139, 99, 50, 40, 94, 108, 89, 111, 97, 105, 8…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 118, 130, 115, 123, 143, 125, 25, 80, 113, 105, 105, 115, 68…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.0, 988.0, 988.0, 988.3, 988.4, 988.8, 989.3, 989.7, 989.…
#> $ hr        <dbl> 59, 57, 60, 66, 68, 71, 70, 66, 62, 59, 49, 40, 34, 29, 37, …
#> $ stdvv     <dbl> 0.9, 0.6, 0.5, 0.5, 0.5, 0.3, 0.3, 0.3, 0.5, 0.8, 0.9, 0.9, …
#> $ ts        <dbl> 27.8, 26.8, 26.0, 25.7, 24.7, 24.0, 25.1, 28.7, 31.9, 34.2, …
#> $ pres_nmar <dbl> 1016.4, 1016.5, 1016.6, 1016.9, 1017.1, 1017.6, 1018.1, 1018…
#> $ tamin     <dbl> 27.9, 27.0, 26.3, 25.8, 25.2, 24.5, 24.1, 24.5, 26.2, 28.3, …
#> $ ta        <dbl> 28.0, 27.0, 26.3, 26.0, 25.2, 24.5, 24.5, 26.2, 28.3, 29.8, …
#> $ tamax     <dbl> 28.9, 28.0, 27.0, 26.3, 26.0, 25.2, 24.5, 26.2, 28.3, 29.8, …
#> $ tpr       <dbl> 19.2, 17.8, 17.9, 19.1, 18.8, 18.9, 18.7, 19.3, 20.3, 20.9, …
#> $ stddv     <dbl> 11, 8, 8, 11, 22, 20, 18, 15, 20, 18, 24, 31, 22, 12, 22, 10…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.6, 60.0, 60.0, 60.0, 60.0, …
#> $ tss5cm    <dbl> 35.5, 34.8, 34.2, 33.6, 33.2, 32.7, 32.3, 32.1, 32.4, 33.3, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 35.5, 35.4, 35.3, 35.1, 34.9, 34.7, 34.5, 34.3, 34.1, 33.9, …
```
