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
[`httr2::req_timeout()`](https://rdrr.io/pkg/httr2/man/req_timeout.html)
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
#> $ fint      <dttm> 2026-07-17 19:00:00, 2026-07-17 20:00:00, 2026-07-17 21:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 10.0, 12.0, 12.1, 10.9, 12.4, 12.2, 12.2, 13.9, 10.3, 8.8, 7…
#> $ vv        <dbl> 6.9, 8.1, 7.3, 7.5, 7.5, 7.9, 8.9, 6.9, 6.3, 5.4, 4.7, 4.5, …
#> $ dv        <dbl> 316, 310, 309, 304, 306, 306, 298, 301, 298, 301, 310, 302, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 320, 308, 313, 308, 300, 300, 300, 293, 288, 300, 313, 305, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 982.9, 984.1, 985.4, 985.7, 985.9, 985.9, 985.8, 986.0, 986.…
#> $ hr        <dbl> 34, 40, 46, 51, 57, 60, 60, 62, 62, 63, 65, 64, 60, 21, 25, …
#> $ stdvv     <dbl> 1.0, 1.3, 1.1, 1.1, 1.0, 1.6, 1.3, 1.0, 1.3, 0.8, 0.6, 0.7, …
#> $ ts        <dbl> 33.1, 30.6, 28.5, 27.1, 25.6, 24.5, 24.2, 23.6, 23.3, 22.9, …
#> $ pres_nmar <dbl> 1010.8, 1012.2, 1013.8, 1014.2, 1014.6, 1014.7, 1014.6, 1014…
#> $ tamin     <dbl> 32.4, 30.1, 28.0, 26.6, 25.1, 24.0, 23.7, 23.2, 23.0, 22.7, …
#> $ ta        <dbl> 32.4, 30.1, 28.0, 26.6, 25.1, 24.1, 23.7, 23.2, 23.0, 22.7, …
#> $ tamax     <dbl> 36.3, 32.4, 30.1, 28.0, 26.7, 25.1, 24.1, 23.7, 23.2, 23.0, …
#> $ tpr       <dbl> 14.5, 15.0, 15.3, 15.6, 16.0, 15.9, 15.4, 15.5, 15.3, 15.3, …
#> $ stddv     <dbl> 8, 8, 9, 9, 8, 9, 7, 9, 8, 8, 9, 8, 12, 18, 13, 16, 17, 13, …
#> $ inso      <dbl> 48.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 35.7…
#> $ tss5cm    <dbl> 40.7, 39.4, 38.1, 37.0, 36.1, 35.3, 34.5, 33.9, 33.3, 32.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 36.0, 36.3, 36.4, 36.4, 36.3, 36.2, 36.0, 35.7, 35.5, 35.2, …
```
