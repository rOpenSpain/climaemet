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
#> $ fint      <dttm> 2026-07-18 07:00:00, 2026-07-18 08:00:00, 2026-07-18 09:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 8.3, 9.0, 7.5, 5.1, 5.4, 3.9, 3.5, 4.1, 5.7, 5.6, 4.7, 3.1, …
#> $ vv        <dbl> 5.5, 6.0, 3.4, 2.7, 2.3, 1.6, 1.7, 1.7, 3.6, 3.9, 2.4, 1.3, …
#> $ dv        <dbl> 314, 319, 319, 312, 315, 258, 124, 86, 121, 113, 99, 16, 64,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 315, 310, 295, 273, 220, 330, 115, 110, 128, 118, 120, 95, 4…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 987.0, 987.1, 986.7, 986.2, 985.8, 985.1, 983.8, 983.1, 982.…
#> $ hr        <dbl> 60, 58, 54, 47, 42, 37, 34, 31, 26, 25, 24, 23, 41, 28, 31, …
#> $ stdvv     <dbl> 1.0, 1.0, 1.0, 1.1, 0.6, 0.7, 0.6, 0.7, 0.8, 0.7, 0.7, 0.4, …
#> $ ts        <dbl> 25.7, 27.6, 31.1, 34.0, 36.5, 38.5, 39.3, 40.1, 39.8, 39.0, …
#> $ pres_nmar <dbl> 1015.9, 1015.9, 1015.3, 1014.6, 1014.0, 1013.1, 1011.6, 1010…
#> $ tamin     <dbl> 22.3, 23.3, 24.1, 25.6, 27.6, 29.6, 31.5, 33.2, 34.3, 35.5, …
#> $ ta        <dbl> 23.3, 24.1, 25.6, 27.7, 29.8, 31.5, 33.4, 34.3, 35.5, 36.1, …
#> $ tamax     <dbl> 23.3, 24.2, 25.6, 27.8, 30.1, 31.5, 33.5, 34.4, 35.6, 36.3, …
#> $ tpr       <dbl> 15.1, 15.3, 15.6, 15.3, 15.5, 15.1, 15.4, 14.7, 13.1, 13.0, …
#> $ stddv     <dbl> 12, 11, 16, 24, 28, 49, 36, 27, 12, 15, 18, 125, 25, 24, 34,…
#> $ inso      <dbl> 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 59.0, …
#> $ tss5cm    <dbl> 31.6, 31.7, 32.3, 33.5, 35.2, 37.1, 39.0, 40.5, 41.6, 41.9, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.01, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 34.4, 34.2, 33.9, 33.8, 33.7, 33.7, 33.9, 34.1, 34.5, 34.9, …
```
