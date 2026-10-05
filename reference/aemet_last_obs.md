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
#> Rows: 24
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-10-04 22:00:00, 2026-10-04 23:00:00, 2026-10-05 00:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.8, 3.2, 2.4, 2.6, 2.2, 3.2, 3.4, 3.1, 2.8, 3.6, 3.1, 3.7, …
#> $ vv        <dbl> 2.4, 2.0, 1.4, 1.3, 1.7, 2.3, 1.8, 1.5, 1.5, 2.2, 1.6, 1.9, …
#> $ dv        <dbl> 106, 90, 138, 100, 115, 141, 151, 168, 113, 157, 114, 132, 7…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 98, 98, 110, 108, 118, 135, 128, 133, 128, 158, 173, 88, 72,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 991.6, 991.4, 991.4, 991.5, 991.3, 991.1, 991.4, 991.2, 991.…
#> $ hr        <dbl> 71, 76, 79, 82, 85, 85, 85, 85, 85, 83, 77, 75, 90, 92, 91, …
#> $ stdvv     <dbl> 0.5, 0.3, 0.2, 0.2, 0.2, 0.4, 0.4, 0.6, 0.2, 0.5, 0.4, 0.4, …
#> $ ts        <dbl> 21.0, 20.2, 19.4, 19.0, 18.3, 19.1, 19.3, 19.2, 19.2, 20.3, …
#> $ pres_nmar <dbl> 1020.8, 1020.7, 1020.7, 1020.9, 1020.8, 1020.5, 1020.8, 1020…
#> $ tamin     <dbl> 21.4, 20.7, 20.2, 19.5, 18.9, 18.7, 19.1, 19.3, 19.3, 19.3, …
#> $ ta        <dbl> 21.4, 20.7, 20.2, 19.5, 18.9, 19.1, 19.3, 19.4, 19.3, 20.0, …
#> $ tamax     <dbl> 22.0, 21.4, 20.7, 20.2, 19.5, 19.1, 19.3, 19.4, 19.4, 20.0, …
#> $ tpr       <dbl> 16.0, 16.3, 16.5, 16.3, 16.3, 16.5, 16.7, 16.8, 16.7, 17.1, …
#> $ stddv     <dbl> 9, 9, 20, 11, 10, 9, 16, 19, 11, 13, 22, 15, 16, 19, 11, 9, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.6, 60.0, 43.4…
#> $ tss5cm    <dbl> 23.8, 23.5, 23.2, 22.9, 22.6, 22.3, 22.2, 22.1, 21.9, 21.9, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 24.8, 24.7, 24.5, 24.4, 24.3, 24.1, 24.0, 23.8, 23.7, 23.6, …
```
