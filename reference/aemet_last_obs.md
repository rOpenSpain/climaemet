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
#> $ fint      <dttm> 2026-07-07 03:00:00, 2026-07-07 04:00:00, 2026-07-07 05:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.0, 1.6, 1.4, 2.0, 1.8, 2.3, 2.4, 2.7, 2.8, 3.6, 4.1, 4.4, …
#> $ vv        <dbl> 0.3, 0.8, 0.7, 0.6, 1.1, 1.1, 1.0, 1.5, 1.3, 2.0, 1.2, 1.8, …
#> $ dv        <dbl> 272, 198, 303, 318, 90, 7, 65, 337, 358, 358, 2, 111, 102, 7…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 260, 178, 190, 80, 113, 5, 80, 20, 30, 323, 30, 103, 76, 71,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 987.9, 988.0, 988.7, 989.1, 989.4, 989.7, 989.4, 989.1, 988.…
#> $ hr        <dbl> 34, 35, 37, 37, 32, 31, 26, 22, 18, 17, 12, 11, 37, 41, 36, …
#> $ stdvv     <dbl> 0.2, 0.2, 0.1, 0.3, 0.2, 0.5, 0.4, 0.5, 0.6, 0.7, 0.4, 1.0, …
#> $ ts        <dbl> 22.8, 22.1, 22.2, 26.4, 30.9, 34.1, 37.3, 39.5, 42.3, 44.0, …
#> $ pres_nmar <dbl> 1016.7, 1016.9, 1017.7, 1018.0, 1018.0, 1018.2, 1017.6, 1017…
#> $ tamin     <dbl> 25.0, 24.0, 23.5, 23.6, 24.9, 27.5, 28.7, 31.1, 32.9, 35.6, …
#> $ ta        <dbl> 25.0, 24.0, 23.6, 24.9, 27.5, 28.7, 31.3, 33.0, 35.6, 37.7, …
#> $ tamax     <dbl> 25.7, 25.0, 24.0, 24.9, 27.5, 29.1, 31.4, 33.1, 35.7, 37.7, …
#> $ tpr       <dbl> 8.0, 7.6, 8.1, 9.2, 9.3, 9.9, 9.6, 8.4, 7.6, 8.5, 4.5, 4.6, …
#> $ stddv     <dbl> 96, 15, 20, 69, 12, 30, 57, 65, 69, 38, 43, 36, 10, 10, 28, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 33.5, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.…
#> $ tss5cm    <dbl> 31.7, 31.1, 30.6, 30.1, 30.2, 30.9, 31.9, 33.4, 35.1, 36.9, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 33.5, 33.2, 32.9, 32.6, 32.3, 32.0, 31.9, 31.8, 31.8, 31.9, …
```
