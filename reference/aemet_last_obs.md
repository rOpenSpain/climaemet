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
#> $ fint      <dttm> 2026-10-22 10:00:00, 2026-10-22 11:00:00, 2026-10-22 12:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.4, 4.0, 6.1, 6.9, 7.2, 7.6, 7.6, 6.3, 4.7, 4.6, 4.7, 4.1, …
#> $ vv        <dbl> 1.4, 2.8, 3.7, 4.1, 4.8, 5.1, 4.5, 3.5, 2.6, 3.3, 2.5, 1.7, …
#> $ dv        <dbl> 87, 99, 110, 117, 105, 112, 111, 119, 128, 112, 100, 103, 15…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 65, 113, 95, 133, 100, 120, 110, 120, 123, 105, 113, 108, 14…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 995.4, 995.1, 994.1, 992.9, 992.1, 991.5, 991.1, 991.3, 991.…
#> $ hr        <dbl> 65, 53, 48, 45, 43, 40, 39, 44, 50, 54, 59, 63, 56, 54, 52, …
#> $ stdvv     <dbl> 0.4, 0.6, 0.8, 0.8, 0.7, 1.0, 0.7, 0.5, 0.3, 0.4, 0.4, 0.3, …
#> $ ts        <dbl> 16.3, 18.1, 19.9, 21.2, 21.7, 19.1, 20.4, 16.8, 14.7, 14.2, …
#> $ pres_nmar <dbl> 1025.7, 1025.2, 1023.9, 1022.6, 1021.6, 1021.1, 1020.6, 1021…
#> $ tamin     <dbl> 10.3, 12.9, 15.3, 17.0, 18.3, 18.8, 18.5, 17.7, 16.1, 15.3, …
#> $ ta        <dbl> 12.9, 15.3, 17.0, 18.3, 19.3, 19.0, 19.5, 17.7, 16.1, 15.3, …
#> $ tamax     <dbl> 12.9, 15.3, 17.0, 18.3, 19.3, 19.7, 19.5, 19.5, 17.7, 16.4, …
#> $ tpr       <dbl> 6.5, 5.8, 5.9, 6.1, 6.4, 5.1, 5.1, 5.3, 5.6, 6.1, 6.4, 6.5, …
#> $ stddv     <dbl> 23, 15, 16, 13, 11, 10, 8, 7, 9, 9, 10, 11, 51, 45, 46, 28, …
#> $ inso      <dbl> 60.0, 59.4, 60.0, 60.0, 60.0, 45.3, 30.6, 32.4, 0.0, 0.0, 0.…
#> $ tss5cm    <dbl> 13.8, 15.1, 16.5, 17.7, 18.6, 18.9, 18.5, 18.1, 17.4, 16.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 15.3, 15.3, 15.4, 15.6, 15.9, 16.3, 16.6, 16.9, 17.1, 17.2, …
```
