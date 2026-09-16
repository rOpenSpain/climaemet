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
  [tibble](https://tibble.tidyverse.org/reference/tibble.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  A logical value. If `TRUE`, displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  unless `verbose = TRUE`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object.

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
#> $ fint      <dttm> 2026-09-16 03:00:00, 2026-09-16 04:00:00, 2026-09-16 05:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 14.8, 13.2, 15.5, 12.6, 12.4, 13.5, 15.4, 16.5, 17.4, 16.7, …
#> $ vv        <dbl> 9.5, 9.3, 8.9, 9.0, 9.1, 9.9, 9.8, 9.7, 12.3, 9.1, 8.8, 8.2,…
#> $ dv        <dbl> 307, 307, 309, 308, 308, 309, 316, 316, 312, 316, 318, 318, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 310, 308, 305, 320, 305, 303, 313, 323, 313, 310, 315, 318, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 989.8, 989.5, 989.5, 989.7, 990.0, 990.0, 990.5, 990.5, 990.…
#> $ hr        <dbl> 62, 64, 67, 67, 65, 60, 52, 50, 47, 48, 48, 49, 38, 37, 43, …
#> $ stdvv     <dbl> 1.3, 1.2, 1.3, 1.6, 1.4, 1.3, 1.8, 2.1, 2.2, 1.8, 1.5, 1.8, …
#> $ ts        <dbl> 20.3, 20.1, 19.9, 20.0, 21.3, 21.9, 24.4, 24.5, 25.2, 24.2, …
#> $ pres_nmar <dbl> 1019.1, 1018.8, 1018.8, 1019.0, 1019.3, 1019.2, 1019.6, 1019…
#> $ tamin     <dbl> 20.2, 20.1, 19.8, 19.9, 19.9, 20.4, 21.1, 21.7, 21.8, 21.7, …
#> $ ta        <dbl> 20.3, 20.1, 19.9, 20.0, 20.4, 21.1, 22.2, 21.8, 22.2, 21.9, …
#> $ tamax     <dbl> 20.6, 20.3, 20.1, 20.0, 20.4, 21.1, 22.2, 22.6, 22.7, 22.2, …
#> $ tpr       <dbl> 12.7, 13.1, 13.6, 13.7, 13.6, 13.1, 11.9, 10.9, 10.3, 10.4, …
#> $ stddv     <dbl> 8, 7, 7, 7, 8, 8, 10, 9, 8, 10, 11, 12, 10, 24, 19, 18, 18, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 57.4, 59.5, 60.0, 60.0, 52.1, 7.6, 3.6, …
#> $ tss5cm    <dbl> 28.4, 27.9, 27.6, 27.2, 27.0, 26.9, 27.1, 27.7, 28.4, 28.8, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 30.6, 30.4, 30.2, 30.0, 29.8, 29.6, 29.4, 29.3, 29.2, 29.1, …
```
