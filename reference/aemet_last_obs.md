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
#> $ fint      <dttm> 2026-07-12 20:00:00, 2026-07-12 21:00:00, 2026-07-12 22:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 12.5, 11.0, 11.3, 10.7, 9.2, 7.6, 7.6, 7.5, 7.3, 6.1, 4.8, 6…
#> $ vv        <dbl> 7.0, 6.5, 6.4, 6.3, 4.5, 3.8, 4.6, 4.5, 4.6, 2.4, 3.3, 2.5, …
#> $ dv        <dbl> 118, 112, 108, 125, 113, 108, 121, 115, 116, 111, 126, 94, 2…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 118, 110, 120, 120, 118, 123, 123, 125, 128, 113, 130, 140, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 981.4, 982.2, 982.5, 983.0, 983.3, 983.4, 983.4, 983.5, 983.…
#> $ hr        <dbl> 50, 54, 60, 65, 68, 69, 68, 63, 63, 67, 66, 62, 31, 32, 33, …
#> $ stdvv     <dbl> 1.3, 1.1, 1.2, 1.0, 0.8, 0.8, 0.8, 0.8, 0.8, 0.3, 0.5, 0.5, …
#> $ ts        <dbl> 28.9, 28.0, 27.1, 26.5, 25.9, 25.6, 25.4, 25.2, 24.8, 24.3, …
#> $ pres_nmar <dbl> 1009.5, 1010.5, 1010.8, 1011.4, 1011.8, 1011.9, 1011.9, 1012…
#> $ tamin     <dbl> 28.9, 27.9, 27.0, 26.4, 25.8, 25.5, 25.3, 25.2, 24.8, 24.5, …
#> $ ta        <dbl> 28.9, 27.9, 27.0, 26.4, 25.8, 25.5, 25.3, 25.2, 24.8, 24.5, …
#> $ tamax     <dbl> 31.0, 28.9, 27.9, 27.0, 26.4, 25.8, 25.5, 25.3, 25.2, 24.8, …
#> $ tpr       <dbl> 17.5, 17.7, 18.5, 19.3, 19.4, 19.4, 19.0, 17.6, 17.3, 17.9, …
#> $ stddv     <dbl> 8, 10, 8, 9, 9, 10, 9, 8, 10, 8, 12, 17, 18, 23, 15, 22, 13,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 29.8,…
#> $ tss5cm    <dbl> 36.0, 35.2, 34.5, 33.9, 33.4, 33.0, 32.6, 32.2, 31.9, 31.5, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 34.4, 34.4, 34.4, 34.3, 34.2, 34.0, 33.8, 33.7, 33.5, 33.3, …
```
