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
#> $ fint      <dttm> 2026-09-09 03:00:00, 2026-09-09 04:00:00, 2026-09-09 05:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 17.2, 16.1, 16.8, 15.4, 16.8, 17.6, 19.1, 18.2, 19.5, 17.8, …
#> $ vv        <dbl> 11.7, 11.0, 11.4, 10.5, 10.6, 12.3, 11.5, 13.3, 12.7, 11.0, …
#> $ dv        <dbl> 308, 309, 301, 313, 314, 305, 311, 305, 306, 310, 323, 313, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 298, 300, 298, 313, 308, 305, 310, 308, 313, 318, 305, 300, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.3, 985.4, 985.9, 986.3, 986.5, 987.0, 987.4, 987.3, 987.…
#> $ hr        <dbl> 64, 72, 66, 68, 61, 59, 52, 41, 41, 36, 31, 29, 28, 67, 68, …
#> $ stdvv     <dbl> 2.1, 1.6, 1.4, 1.7, 2.0, 1.9, 1.8, 1.8, 2.1, 2.0, 1.8, 2.0, …
#> $ ts        <dbl> 21.8, 20.1, 19.9, 19.4, 19.8, 19.9, 22.0, 23.7, 26.6, 28.1, …
#> $ pres_nmar <dbl> 1014.4, 1014.6, 1015.2, 1015.6, 1015.9, 1016.4, 1016.7, 1016…
#> $ tamin     <dbl> 21.2, 19.5, 19.3, 18.9, 18.9, 18.9, 18.9, 19.7, 21.3, 22.5, …
#> $ ta        <dbl> 21.2, 19.6, 19.4, 18.9, 19.0, 19.0, 19.7, 21.6, 22.8, 23.9, …
#> $ tamax     <dbl> 22.4, 21.2, 19.6, 19.4, 19.1, 19.1, 19.8, 21.6, 22.8, 23.9, …
#> $ tpr       <dbl> 14.1, 14.4, 12.8, 12.8, 11.3, 10.8, 9.6, 7.8, 8.9, 8.0, 5.9,…
#> $ stddv     <dbl> 7, 7, 6, 8, 10, 7, 8, 7, 10, 9, 11, 13, 12, 23, 24, 32, 20, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 32.4, 56.5, 56.4, 58.4, 60.0, …
#> $ tss5cm    <dbl> 30.4, 30.0, 29.5, 29.0, 28.6, 28.3, 28.3, 28.6, 29.1, 30.1, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 32.8, 32.6, 32.4, 32.2, 31.9, 31.7, 31.5, 31.3, 31.1, 31.0, …
```
