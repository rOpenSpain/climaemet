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
#> $ fint      <dttm> 2026-08-05 02:00:00, 2026-08-05 03:00:00, 2026-08-05 04:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 9.4, 10.0, 10.7, 10.6, 11.4, 11.0, 11.5, 9.0, 8.6, 7.5, 6.0,…
#> $ vv        <dbl> 5.0, 7.6, 6.9, 6.8, 7.1, 7.8, 7.1, 4.8, 5.1, 3.6, 2.1, 2.9, …
#> $ dv        <dbl> 311, 303, 305, 299, 300, 308, 314, 318, 315, 303, 293, 305, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 318, 303, 303, 313, 298, 305, 293, 300, 305, 313, 315, 298, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.3, 988.3, 988.5, 988.9, 989.4, 989.7, 989.7, 989.6, 989.…
#> $ hr        <dbl> 55, 53, 49, 58, 60, 60, 59, 54, 50, 46, 43, 40, 45, 46, 46, …
#> $ stdvv     <dbl> 0.8, 0.9, 0.9, 0.7, 0.8, 1.1, 1.1, 0.8, 0.9, 1.1, 0.9, 0.7, …
#> $ ts        <dbl> 24.5, 24.2, 23.7, 23.1, 23.6, 25.1, 27.2, 30.5, 32.9, 35.8, …
#> $ pres_nmar <dbl> 1017.1, 1017.2, 1017.4, 1017.9, 1018.4, 1018.7, 1018.6, 1018…
#> $ tamin     <dbl> 24.4, 24.0, 23.5, 22.8, 22.6, 22.7, 23.2, 24.1, 25.9, 27.4, …
#> $ ta        <dbl> 24.4, 24.0, 23.5, 22.9, 22.7, 23.2, 24.1, 25.9, 27.5, 29.4, …
#> $ tamax     <dbl> 25.3, 24.4, 24.0, 23.5, 22.9, 23.2, 24.1, 25.9, 27.5, 29.4, …
#> $ tpr       <dbl> 14.8, 13.9, 12.2, 14.2, 14.5, 15.0, 15.6, 15.9, 16.1, 16.6, …
#> $ stddv     <dbl> 8, 7, 7, 6, 7, 9, 9, 14, 13, 26, 28, 22, 29, 18, 29, 15, 23,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 32.2, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0…
#> $ tss5cm    <dbl> 33.6, 33.0, 32.5, 32.0, 31.5, 31.3, 31.3, 31.8, 32.7, 34.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 35.0, 34.8, 34.6, 34.4, 34.2, 33.9, 33.7, 33.5, 33.3, 33.2, …
```
