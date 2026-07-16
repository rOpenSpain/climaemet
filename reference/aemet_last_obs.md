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
#> $ fint      <dttm> 2026-07-16 02:00:00, 2026-07-16 03:00:00, 2026-07-16 04:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 12.9, 12.1, 11.0, 9.4, 10.1, 10.5, 8.9, 6.5, 4.2, 3.4, 4.8, …
#> $ vv        <dbl> 9.0, 8.3, 8.0, 6.7, 6.3, 6.0, 4.7, 2.8, 1.5, 1.0, 2.9, 3.9, …
#> $ dv        <dbl> 309, 306, 300, 300, 305, 309, 314, 291, 126, 198, 102, 109, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 313, 320, 303, 308, 313, 310, 303, 318, 330, 128, 123, 100, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 985.8, 986.6, 986.3, 986.4, 986.0, 986.4, 986.8, 987.3, 986.…
#> $ hr        <dbl> 56, 59, 61, 63, 63, 63, 61, 51, 45, 45, 36, 34, 46, 45, 49, …
#> $ stdvv     <dbl> 1.3, 0.9, 0.9, 0.8, 1.1, 1.4, 0.9, 0.8, 0.5, 0.6, 0.7, 0.8, …
#> $ ts        <dbl> 26.4, 25.7, 25.3, 25.1, 25.2, 25.9, 26.9, 32.5, 36.2, 37.4, …
#> $ pres_nmar <dbl> 1014.4, 1015.3, 1015.0, 1015.1, 1014.7, 1015.1, 1015.5, 1015…
#> $ tamin     <dbl> 25.8, 25.2, 24.8, 24.5, 24.3, 24.2, 24.3, 25.0, 27.0, 29.7, …
#> $ ta        <dbl> 25.8, 25.2, 24.8, 24.5, 24.4, 24.5, 25.1, 27.1, 29.8, 30.8, …
#> $ tamax     <dbl> 26.7, 25.8, 25.2, 24.8, 24.5, 24.7, 25.1, 27.3, 29.9, 30.8, …
#> $ tpr       <dbl> 16.4, 16.6, 16.7, 17.0, 16.9, 17.0, 17.1, 16.0, 16.6, 17.5, …
#> $ stddv     <dbl> 8, 7, 6, 7, 7, 13, 10, 26, 34, 83, 24, 13, 7, 10, 9, 61, 8, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 17.1, 49.1, 59.1, 56.1, 56.1, …
#> $ tss5cm    <dbl> 35.5, 34.8, 34.3, 33.7, 33.3, 33.0, 32.9, 33.1, 34.3, 35.9, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 36.2, 36.0, 35.8, 35.6, 35.3, 35.1, 34.8, 34.6, 34.4, 34.3, …
```
