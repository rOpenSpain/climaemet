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
#> $ fint      <dttm> 2026-10-22 23:00:00, 2026-10-23 00:00:00, 2026-10-23 01:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.9, 4.6, 5.4, 6.1, 4.2, 5.4, 5.6, 4.3, 4.7, 6.9, 10.8, 9.3,…
#> $ vv        <dbl> 2.9, 2.7, 2.2, 1.9, 2.7, 3.3, 2.2, 0.6, 3.6, 4.0, 7.3, 5.1, …
#> $ dv        <dbl> 116, 97, 96, 127, 134, 107, 123, 354, 274, 307, 311, 323, 31…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 110, 100, 108, 108, 120, 103, 110, 253, 270, 310, 313, 318, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 991.4, 991.3, 991.1, 990.8, 990.3, 990.4, 990.9, 991.5, 992.…
#> $ hr        <dbl> 70, 71, 72, 74, 75, 72, 73, 73, 77, 62, 58, 57, 48, 70, 74, …
#> $ stdvv     <dbl> 0.3, 0.4, 1.1, 0.4, 0.5, 0.7, 1.0, 0.3, 0.5, 0.6, 1.3, 1.0, …
#> $ ts        <dbl> 11.5, 11.8, 11.7, 11.3, 11.4, 11.6, 11.1, 10.3, 10.2, 13.4, …
#> $ pres_nmar <dbl> 1021.7, 1021.6, 1021.4, 1021.1, 1020.6, 1020.7, 1021.2, 1021…
#> $ tamin     <dbl> 12.1, 11.9, 11.9, 11.9, 11.6, 11.7, 11.5, 11.5, 10.4, 10.8, …
#> $ ta        <dbl> 12.1, 12.1, 11.9, 11.9, 11.7, 11.9, 11.6, 11.5, 10.8, 13.7, …
#> $ tamax     <dbl> 12.5, 12.1, 12.1, 12.1, 11.9, 11.9, 11.9, 12.0, 11.5, 13.7, …
#> $ tpr       <dbl> 6.8, 7.0, 7.0, 7.4, 7.4, 7.0, 7.0, 6.8, 7.0, 6.5, 7.4, 7.6, …
#> $ stddv     <dbl> 7, 8, 20, 11, 10, 11, 27, 85, 15, 10, 9, 11, 11, 13, 14, 16,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 30.2, 56.1…
#> $ tss5cm    <dbl> 15.1, 14.9, 14.8, 14.7, 14.5, 14.4, 14.3, 14.1, 13.9, 13.8, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 17.0, 16.9, 16.8, 16.7, 16.6, 16.5, 16.4, 16.3, 16.2, 16.1, …
```
