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
#> $ fint      <dttm> 2026-11-10 18:00:00, 2026-11-10 19:00:00, 2026-11-10 20:00:…
#> $ prec      <dbl> 0.2, 0.0, 0.4, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.9, 5.6, 2.5, 4.5, 4.4, 3.2, 3.5, 3.4, 3.8, 3.4, 3.1, 3.6, …
#> $ vv        <dbl> 3.5, 1.2, 1.6, 3.3, 1.7, 1.9, 2.1, 1.7, 2.6, 2.0, 1.6, 2.0, …
#> $ dv        <dbl> 142, 20, 164, 111, 115, 136, 136, 113, 102, 108, 221, 212, 1…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 115, 275, 188, 105, 133, 138, 140, 125, 115, 113, 270, 275, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 980.3, 980.3, 979.9, 980.2, 980.4, 979.8, 979.5, 978.9, 978.…
#> $ hr        <dbl> 89, 94, 96, 94, 94, 96, 95, 94, 96, 96, 96, 95, 93, 95, 96, …
#> $ stdvv     <dbl> 0.6, 0.7, 0.3, 0.4, 0.3, 0.6, 0.4, 0.3, 0.5, 0.3, 0.6, 0.6, …
#> $ ts        <dbl> 16.7, 15.8, 15.4, 14.7, 14.6, 14.5, 14.7, 14.6, 14.4, 14.5, …
#> $ pres_nmar <dbl> 1009.6, 1009.7, 1009.3, 1009.7, 1010.0, 1009.4, 1009.0, 1008…
#> $ tamin     <dbl> 16.8, 16.4, 15.9, 15.2, 15.0, 14.7, 14.8, 15.0, 14.8, 14.8, …
#> $ ta        <dbl> 17.1, 16.4, 15.9, 15.2, 15.0, 14.8, 15.0, 15.0, 14.8, 14.8, …
#> $ tamax     <dbl> 17.1, 17.1, 16.4, 15.9, 15.2, 15.0, 15.0, 15.2, 15.0, 14.9, …
#> $ tpr       <dbl> 15.3, 15.4, 15.3, 14.2, 14.0, 14.1, 14.2, 14.0, 14.1, 14.1, …
#> $ stddv     <dbl> 11, 65, 21, 8, 12, 17, 10, 11, 12, 10, 51, 11, 10, 24, 24, 2…
#> $ inso      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss5cm    <dbl> 15.9, 15.8, 15.7, 15.6, 15.4, 15.3, 15.2, 15.2, 15.1, 15.0, …
#> $ pacutp    <dbl> 0.23, 0.10, 0.19, 0.00, 0.17, 0.11, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 15.6, 15.6, 15.7, 15.7, 15.8, 15.7, 15.7, 15.7, 15.7, 15.7, …
```
