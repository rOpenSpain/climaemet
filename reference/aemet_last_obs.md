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
#> $ fint      <dttm> 2026-08-28 01:00:00, 2026-08-28 02:00:00, 2026-08-28 03:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 10.2, 8.2, 4.8, 7.7, 4.6, 4.7, 4.7, 7.6, 6.2, 12.8, 12.0, 11…
#> $ vv        <dbl> 5.9, 2.8, 2.6, 3.1, 2.3, 2.8, 3.0, 3.0, 1.7, 8.1, 7.0, 6.9, …
#> $ dv        <dbl> 261, 263, 337, 311, 254, 266, 297, 306, 272, 269, 258, 260, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 273, 263, 235, 233, 280, 290, 280, 283, 255, 275, 260, 265, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 987.4, 987.4, 988.6, 988.7, 989.0, 989.6, 990.3, 990.8, 990.…
#> $ hr        <dbl> 42, 44, 45, 46, 49, 53, 47, 44, 39, 30, 29, 27, 67, 74, 77, …
#> $ stdvv     <dbl> 0.8, 0.4, 0.7, 0.4, 0.6, 0.6, 0.6, 0.7, 1.2, 1.4, 1.7, 1.3, …
#> $ ts        <dbl> 21.4, 19.9, 19.7, 19.5, 18.1, 17.5, 21.8, 24.4, 27.6, 28.2, …
#> $ pres_nmar <dbl> 1016.5, 1016.7, 1017.9, 1018.1, 1018.5, 1019.2, 1019.7, 1020…
#> $ tamin     <dbl> 21.6, 20.3, 19.7, 19.8, 18.6, 17.0, 17.7, 19.7, 20.6, 22.2, …
#> $ ta        <dbl> 21.6, 20.3, 20.1, 19.8, 18.6, 17.7, 19.7, 20.6, 22.2, 24.3, …
#> $ tamax     <dbl> 23.1, 21.6, 20.3, 20.2, 19.8, 18.6, 19.7, 20.6, 22.2, 24.5, …
#> $ tpr       <dbl> 8.1, 7.7, 7.8, 7.8, 7.7, 8.0, 8.1, 8.0, 7.6, 5.6, 5.9, 5.8, …
#> $ stddv     <dbl> 8, 11, 31, 11, 12, 12, 12, 13, 50, 10, 15, 15, 20, 21, 37, 2…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 4.4, 53.9, 60.0, 60.0, 60.0, 60.0, …
#> $ tss5cm    <dbl> 29.8, 29.3, 28.7, 28.2, 27.8, 27.3, 26.9, 27.1, 27.8, 29.1, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 31.9, 31.8, 31.6, 31.4, 31.2, 31.0, 30.7, 30.5, 30.3, 30.1, …
```
