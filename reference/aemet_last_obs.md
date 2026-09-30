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
#> $ fint      <dttm> 2026-09-30 05:00:00, 2026-09-30 06:00:00, 2026-09-30 07:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 5.2, 6.0, 5.5, 6.9, 6.0, 6.0, 6.4, 6.0, 6.4, 5.8, 7.9, 8.0, …
#> $ vv        <dbl> 3.6, 3.6, 3.1, 4.1, 3.7, 3.8, 3.9, 3.7, 3.4, 3.3, 4.9, 3.0, …
#> $ dv        <dbl> 118, 124, 110, 121, 115, 110, 101, 115, 99, 99, 119, 108, 11…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 98, 128, 123, 123, 118, 105, 88, 108, 110, 80, 108, 138, 115…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.5, 988.9, 989.5, 989.8, 990.1, 990.1, 989.8, 989.4, 988.…
#> $ hr        <dbl> 87, 87, 86, 84, 83, 78, 73, 71, 67, 69, 59, 58, 58, 66, 63, …
#> $ stdvv     <dbl> 0.6, 0.7, 0.5, 0.9, 0.6, 0.7, 0.7, 0.5, 0.7, 0.6, 1.0, 0.7, …
#> $ ts        <dbl> 20.4, 20.5, 20.8, 21.9, 22.5, 23.9, 25.4, 24.8, 27.0, 25.7, …
#> $ pres_nmar <dbl> 1017.7, 1018.1, 1018.7, 1018.9, 1019.2, 1019.1, 1018.6, 1018…
#> $ tamin     <dbl> 20.6, 20.6, 20.6, 20.9, 21.6, 22.0, 22.9, 24.1, 24.5, 25.5, …
#> $ ta        <dbl> 20.7, 20.7, 20.9, 21.6, 22.0, 22.9, 24.1, 24.5, 25.8, 25.5, …
#> $ tamax     <dbl> 20.7, 20.7, 20.9, 21.6, 22.0, 22.9, 24.1, 24.5, 25.8, 25.9, …
#> $ tpr       <dbl> 18.5, 18.5, 18.5, 18.8, 19.0, 18.8, 19.0, 18.9, 19.2, 19.4, …
#> $ stddv     <dbl> 9, 11, 11, 10, 10, 11, 11, 10, 11, 12, 12, 10, 9, 19, 14, 19…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 9.1, 0.0, 0.0, 0.0, 0.0, 1.7, 0.0, 0.0, 0.0, …
#> $ tss5cm    <dbl> 22.3, 22.2, 22.2, 22.3, 22.5, 22.9, 23.5, 23.9, 24.2, 24.5, …
#> $ pacutp    <dbl> 0.00, 0.02, 0.00, 0.00, 0.00, 0.00, 0.00, 0.05, 0.00, 0.03, …
#> $ tss20cm   <dbl> 24.8, 24.6, 24.5, 24.4, 24.3, 24.2, 24.2, 24.2, 24.3, 24.4, …
```
