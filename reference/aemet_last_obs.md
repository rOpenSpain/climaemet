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
#> $ fint      <dttm> 2026-11-18 01:00:00, 2026-11-18 02:00:00, 2026-11-18 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 9.5, 13.2, 14.0, 13.2, 13.6, 12.8, 8.6, 11.8, 16.6, 13.9, 10…
#> $ vv        <dbl> 7.5, 9.9, 9.7, 9.0, 8.6, 6.8, 4.2, 8.5, 12.3, 3.3, 8.0, 5.8,…
#> $ dv        <dbl> 270, 264, 265, 272, 276, 262, 253, 285, 287, 319, 310, 303, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 270, 265, 268, 280, 288, 260, 250, 283, 290, 285, 308, 290, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 978.5, 978.0, 977.8, 977.3, 977.4, 977.4, 977.7, 978.0, 978.…
#> $ hr        <dbl> 61, 59, 57, 59, 61, 60, 61, 61, 58, 66, 53, 50, 43, 88, 92, …
#> $ stdvv     <dbl> 0.8, 1.1, 1.4, 1.3, 1.2, 1.1, 0.7, 0.9, 1.6, 0.5, 1.0, 1.2, …
#> $ ts        <dbl> 17.8, 18.2, 18.3, 17.9, 17.9, 18.7, 18.5, 19.0, 19.8, 19.4, …
#> $ pres_nmar <dbl> 1007.6, 1007.1, 1006.9, 1006.4, 1006.5, 1006.4, 1006.7, 1007…
#> $ tamin     <dbl> 18.6, 18.7, 19.1, 18.9, 18.7, 18.9, 19.4, 19.4, 20.1, 19.8, …
#> $ ta        <dbl> 18.9, 19.2, 19.4, 18.9, 19.0, 19.7, 19.7, 20.2, 20.8, 19.9, …
#> $ tamax     <dbl> 18.9, 19.2, 19.4, 19.4, 19.3, 19.8, 19.7, 20.2, 20.9, 21.0, …
#> $ tpr       <dbl> 11.2, 11.0, 10.6, 10.8, 11.3, 11.7, 12.0, 12.4, 12.2, 13.4, …
#> $ stddv     <dbl> 6, 5, 7, 6, 6, 9, 15, 6, 6, 10, 7, 10, 7, 24, 25, 29, 23, 23…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.6, 23.7, 1.4, 57.0, 55.…
#> $ tss5cm    <dbl> 14.9, 14.8, 14.8, 14.8, 14.8, 14.8, 14.9, 15.0, 15.2, 15.4, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 15.2, 15.2, 15.2, 15.2, 15.3, 15.3, 15.3, 15.3, 15.3, 15.3, …
```
