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
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  A logical value. If `TRUE`, displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  unless `verbose = TRUE`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
an [`sf`](https://r-spatial.github.io/sf/reference/sf.html) object.

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
#> $ fint      <dttm> 2026-10-05 02:00:00, 2026-10-05 03:00:00, 2026-10-05 04:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.2, 3.2, 3.4, 3.1, 2.8, 3.6, 3.1, 3.7, 4.6, 4.6, 5.5, 5.6, …
#> $ vv        <dbl> 1.7, 2.3, 1.8, 1.5, 1.5, 2.2, 1.6, 1.9, 2.8, 2.4, 2.9, 3.7, …
#> $ dv        <dbl> 115, 141, 151, 168, 113, 157, 114, 132, 113, 80, 98, 103, 79…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 118, 135, 128, 133, 128, 158, 173, 88, 120, 120, 113, 115, 6…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 991.3, 991.1, 991.4, 991.2, 991.3, 991.7, 991.9, 992.1, 991.…
#> $ hr        <dbl> 85, 85, 85, 85, 85, 83, 77, 75, 67, 64, 59, 55, 51, 90, 90, …
#> $ stdvv     <dbl> 0.2, 0.4, 0.4, 0.6, 0.2, 0.5, 0.4, 0.4, 0.6, 0.6, 0.9, 0.8, …
#> $ ts        <dbl> 18.3, 19.1, 19.3, 19.2, 19.2, 20.3, 23.7, 23.8, 27.6, 28.8, …
#> $ pres_nmar <dbl> 1020.8, 1020.5, 1020.8, 1020.6, 1020.7, 1021.0, 1021.1, 1021…
#> $ tamin     <dbl> 18.9, 18.7, 19.1, 19.3, 19.3, 19.3, 20.0, 21.6, 22.1, 23.8, …
#> $ ta        <dbl> 18.9, 19.1, 19.3, 19.4, 19.3, 20.0, 21.6, 22.1, 23.8, 24.6, …
#> $ tamax     <dbl> 19.5, 19.1, 19.3, 19.4, 19.4, 20.0, 21.6, 22.1, 23.8, 24.7, …
#> $ tpr       <dbl> 16.3, 16.5, 16.7, 16.8, 16.7, 17.1, 17.4, 17.5, 17.3, 17.3, …
#> $ stddv     <dbl> 10, 9, 16, 19, 11, 13, 22, 15, 12, 14, 21, 14, 18, 15, 21, 1…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 5.6, 60.0, 43.4, 46.6, 57.8, 59.4, …
#> $ tss5cm    <dbl> 22.6, 22.3, 22.2, 22.1, 21.9, 21.9, 22.1, 22.8, 23.5, 25.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 24.3, 24.1, 24.0, 23.8, 23.7, 23.6, 23.5, 23.4, 23.4, 23.5, …
```
