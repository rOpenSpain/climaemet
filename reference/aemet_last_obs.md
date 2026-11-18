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
#> $ fint      <dttm> 2026-11-18 07:00:00, 2026-11-18 08:00:00, 2026-11-18 09:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 8.6, 11.8, 16.6, 13.9, 10.5, 10.3, 9.2, 9.8, 6.4, 10.3, 6.4,…
#> $ vv        <dbl> 4.2, 8.5, 12.3, 3.3, 8.0, 5.8, 6.4, 1.9, 2.7, 6.3, 2.4, 6.3,…
#> $ dv        <dbl> 253, 285, 287, 319, 310, 303, 278, 309, 337, 282, 114, 229, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 250, 283, 290, 285, 308, 290, 288, 285, 328, 278, 285, 235, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 977.7, 978.0, 978.3, 979.0, 979.0, 978.5, 978.1, 977.8, 977.…
#> $ hr        <dbl> 61, 61, 58, 66, 53, 50, 43, 41, 43, 40, 46, 55, 55, 92, 91, …
#> $ stdvv     <dbl> 0.7, 0.9, 1.6, 0.5, 1.0, 1.2, 0.8, 0.5, 0.5, 0.8, 0.6, 0.9, …
#> $ ts        <dbl> 18.5, 19.0, 19.8, 19.4, 22.8, 23.6, 22.8, 21.1, 21.3, 21.4, …
#> $ pres_nmar <dbl> 1006.7, 1007.0, 1007.2, 1008.0, 1007.8, 1007.3, 1006.8, 1006…
#> $ tamin     <dbl> 19.4, 19.4, 20.1, 19.8, 19.9, 22.0, 22.0, 22.2, 21.9, 22.0, …
#> $ ta        <dbl> 19.7, 20.2, 20.8, 19.9, 22.0, 22.3, 22.8, 22.2, 22.2, 22.7, …
#> $ tamax     <dbl> 19.7, 20.2, 20.9, 21.0, 22.0, 22.7, 23.1, 22.8, 22.3, 23.0, …
#> $ tpr       <dbl> 12.0, 12.4, 12.2, 13.4, 12.0, 11.3, 9.6, 8.3, 9.0, 8.4, 9.3,…
#> $ stddv     <dbl> 15, 6, 6, 10, 7, 10, 7, 17, 14, 6, 18, 8, 14, 21, 22, 24, 25…
#> $ inso      <dbl> 0.0, 1.6, 23.7, 1.4, 57.0, 55.3, 49.3, 2.8, 1.6, 3.4, 0.0, 0…
#> $ tss5cm    <dbl> 14.9, 15.0, 15.2, 15.4, 16.0, 16.7, 17.1, 17.2, 17.1, 17.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 15.3, 15.3, 15.3, 15.3, 15.3, 15.4, 15.6, 15.8, 16.0, 16.1, …
```
