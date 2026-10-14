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
#> $ fint      <dttm> 2026-10-14 04:00:00, 2026-10-14 05:00:00, 2026-10-14 06:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.7, 4.0, 1.5, 1.5, 1.8, 1.9, 2.5, 3.5, 3.6, 4.6, 4.9, 3.4, …
#> $ vv        <dbl> 3.2, 0.9, 0.5, 1.0, 0.7, 0.9, 1.0, 1.1, 1.6, 1.9, 1.8, 2.0, …
#> $ dv        <dbl> 269, 357, 124, 344, 119, 46, 314, 143, 70, 107, 104, 82, 29,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 275, 275, 90, 355, 328, 30, 333, 320, 78, 113, 123, 83, 14, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 997.9, 998.3, 998.3, 998.8, 999.0, 999.2, 999.1, 998.7, 997.…
#> $ hr        <dbl> 84, 88, 91, 90, 82, 75, 70, 62, 58, 53, 48, 46, 69, 69, 71, …
#> $ stdvv     <dbl> 0.2, 0.1, 0.2, 0.3, 0.2, 0.4, 0.3, 0.3, 0.7, 0.5, 0.7, 0.5, …
#> $ ts        <dbl> 16.8, 15.5, 14.7, 15.9, 20.5, 22.5, 26.0, 27.8, 28.9, 29.5, …
#> $ pres_nmar <dbl> 1027.7, 1028.3, 1028.4, 1028.8, 1028.8, 1028.8, 1028.6, 1027…
#> $ tamin     <dbl> 17.4, 16.4, 15.5, 15.4, 15.8, 17.8, 19.5, 21.1, 23.4, 24.4, …
#> $ ta        <dbl> 17.4, 16.4, 15.5, 15.8, 17.8, 19.7, 21.1, 23.4, 24.4, 25.8, …
#> $ tamax     <dbl> 17.8, 17.5, 16.4, 15.8, 17.8, 19.7, 21.1, 23.4, 24.5, 25.8, …
#> $ tpr       <dbl> 14.7, 14.4, 14.0, 14.1, 14.7, 15.2, 15.4, 15.7, 15.6, 15.5, …
#> $ stddv     <dbl> 5, 10, 39, 15, 23, 41, 33, 34, 59, 25, 22, 24, 21, 16, 16, 1…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 16.4, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.…
#> $ tss5cm    <dbl> 20.6, 20.3, 20.0, 19.7, 19.7, 20.2, 21.4, 22.8, 24.4, 25.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 22.5, 22.3, 22.1, 22.0, 21.8, 21.6, 21.5, 21.5, 21.7, 22.0, …
```
