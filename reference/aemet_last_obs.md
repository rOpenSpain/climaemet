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
#> $ fint      <dttm> 2026-07-08 01:00:00, 2026-07-08 02:00:00, 2026-07-08 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.9, 5.1, 5.0, 3.8, 3.6, 5.8, 7.6, 7.9, 5.8, 7.1, 6.7, 6.7, …
#> $ vv        <dbl> 2.0, 2.5, 3.4, 2.6, 3.0, 4.1, 5.8, 4.0, 3.5, 3.8, 3.8, 2.6, …
#> $ dv        <dbl> 248, 240, 314, 261, 268, 290, 287, 309, 306, 342, 322, 312, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 228, 225, 300, 313, 275, 285, 285, 293, 320, 328, 323, 303, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 987.8, 987.6, 988.0, 988.1, 988.4, 988.5, 988.8, 989.1, 989.…
#> $ hr        <dbl> 30, 30, 31, 43, 39, 37, 36, 37, 34, 29, 27, 22, 19, 46, 58, …
#> $ stdvv     <dbl> 1.2, 0.5, 0.4, 0.3, 0.1, 0.5, 0.7, 0.7, 0.6, 1.0, 0.7, 0.8, …
#> $ ts        <dbl> 28.3, 28.5, 28.4, 25.4, 25.7, 28.3, 29.4, 29.7, 33.3, 38.4, …
#> $ pres_nmar <dbl> 1016.2, 1016.0, 1016.4, 1016.8, 1017.1, 1017.0, 1017.3, 1017…
#> $ tamin     <dbl> 29.0, 28.8, 28.8, 25.9, 25.8, 26.2, 27.7, 28.3, 28.2, 29.2, …
#> $ ta        <dbl> 29.0, 29.1, 28.8, 25.9, 26.3, 27.7, 28.4, 28.4, 29.2, 31.6, …
#> $ tamax     <dbl> 30.4, 29.1, 29.4, 28.8, 26.3, 27.7, 28.4, 28.7, 29.4, 31.7, …
#> $ tpr       <dbl> 9.7, 9.8, 9.9, 12.3, 11.2, 11.7, 11.9, 12.3, 11.7, 11.4, 11.…
#> $ stddv     <dbl> 38, 19, 8, 10, 9, 10, 7, 10, 9, 17, 18, 19, 22, 21, 21, 20, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 20.4, 4.1, 0.0, 43.7, 60.0, 60.0, 6…
#> $ tss5cm    <dbl> 34.6, 34.0, 33.6, 33.1, 32.6, 32.2, 32.1, 32.2, 32.5, 33.6, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 34.8, 34.6, 34.4, 34.2, 34.0, 33.8, 33.5, 33.3, 33.1, 32.9, …
```
