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
#> $ fint      <dttm> 2026-07-14 03:00:00, 2026-07-14 04:00:00, 2026-07-14 05:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.6, 4.7, 4.1, 5.0, 5.9, 5.4, 4.5, 3.6, 3.7, 4.3, 6.4, 7.5, …
#> $ vv        <dbl> 3.2, 3.1, 2.8, 3.4, 4.4, 2.5, 1.8, 1.5, 1.5, 2.6, 3.7, 4.5, …
#> $ dv        <dbl> 272, 284, 299, 315, 309, 315, 317, 54, 77, 110, 119, 114, 50…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 308, 290, 280, 298, 300, 303, 343, 335, 65, 88, 78, 113, 22,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.1, 985.4, 985.7, 986.4, 986.9, 987.1, 986.9, 986.7, 986.…
#> $ hr        <dbl> 65, 67, 68, 65, 56, 55, 53, 48, 46, 43, 34, 30, 32, 43, 34, …
#> $ stdvv     <dbl> 0.5, 0.3, 0.3, 0.5, 0.7, 0.5, 0.6, 0.6, 0.6, 0.6, 0.9, 1.2, …
#> $ ts        <dbl> 25.2, 24.9, 24.7, 26.0, 28.2, 31.3, 34.3, 37.3, 38.3, 40.2, …
#> $ pres_nmar <dbl> 1013.7, 1014.0, 1014.4, 1015.1, 1015.6, 1015.7, 1015.3, 1014…
#> $ tamin     <dbl> 25.5, 25.0, 24.6, 24.3, 24.6, 25.4, 26.5, 28.1, 30.4, 32.3, …
#> $ ta        <dbl> 25.5, 25.0, 24.6, 24.7, 25.4, 26.5, 28.1, 30.4, 32.3, 34.4, …
#> $ tamax     <dbl> 26.6, 25.5, 25.0, 24.8, 25.4, 26.5, 28.1, 30.7, 32.5, 34.4, …
#> $ tpr       <dbl> 18.5, 18.5, 18.3, 17.7, 16.0, 16.7, 17.6, 18.2, 19.2, 20.0, …
#> $ stddv     <dbl> 7, 5, 8, 10, 12, 42, 91, 45, 34, 33, 12, 12, 20, 31, 19, 25,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 42.8, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.…
#> $ tss5cm    <dbl> 33.9, 33.4, 32.9, 32.5, 32.3, 32.5, 33.3, 34.6, 36.4, 38.1, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 35.0, 34.8, 34.6, 34.4, 34.1, 33.9, 33.7, 33.6, 33.5, 33.6, …
```
