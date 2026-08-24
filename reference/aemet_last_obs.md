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
#> $ fint      <dttm> 2026-08-24 10:00:00, 2026-08-24 11:00:00, 2026-08-24 12:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 8.4, 8.8, 10.3, 14.5, 15.1, 13.8, 15.2, 14.3, 13.0, 10.1, 7.…
#> $ vv        <dbl> 5.0, 5.5, 5.3, 8.8, 7.7, 6.5, 8.6, 9.0, 8.2, 4.2, 4.6, 3.7, …
#> $ dv        <dbl> 111, 268, 273, 242, 255, 249, 262, 259, 267, 267, 252, 249, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 120, 118, 250, 230, 268, 248, 270, 268, 268, 250, 248, 248, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 982.5, 982.0, 981.2, 980.3, 980.1, 979.4, 978.9, 979.0, 979.…
#> $ hr        <dbl> 61, 24, 19, 8, 13, 15, 17, 21, 22, 24, 29, 29, 49, 43, 38, 3…
#> $ stdvv     <dbl> 1.0, 1.1, 1.3, 2.3, 2.1, 1.8, 1.4, 1.8, 1.2, 0.5, 0.9, 0.7, …
#> $ ts        <dbl> 31.6, 34.5, 38.1, 38.9, 39.3, 38.4, 37.5, 35.5, 32.3, 29.6, …
#> $ pres_nmar <dbl> 1010.6, 1010.0, 1009.0, 1008.0, 1007.7, 1007.1, 1006.6, 1006…
#> $ tamin     <dbl> 27.4, 28.7, 31.6, 33.3, 34.9, 34.7, 34.5, 33.5, 32.1, 30.5, …
#> $ ta        <dbl> 28.8, 31.6, 33.4, 35.1, 35.2, 34.8, 34.5, 33.5, 32.1, 30.5, …
#> $ tamax     <dbl> 28.9, 31.6, 33.4, 35.3, 35.6, 35.3, 35.1, 34.5, 33.5, 32.1, …
#> $ tpr       <dbl> 20.5, 8.5, 6.7, -4.2, 2.7, 4.3, 5.9, 8.1, 7.7, 7.7, 9.6, 9.0…
#> $ stddv     <dbl> 11, 19, 9, 19, 17, 15, 12, 9, 7, 6, 8, 10, 31, 30, 24, 29, 2…
#> $ inso      <dbl> 50.5, 34.1, 49.4, 60.0, 59.9, 56.7, 58.9, 55.9, 55.0, 29.7, …
#> $ tss5cm    <dbl> 29.8, 30.7, 31.5, 32.9, 34.0, 34.7, 35.1, 35.0, 34.5, 33.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 30.3, 30.3, 30.3, 30.4, 30.6, 30.8, 31.1, 31.4, 31.6, 31.9, …
```
