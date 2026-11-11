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
#> $ fint      <dttm> 2026-11-11 07:00:00, 2026-11-11 08:00:00, 2026-11-11 09:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.9, 4.0, 3.9, 4.4, 4.2, 4.6, 5.2, 3.7, 5.1, 4.4, 3.9, 6.4, …
#> $ vv        <dbl> 0.8, 1.6, 2.4, 2.0, 3.1, 2.2, 2.8, 2.4, 3.6, 2.3, 1.3, 2.8, …
#> $ dv        <dbl> 187, 105, 116, 101, 121, 108, 97, 100, 113, 126, 127, 115, 1…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 155, 58, 128, 113, 113, 120, 115, 108, 118, 123, 130, 138, 1…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 978.6, 978.6, 978.5, 978.2, 978.0, 976.9, 976.0, 974.9, 973.…
#> $ hr        <dbl> 93, 96, 95, 94, 91, 93, 92, 93, 90, 89, 92, 91, 97, 98, 98, …
#> $ stdvv     <dbl> 0.5, 0.3, 0.3, 0.4, 0.5, 0.3, 0.5, 0.4, 0.6, 0.3, 0.2, 0.3, …
#> $ ts        <dbl> 14.0, 14.2, 14.8, 15.4, 15.8, 15.9, 16.3, 16.4, 16.5, 16.1, …
#> $ pres_nmar <dbl> 1008.1, 1008.2, 1008.0, 1007.7, 1007.4, 1006.3, 1005.3, 1004…
#> $ tamin     <dbl> 14.7, 14.5, 14.5, 14.8, 15.3, 15.6, 15.8, 16.1, 16.3, 16.5, …
#> $ ta        <dbl> 14.8, 14.5, 14.8, 15.3, 15.7, 15.8, 16.1, 16.3, 16.6, 16.5, …
#> $ tamax     <dbl> 15.0, 14.8, 14.8, 15.3, 15.7, 15.8, 16.1, 16.3, 16.6, 16.7, …
#> $ tpr       <dbl> 13.7, 13.9, 14.0, 14.3, 14.2, 14.7, 14.8, 15.2, 15.0, 14.7, …
#> $ stddv     <dbl> 84, 12, 11, 9, 9, 11, 11, 10, 8, 12, 20, 7, 28, 73, 20, 16, …
#> $ inso      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss5cm    <dbl> 14.7, 14.7, 14.7, 15.0, 15.2, 15.4, 15.6, 15.8, 16.0, 16.0, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.15, 0.12, 0.11, 0.01, 0.10, …
#> $ tss20cm   <dbl> 15.6, 15.6, 15.5, 15.5, 15.5, 15.5, 15.6, 15.6, 15.7, 15.8, …
```
