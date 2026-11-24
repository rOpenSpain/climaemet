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
#> $ fint      <dttm> 2026-11-24 09:00:00, 2026-11-24 10:00:00, 2026-11-24 11:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.2, 0.2, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.0, 4.6, 4.5, 4.0, 4.3, 4.5, 3.0, 2.4, 2.8, 4.6, 4.4, 6.1, …
#> $ vv        <dbl> 2.2, 3.2, 2.7, 1.1, 3.1, 1.9, 1.7, 1.4, 1.2, 3.0, 2.7, 1.0, …
#> $ dv        <dbl> 100, 93, 101, 79, 101, 100, 134, 91, 51, 116, 191, 136, 239,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 118, 103, 90, 98, 100, 103, 145, 100, 93, 115, 195, 200, 238…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 989.6, 988.9, 988.4, 987.8, 986.4, 985.8, 985.3, 984.7, 984.…
#> $ hr        <dbl> 92, 88, 88, 87, 89, 90, 90, 92, 95, 96, 88, 90, 79, 76, 77, …
#> $ stdvv     <dbl> 0.4, 0.5, 0.4, 0.4, 0.5, 0.5, 0.4, 0.4, 0.4, 0.8, 0.6, 0.4, …
#> $ ts        <dbl> 6.8, 7.9, 8.9, 9.4, 9.1, 9.2, 9.2, 9.0, 8.7, 8.5, 8.8, 7.5, …
#> $ pres_nmar <dbl> 1020.4, 1019.6, 1019.0, 1018.3, 1016.9, 1016.2, 1015.7, 1015…
#> $ tamin     <dbl> 5.6, 6.5, 7.6, 8.5, 8.9, 8.9, 9.1, 9.0, 8.8, 8.7, 8.6, 9.0, …
#> $ ta        <dbl> 6.5, 7.6, 8.5, 8.9, 9.0, 9.1, 9.1, 9.0, 8.8, 8.7, 9.3, 9.0, …
#> $ tamax     <dbl> 6.5, 7.6, 8.5, 8.9, 9.2, 9.1, 9.2, 9.2, 9.0, 8.9, 9.3, 9.6, …
#> $ tpr       <dbl> 5.3, 5.8, 6.7, 6.8, 7.3, 7.6, 7.6, 7.7, 8.0, 8.1, 7.4, 7.4, …
#> $ stddv     <dbl> 11, 9, 11, 15, 10, 14, 18, 12, 28, 10, 13, 24, 7, 11, 16, 20…
#> $ inso      <dbl> 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ tss5cm    <dbl> 8.5, 8.8, 9.1, 9.5, 9.7, 9.9, 10.0, 10.1, 10.1, 10.0, 10.0, …
#> $ pacutp    <dbl> 0.00, 0.02, 0.00, 0.00, 0.14, 0.16, 0.06, 0.03, 0.10, 0.19, …
#> $ tss20cm   <dbl> 10.8, 10.7, 10.7, 10.7, 10.7, 10.8, 10.8, 10.9, 11.0, 11.0, …
```
