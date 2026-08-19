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
#> $ fint      <dttm> 2026-08-19 00:00:00, 2026-08-19 01:00:00, 2026-08-19 02:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.5, 3.8, 4.8, 2.8, 1.5, 2.9, 1.5, 3.0, 3.4, 2.8, 3.7, 4.5, …
#> $ vv        <dbl> 3.1, 3.1, 1.8, 1.0, 0.8, 0.9, 0.4, 2.1, 0.5, 1.5, 2.4, 3.2, …
#> $ dv        <dbl> 274, 262, 262, 93, 176, 262, 31, 354, 335, 48, 93, 97, 315, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 318, 258, 270, 235, 95, 235, 345, 355, 305, 45, 78, 100, 277…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.0, 984.6, 984.2, 984.2, 983.9, 983.6, 984.0, 984.2, 984.…
#> $ hr        <dbl> 40, 40, 38, 50, 48, 46, 52, 47, 42, 36, 31, 28, 35, 37, 41, …
#> $ stdvv     <dbl> 0.3, 0.3, 0.3, 0.1, 0.1, 0.2, 0.2, 0.4, 0.3, 0.4, 0.5, 0.5, …
#> $ ts        <dbl> 25.5, 25.0, 23.8, 21.9, 21.0, 21.9, 22.7, 26.9, 30.9, 33.6, …
#> $ pres_nmar <dbl> 1013.6, 1013.2, 1012.9, 1013.1, 1012.8, 1012.5, 1012.9, 1013…
#> $ tamin     <dbl> 26.2, 25.5, 24.7, 23.0, 22.6, 22.7, 21.9, 22.4, 23.5, 25.8, …
#> $ ta        <dbl> 26.2, 25.5, 24.7, 23.0, 22.8, 22.8, 22.4, 23.5, 25.8, 28.3, …
#> $ tamax     <dbl> 28.2, 26.3, 25.5, 24.7, 23.0, 22.9, 22.8, 23.7, 25.8, 28.4, …
#> $ tpr       <dbl> 11.6, 10.9, 9.4, 12.0, 11.2, 10.5, 12.1, 11.6, 11.9, 11.8, 1…
#> $ stddv     <dbl> 8, 5, 7, 11, 19, 15, 49, 13, 61, 41, 17, 20, 9, 38, 29, 34, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 18.4, 60.0, 60.0, 60.0, 60.0, …
#> $ tss5cm    <dbl> 34.0, 33.4, 32.7, 32.1, 31.5, 31.0, 30.5, 30.3, 30.6, 31.6, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.01, 0.00, …
#> $ tss20cm   <dbl> 35.0, 34.8, 34.7, 34.4, 34.2, 34.0, 33.7, 33.5, 33.2, 33.0, …
```
