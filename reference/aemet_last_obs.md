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
#> $ fint      <dttm> 2026-07-12 13:00:00, 2026-07-12 14:00:00, 2026-07-12 15:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 13.1, 13.8, 13.9, 14.7, 14.6, 15.3, 15.5, 12.5, 11.0, 11.3, …
#> $ vv        <dbl> 9.7, 9.3, 9.1, 9.7, 10.3, 9.7, 8.5, 7.0, 6.5, 6.4, 6.3, 4.5,…
#> $ dv        <dbl> 110, 116, 122, 114, 118, 123, 107, 118, 112, 108, 125, 113, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 108, 128, 120, 120, 130, 125, 118, 118, 110, 120, 120, 118, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 982.1, 981.8, 981.4, 980.7, 980.1, 980.0, 980.6, 981.4, 982.…
#> $ hr        <dbl> 22, 21, 23, 28, 26, 29, 42, 50, 54, 60, 65, 68, 30, 30, 31, …
#> $ stdvv     <dbl> 1.8, 2.0, 1.4, 1.7, 1.5, 2.0, 1.7, 1.3, 1.1, 1.2, 1.0, 0.8, …
#> $ ts        <dbl> 37.0, 38.8, 38.4, 35.7, 34.8, 34.4, 30.9, 28.9, 28.0, 27.1, …
#> $ pres_nmar <dbl> 1009.8, 1009.5, 1009.0, 1008.4, 1007.8, 1007.7, 1008.5, 1009…
#> $ tamin     <dbl> 34.2, 34.1, 34.7, 33.8, 33.6, 33.4, 31.0, 28.9, 27.9, 27.0, …
#> $ ta        <dbl> 34.4, 34.9, 35.1, 33.8, 33.7, 33.4, 31.0, 28.9, 27.9, 27.0, …
#> $ tamax     <dbl> 35.1, 35.2, 35.4, 35.1, 34.3, 34.0, 33.4, 31.0, 28.9, 27.9, …
#> $ tpr       <dbl> 9.6, 9.3, 10.9, 12.7, 11.6, 13.0, 16.6, 17.5, 17.7, 18.5, 19…
#> $ stddv     <dbl> 9, 11, 10, 10, 10, 10, 11, 8, 10, 8, 9, 9, 40, 32, 29, 28, 2…
#> $ inso      <dbl> 23.2, 24.8, 60.0, 54.2, 24.0, 43.8, 45.4, 0.0, 0.0, 0.0, 0.0…
#> $ tss5cm    <dbl> 36.6, 37.1, 37.7, 38.2, 37.9, 37.4, 36.8, 36.0, 35.2, 34.5, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 32.9, 33.1, 33.3, 33.6, 33.8, 34.1, 34.2, 34.4, 34.4, 34.4, …
```
