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
#> $ fint      <dttm> 2026-08-26 00:00:00, 2026-08-26 01:00:00, 2026-08-26 02:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.8, 4.0, 2.9, 3.5, 3.1, 5.4, 6.2, 6.2, 8.8, 9.4, 10.8, 12.1…
#> $ vv        <dbl> 3.2, 1.8, 1.7, 2.3, 1.9, 3.3, 3.6, 3.7, 6.3, 6.0, 7.1, 5.8, …
#> $ dv        <dbl> 111, 92, 79, 99, 102, 116, 134, 113, 141, 127, 120, 116, 100…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 108, 110, 88, 75, 103, 130, 150, 115, 138, 125, 128, 128, 11…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 983.5, 983.0, 983.2, 983.3, 982.9, 982.6, 982.8, 982.0, 982.…
#> $ hr        <dbl> 49, 53, 61, 66, 66, 70, 70, 66, 64, 57, 49, 45, 40, 53, 54, …
#> $ stdvv     <dbl> 0.5, 0.3, 0.4, 0.3, 0.5, 0.4, 0.8, 0.6, 1.2, 1.1, 1.3, 1.3, …
#> $ ts        <dbl> 24.5, 22.9, 21.4, 21.0, 20.9, 21.1, 21.9, 25.2, 25.7, 29.2, …
#> $ pres_nmar <dbl> 1012.1, 1011.7, 1012.1, 1012.2, 1011.9, 1011.6, 1011.7, 1010…
#> $ tamin     <dbl> 24.7, 23.9, 22.3, 21.7, 21.4, 21.0, 21.3, 21.9, 23.4, 24.8, …
#> $ ta        <dbl> 25.1, 23.9, 22.3, 21.7, 21.4, 21.3, 21.9, 23.5, 24.8, 26.9, …
#> $ tamax     <dbl> 25.3, 25.1, 23.9, 22.3, 21.7, 21.4, 21.9, 23.5, 24.8, 26.9, …
#> $ tpr       <dbl> 13.7, 13.8, 14.4, 15.1, 14.8, 15.6, 16.1, 16.8, 17.5, 17.7, …
#> $ stddv     <dbl> 8, 10, 9, 8, 10, 9, 11, 13, 10, 11, 12, 12, 12, 5, 8, 12, 49…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 31.6, 18.5, 60.0, 60.0, 5…
#> $ tss5cm    <dbl> 31.3, 30.8, 30.3, 29.8, 29.4, 29.0, 28.7, 28.6, 28.9, 29.3, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 32.8, 32.7, 32.5, 32.3, 32.1, 31.9, 31.7, 31.4, 31.2, 31.1, …
```
