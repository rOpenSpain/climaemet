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
#> ! HTTP status 503:
#>   API rate limit reached.
#> ℹ Retrying.
#> 
dplyr::glimpse(obs)
#> Rows: 24
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-10-01 21:00:00, 2026-10-01 22:00:00, 2026-10-01 23:00:…
#> $ prec      <dbl> 0.2, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 10.9, 9.7, 6.9, 5.8, 6.2, 5.6, 5.8, 5.4, 4.1, 4.0, 4.1, 3.9,…
#> $ vv        <dbl> 7.1, 5.1, 3.8, 4.4, 3.6, 3.7, 3.8, 2.7, 2.7, 2.5, 2.8, 1.7, …
#> $ dv        <dbl> 306, 303, 295, 280, 298, 296, 293, 295, 289, 287, 288, 282, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 288, 310, 308, 285, 308, 305, 288, 288, 290, 283, 288, 285, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 996.7, 996.5, 996.5, 996.6, 996.7, 996.2, 996.2, 996.3, 996.…
#> $ hr        <dbl> 76, 82, 83, 79, 76, 77, 76, 75, 74, 81, 80, 80, 65, 66, 74, …
#> $ stdvv     <dbl> 1.0, 0.9, 0.5, 0.4, 0.5, 0.4, 0.4, 0.3, 0.3, 0.2, 0.2, 0.3, …
#> $ ts        <dbl> 18.2, 17.0, 16.9, 17.2, 17.4, 17.2, 17.4, 17.5, 17.5, 17.1, …
#> $ pres_nmar <dbl> 1026.4, 1026.3, 1026.3, 1026.4, 1026.5, 1026.0, 1026.0, 1026…
#> $ tamin     <dbl> 18.6, 17.3, 16.8, 17.1, 17.4, 17.3, 17.2, 17.3, 17.5, 17.0, …
#> $ ta        <dbl> 18.6, 17.3, 17.1, 17.4, 17.6, 17.3, 17.3, 17.5, 17.5, 17.0, …
#> $ tamax     <dbl> 20.4, 18.6, 17.3, 17.4, 17.6, 17.6, 17.4, 17.5, 17.6, 17.5, …
#> $ tpr       <dbl> 14.2, 14.2, 14.1, 13.8, 13.4, 13.3, 13.1, 13.1, 12.8, 13.8, …
#> $ stddv     <dbl> 8, 10, 8, 7, 8, 7, 7, 7, 6, 6, 6, 14, 21, 23, 25, 14, 22, 24…
#> $ inso      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss5cm    <dbl> 22.1, 21.7, 21.2, 20.9, 20.6, 20.4, 20.2, 20.1, 20.0, 19.9, …
#> $ pacutp    <dbl> 0.29, 0.81, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 23.8, 23.7, 23.6, 23.4, 23.3, 23.1, 22.9, 22.8, 22.6, 22.5, …
```
