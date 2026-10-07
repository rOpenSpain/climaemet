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
#> Rows: 23
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-10-07 06:00:00, 2026-10-07 07:00:00, 2026-10-07 08:00:…
#> $ prec      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.3, 2.0, 1.7, 4.1, 6.2, 10.2, 9.1, 6.8, 13.3, 8.0, 5.7, 4.6…
#> $ vv        <dbl> 1.6, 0.7, 0.7, 2.5, 4.3, 6.1, 4.2, 4.0, 8.6, 4.1, 3.6, 2.2, …
#> $ dv        <dbl> 76, 73, 236, 326, 306, 323, 320, 331, 299, 275, 261, 253, 24…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 63, 75, 85, 323, 303, 308, 310, 308, 300, 293, 278, 268, 220…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 983.2, 983.5, 984.0, 984.7, 984.9, 984.8, 984.2, 983.9, 984.…
#> $ hr        <dbl> 98, 98, 94, 93, 76, 69, 60, 57, 62, 84, 64, 67, 97, 96, 93, …
#> $ stdvv     <dbl> 0.5, 0.2, 0.2, 0.5, 0.7, 1.2, 0.8, 0.9, 1.8, 0.5, 0.8, 0.2, …
#> $ ts        <dbl> 15.5, 16.1, 17.3, 18.2, 22.0, 23.3, 22.2, 24.7, 21.5, 18.5, …
#> $ pres_nmar <dbl> 1012.8, 1013.0, 1013.4, 1014.1, 1014.1, 1013.9, 1013.2, 1012…
#> $ tamin     <dbl> 15.6, 15.7, 16.1, 17.0, 17.7, 19.9, 20.6, 21.0, 20.6, 18.6, …
#> $ ta        <dbl> 15.7, 16.1, 17.0, 17.7, 19.9, 20.6, 21.4, 22.1, 20.6, 18.6, …
#> $ tamax     <dbl> 15.7, 16.1, 17.0, 17.8, 19.9, 20.8, 21.4, 22.1, 22.4, 20.6, …
#> $ tpr       <dbl> 15.3, 15.8, 16.0, 16.6, 15.5, 14.7, 13.4, 13.2, 13.1, 15.9, …
#> $ stddv     <dbl> 22, 23, 28, 39, 9, 51, 21, 100, 8, 8, 12, 7, 19, 20, 49, 90,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 40.6, 59.4, 34.1, 24.6, 25.0, 0.0, 60.0,…
#> $ tss5cm    <dbl> 19.4, 19.3, 19.5, 19.8, 20.4, 21.5, 22.2, 21.9, 22.4, 21.8, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.06, 0.00, 0.00, 0.00, 0.00, 0.00, 0.38, …
#> $ tss20cm   <dbl> 22.5, 22.3, 22.1, 21.9, 21.8, 21.8, 21.9, 22.0, 22.2, 22.3, …
```
