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
#> Rows: 24
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-07-08 05:00:00, 2026-07-08 06:00:00, 2026-07-08 07:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 3.6, 5.8, 7.6, 7.9, 5.8, 7.1, 6.7, 6.7, 4.0, 3.5, 3.5, 4.6, …
#> $ vv        <dbl> 3.0, 4.1, 5.8, 4.0, 3.5, 3.8, 3.8, 2.6, 2.0, 1.6, 1.8, 2.1, …
#> $ dv        <dbl> 268, 290, 287, 309, 306, 342, 322, 312, 337, 109, 20, 26, 49…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 275, 285, 285, 293, 320, 328, 323, 303, 310, 343, 355, 13, 4…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 988.4, 988.5, 988.8, 989.1, 989.1, 988.8, 988.3, 987.3, 986.…
#> $ hr        <dbl> 39, 37, 36, 37, 34, 29, 27, 22, 19, 15, 12, 10, 54, 64, 49, …
#> $ stdvv     <dbl> 0.1, 0.5, 0.7, 0.7, 0.6, 1.0, 0.7, 0.8, 0.8, 0.5, 0.6, 0.6, …
#> $ ts        <dbl> 25.7, 28.3, 29.4, 29.7, 33.3, 38.4, 39.4, 42.2, 44.9, 45.0, …
#> $ pres_nmar <dbl> 1017.1, 1017.0, 1017.3, 1017.6, 1017.5, 1017.0, 1016.3, 1015…
#> $ tamin     <dbl> 25.8, 26.2, 27.7, 28.3, 28.2, 29.2, 31.4, 33.3, 35.8, 37.5, …
#> $ ta        <dbl> 26.3, 27.7, 28.4, 28.4, 29.2, 31.6, 33.3, 35.8, 37.5, 39.4, …
#> $ tamax     <dbl> 26.3, 27.7, 28.4, 28.7, 29.4, 31.7, 33.3, 35.8, 37.7, 39.4, …
#> $ tpr       <dbl> 11.2, 11.7, 11.9, 12.3, 11.7, 11.4, 11.8, 10.8, 9.9, 8.0, 5.…
#> $ stddv     <dbl> 9, 10, 7, 10, 9, 17, 18, 19, 22, 25, 49, 30, 22, 31, 20, 26,…
#> $ inso      <dbl> 0.0, 20.4, 4.1, 0.0, 43.7, 60.0, 60.0, 60.0, 60.0, 60.0, 60.…
#> $ tss5cm    <dbl> 32.6, 32.2, 32.1, 32.2, 32.5, 33.6, 35.0, 36.6, 38.5, 40.2, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 34.0, 33.8, 33.5, 33.3, 33.1, 32.9, 32.9, 32.9, 33.1, 33.4, …
```
