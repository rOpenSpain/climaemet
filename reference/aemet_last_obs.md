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
#> ! HTTP status 500:
#>   API rate limit reached.
#> ℹ Retrying.
#> 
dplyr::glimpse(obs)
#> Rows: 24
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-10-21 04:00:00, 2026-10-21 05:00:00, 2026-10-21 06:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.9, 2.6, 3.4, 4.2, 5.4, 4.3, 9.7, 10.7, 9.6, 10.0, 11.5, 10…
#> $ vv        <dbl> 0.8, 1.4, 1.9, 3.3, 3.8, 2.1, 5.7, 6.3, 5.5, 6.9, 6.6, 5.5, …
#> $ dv        <dbl> 282, 329, 270, 299, 301, 301, 308, 304, 319, 318, 312, 314, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 233, 298, 280, 303, 308, 308, 305, 298, 310, 320, 313, 330, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 986.7, 987.3, 988.2, 989.2, 990.4, 991.5, 992.2, 992.7, 992.…
#> $ hr        <dbl> 81, 80, 82, 81, 71, 67, 55, 59, 56, 46, 44, 41, 70, 73, 74, …
#> $ stdvv     <dbl> 0.2, 0.3, 0.4, 0.3, 0.5, 0.4, 1.4, 1.0, 0.9, 1.2, 0.9, 1.2, …
#> $ ts        <dbl> 7.5, 8.3, 8.8, 8.6, 12.6, 15.8, 16.9, 17.4, 19.3, 22.4, 19.9…
#> $ pres_nmar <dbl> 1017.2, 1017.8, 1018.7, 1019.8, 1020.8, 1021.7, 1022.1, 1022…
#> $ tamin     <dbl> 9.0, 8.8, 8.8, 8.5, 8.7, 11.1, 13.2, 15.6, 16.0, 16.7, 18.0,…
#> $ ta        <dbl> 9.1, 9.0, 8.9, 8.7, 11.1, 13.2, 15.6, 16.1, 16.7, 18.4, 18.3…
#> $ tamax     <dbl> 9.4, 9.4, 9.0, 8.9, 11.1, 13.2, 15.6, 16.1, 16.9, 18.4, 18.7…
#> $ tpr       <dbl> 5.9, 5.8, 5.9, 5.6, 6.1, 7.1, 6.5, 8.1, 7.8, 6.5, 5.8, 5.0, …
#> $ stddv     <dbl> 21, 40, 12, 7, 6, 11, 12, 8, 13, 11, 9, 10, 25, 19, 12, 37, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 24.7, 54.2, 60.0, 23.8, 0.0, 20.9, 59.8, 54.9…
#> $ tss5cm    <dbl> 13.4, 13.1, 13.0, 12.9, 12.8, 13.1, 14.2, 14.8, 15.4, 16.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 16.4, 16.2, 16.1, 15.9, 15.8, 15.7, 15.6, 15.6, 15.7, 15.8, …
```
