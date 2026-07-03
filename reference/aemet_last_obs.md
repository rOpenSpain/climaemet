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
#> $ fint      <dttm> 2026-07-03 11:00:00, 2026-07-03 12:00:00, 2026-07-03 13:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 10.5, 11.6, 14.7, 12.2, 13.6, 15.0, 16.3, 17.4, 14.6, 14.9, …
#> $ vv        <dbl> 6.8, 6.7, 8.1, 8.6, 9.6, 11.0, 10.7, 10.6, 9.9, 10.7, 11.3, …
#> $ dv        <dbl> 304, 317, 311, 311, 315, 313, 314, 315, 307, 304, 309, 305, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 293, 303, 298, 305, 303, 313, 310, 305, 315, 325, 310, 313, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 994.4, 993.8, 993.0, 992.4, 991.8, 991.4, 991.4, 991.9, 992.…
#> $ hr        <dbl> 40, 37, 32, 30, 30, 32, 35, 40, 45, 52, 55, 58, 23, 22, 20, …
#> $ stdvv     <dbl> 1.0, 1.4, 1.5, 1.6, 1.5, 1.7, 2.2, 1.7, 1.8, 1.5, 1.6, 1.9, …
#> $ ts        <dbl> 33.8, 36.5, 38.0, 38.7, 38.3, 37.0, 34.7, 31.4, 28.1, 25.8, …
#> $ pres_nmar <dbl> 1023.0, 1022.2, 1021.3, 1020.5, 1019.9, 1019.5, 1019.6, 1020…
#> $ tamin     <dbl> 26.2, 28.2, 30.1, 31.7, 32.9, 32.6, 31.5, 29.6, 27.6, 25.5, …
#> $ ta        <dbl> 28.3, 30.2, 31.8, 33.1, 33.1, 32.6, 31.6, 29.7, 27.6, 25.5, …
#> $ tamax     <dbl> 28.3, 30.2, 32.0, 33.1, 33.4, 33.2, 32.7, 31.6, 29.7, 27.6, …
#> $ tpr       <dbl> 13.5, 13.9, 13.1, 13.2, 13.2, 13.8, 14.2, 14.6, 14.6, 14.9, …
#> $ stddv     <dbl> 14, 14, 13, 9, 10, 7, 15, 9, 8, 8, 8, 8, 38, 25, 50, 50, 46,…
#> $ inso      <dbl> 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 29.9, …
#> $ tss5cm    <dbl> 29.6, 31.5, 33.3, 34.7, 35.5, 35.8, 35.5, 34.7, 33.6, 32.4, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 27.7, 27.8, 28.1, 28.5, 28.9, 29.4, 29.9, 30.3, 30.6, 30.7, …
```
