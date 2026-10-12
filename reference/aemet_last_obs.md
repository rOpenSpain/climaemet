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
#> $ fint      <dttm> 2026-10-12 06:00:00, 2026-10-12 07:00:00, 2026-10-12 08:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.3, 3.0, 2.8, 7.4, 8.0, 6.3, 5.8, 5.1, 6.4, 5.6, 5.3, 6.6, …
#> $ vv        <dbl> 0.8, 2.0, 1.2, 5.0, 4.2, 3.5, 2.9, 2.2, 3.4, 3.3, 3.6, 4.9, …
#> $ dv        <dbl> 321, 303, 292, 311, 306, 303, 312, 321, 323, 309, 321, 313, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 285, 305, 308, 325, 300, 300, 303, 318, 333, 303, 318, 328, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 987.7, 988.4, 988.9, 989.4, 989.0, 988.9, 988.8, 987.9, 988.…
#> $ hr        <dbl> 83, 81, 72, 61, 58, 53, 48, 42, 41, 42, 41, 43, 77, 81, 76, …
#> $ stdvv     <dbl> 0.3, 0.4, 0.4, 0.8, 0.7, 0.6, 0.7, 0.7, 0.8, 0.7, 0.7, 0.8, …
#> $ ts        <dbl> 14.2, 16.0, 21.0, 21.9, 24.9, 25.8, 29.5, 31.6, 31.4, 31.2, …
#> $ pres_nmar <dbl> 1017.5, 1018.2, 1018.4, 1018.7, 1018.1, 1017.9, 1017.6, 1016…
#> $ tamin     <dbl> 14.9, 14.5, 15.5, 17.9, 20.1, 21.6, 22.9, 24.5, 26.5, 26.9, …
#> $ ta        <dbl> 14.9, 15.5, 17.9, 20.1, 21.6, 22.9, 24.5, 26.5, 27.1, 27.3, …
#> $ tamax     <dbl> 15.2, 15.5, 17.9, 20.1, 21.6, 22.9, 24.5, 26.5, 27.1, 27.5, …
#> $ tpr       <dbl> 12.0, 12.2, 12.7, 12.3, 13.0, 12.8, 12.7, 12.5, 12.7, 13.3, …
#> $ stddv     <dbl> 108, 14, 13, 11, 13, 13, 11, 72, 34, 13, 39, 9, 17, 8, 20, 4…
#> $ inso      <dbl> 0.0, 19.3, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 6…
#> $ tss5cm    <dbl> 18.2, 17.9, 18.0, 18.7, 19.6, 21.0, 22.3, 23.8, 24.9, 25.4, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 20.3, 20.1, 20.0, 19.8, 19.8, 19.9, 20.0, 20.3, 20.7, 21.1, …
```
