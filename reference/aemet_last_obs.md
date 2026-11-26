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
#> $ fint      <dttm> 2026-11-25 12:00:00, 2026-11-25 13:00:00, 2026-11-25 14:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 11.8, 9.0, 5.2, 14.1, 18.1, 13.0, 2.9, 10.6, 8.2, 6.6, 7.0, …
#> $ vv        <dbl> 6.0, 3.6, 2.2, 10.3, 9.1, 1.4, 1.4, 5.7, 5.3, 4.0, 4.2, 6.2,…
#> $ dv        <dbl> 313, 309, 252, 270, 283, 329, 348, 313, 302, 284, 303, 316, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 305, 315, 260, 270, 268, 285, 328, 320, 315, 283, 288, 320, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 983.5, 982.8, 982.3, 981.0, 981.5, 982.4, 982.5, 983.0, 983.…
#> $ hr        <dbl> 72, 68, 73, 59, 56, 66, 72, 60, 67, 69, 62, 65, 60, 57, 55, …
#> $ stdvv     <dbl> 0.9, 0.5, 1.2, 1.4, 1.4, 0.4, 0.5, 1.6, 0.8, 0.7, 0.9, 1.0, …
#> $ ts        <dbl> 10.9, 10.7, 9.9, 12.2, 11.7, 10.2, 9.5, 11.4, 10.5, 10.2, 10…
#> $ pres_nmar <dbl> 1013.7, 1013.0, 1012.5, 1010.9, 1011.4, 1012.5, 1012.7, 1013…
#> $ tamin     <dbl> 10.8, 10.4, 9.9, 10.2, 12.6, 11.3, 10.6, 10.5, 10.8, 10.7, 1…
#> $ ta        <dbl> 10.8, 10.4, 10.2, 12.7, 12.6, 11.3, 10.7, 12.4, 11.2, 10.8, …
#> $ tamax     <dbl> 12.4, 10.8, 10.4, 12.7, 13.3, 12.7, 11.3, 12.5, 12.4, 11.2, …
#> $ tpr       <dbl> 5.9, 4.8, 5.6, 4.8, 4.1, 5.1, 5.8, 4.8, 5.3, 5.3, 4.3, 4.3, …
#> $ stddv     <dbl> 9, 8, 23, 7, 7, 17, 22, 10, 10, 7, 10, 9, 22, 20, 19, 32, 27…
#> $ inso      <dbl> 1.1, 0.0, 0.0, 15.0, 11.7, 1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0…
#> $ tss5cm    <dbl> 10.2, 10.4, 10.4, 10.4, 10.4, 10.3, 10.2, 10.2, 10.1, 10.0, …
#> $ pacutp    <dbl> 0.09, 0.00, 0.19, 0.00, 0.00, 0.00, 0.03, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 10.6, 10.7, 10.8, 10.9, 11.0, 11.1, 11.1, 11.2, 11.2, 11.2, …
```
