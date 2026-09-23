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
#> Rows: 12
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "3195", "319…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-09-23 03:00:00, 2026-09-23 04:00:00, 2026-09-23 05:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 667, 667, 667, 667, 667, 667
#> $ vmax      <dbl> 3.4, 1.6, 1.8, 2.0, 2.0, 4.5, 5.7, 6.6, 5.1, 5.1, 4.1, 4.0
#> $ vv        <dbl> 2.0, 0.9, 1.2, 1.1, 0.9, 2.9, 2.9, 3.0, 2.8, 2.2, 1.5, 1.3
#> $ dv        <dbl> 298, 332, 0, 350, 248, 305, 35, 45, 79, 73, 47, 63
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 295, 298, 338, 358, 305, 300, 41, 36, 64, 66, 63, 36
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 991.3, 991.5, 992.0, 992.5, 993.2, 993.6, 943.1, 943.4, 943.…
#> $ hr        <dbl> 44, 54, 61, 63, 58, 46, 37, 37, 40, 41, 43, 42
#> $ stdvv     <dbl> 0.4, 0.3, 0.2, 0.2, 0.1, 0.5, 0.8, 0.7, 0.8, 0.7, 0.5, 0.5
#> $ ts        <dbl> 18.4, 15.5, 15.1, 15.5, 19.4, 23.1, NA, NA, NA, NA, NA, NA
#> $ pres_nmar <dbl> 1020.8, 1021.2, 1021.8, 1022.4, 1023.0, 1023.1, 1018.0, 1018…
#> $ tamin     <dbl> 18.7, 17.6, 16.3, 16.1, 15.8, 17.0, 21.7, 21.2, 20.4, 19.7, …
#> $ ta        <dbl> 19.4, 17.6, 16.3, 16.1, 17.0, 19.7, 21.7, 21.2, 20.4, 19.7, …
#> $ tamax     <dbl> 19.4, 19.4, 17.6, 16.4, 17.0, 19.7, 22.2, 21.7, 21.2, 20.4, …
#> $ tpr       <dbl> 6.8, 8.1, 8.8, 9.0, 8.7, 7.7, 6.4, 5.9, 6.4, 6.1, 6.5, 6.8
#> $ stddv     <dbl> 16, 22, 15, 49, 16, 11, 17, 17, 18, 18, 22, 29
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 54.4, 60.0, NA, NA, NA, NA, NA, NA
#> $ tss5cm    <dbl> 26.1, 25.6, 25.1, 24.6, 24.2, 24.3, NA, NA, NA, NA, NA, NA
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA
#> $ tss20cm   <dbl> 28.8, 28.6, 28.3, 28.1, 27.9, 27.6, NA, NA, NA, NA, NA, NA
```
