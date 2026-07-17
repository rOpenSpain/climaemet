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
#> Rows: 25
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-07-17 01:00:00, 2026-07-17 02:00:00, 2026-07-17 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 13.9, 11.3, 11.4, 8.9, 9.0, 8.3, 9.8, 8.8, 8.0, 7.6, 7.3, 5.…
#> $ vv        <dbl> 7.9, 6.8, 5.7, 5.8, 5.3, 6.7, 6.6, 6.1, 4.8, 4.2, 3.6, 3.1, …
#> $ dv        <dbl> 303, 308, 298, 293, 292, 296, 310, 316, 313, 324, 316, 331, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 298, 293, 305, 298, 288, 300, 300, 313, 290, 300, 313, 313, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 986.7, 986.9, 986.7, 986.5, 986.8, 987.1, 987.6, 987.8, 987.…
#> $ hr        <dbl> 59, 61, 62, 62, 63, 61, 60, 56, 52, 47, 40, 35, 32, 35, 45, …
#> $ stdvv     <dbl> 1.5, 1.0, 0.5, 0.8, 0.6, 0.7, 1.3, 0.8, 0.9, 0.9, 1.0, 0.9, …
#> $ ts        <dbl> 24.5, 24.0, 23.4, 23.4, 22.9, 24.3, 26.2, 28.2, 31.3, 33.5, …
#> $ pres_nmar <dbl> 1015.5, 1015.7, 1015.6, 1015.4, 1015.7, 1016.0, 1016.4, 1016…
#> $ tamin     <dbl> 24.1, 23.7, 23.1, 23.0, 22.7, 22.7, 23.2, 23.7, 24.5, 26.1, …
#> $ ta        <dbl> 24.1, 23.7, 23.1, 23.1, 22.7, 23.2, 23.8, 24.6, 26.2, 27.5, …
#> $ tamax     <dbl> 24.8, 24.1, 23.8, 23.3, 23.1, 23.2, 24.0, 24.6, 26.2, 27.6, …
#> $ tpr       <dbl> 15.6, 15.7, 15.4, 15.4, 15.3, 15.3, 15.5, 15.3, 15.5, 15.2, …
#> $ stddv     <dbl> 9, 8, 6, 8, 6, 6, 11, 7, 13, 16, 22, 20, 17, 16, 18, 8, 12, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 52.3, 60.0, 60.0, 60.0, 60.0, 60.0,…
#> $ tss5cm    <dbl> 34.7, 34.0, 33.4, 32.8, 32.3, 31.9, 31.7, 31.9, 32.5, 33.6, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 36.1, 35.8, 35.6, 35.3, 35.1, 34.8, 34.5, 34.2, 34.0, 33.8, …
```
