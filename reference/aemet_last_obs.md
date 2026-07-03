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
#> $ fint      <dttm> 2026-07-03 04:00:00, 2026-07-03 05:00:00, 2026-07-03 06:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 12.2, 11.7, 11.8, 13.4, 13.9, 13.0, 11.5, 10.5, 11.6, 14.7, …
#> $ vv        <dbl> 7.9, 7.8, 7.6, 9.6, 9.6, 9.2, 6.6, 6.8, 6.7, 8.1, 8.6, 9.6, …
#> $ dv        <dbl> 312, 308, 310, 311, 316, 306, 314, 304, 317, 311, 311, 315, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 305, 313, 328, 315, 320, 308, 310, 293, 303, 298, 305, 303, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 994.6, 994.6, 994.9, 995.3, 995.4, 995.2, 994.9, 994.4, 993.…
#> $ hr        <dbl> 65, 66, 64, 61, 56, 50, 46, 40, 37, 32, 30, 30, 32, 40, 41, …
#> $ stdvv     <dbl> 1.3, 1.5, 1.1, 1.4, 1.3, 1.4, 1.6, 1.0, 1.4, 1.5, 1.6, 1.5, …
#> $ ts        <dbl> 19.6, 19.4, 20.8, 22.8, 25.3, 28.5, 31.2, 33.8, 36.5, 38.0, …
#> $ pres_nmar <dbl> 1024.1, 1024.1, 1024.4, 1024.6, 1024.6, 1024.2, 1023.8, 1023…
#> $ tamin     <dbl> 19.7, 19.4, 19.6, 20.2, 21.5, 22.8, 24.5, 26.2, 28.2, 30.1, …
#> $ ta        <dbl> 19.7, 19.6, 20.2, 21.5, 22.8, 24.7, 26.2, 28.3, 30.2, 31.8, …
#> $ tamax     <dbl> 20.1, 19.7, 20.2, 21.5, 22.8, 24.8, 26.2, 28.3, 30.2, 32.0, …
#> $ tpr       <dbl> 13.0, 13.1, 13.2, 13.7, 13.6, 13.6, 13.7, 13.5, 13.9, 13.1, …
#> $ stddv     <dbl> 8, 6, 8, 7, 8, 8, 12, 14, 14, 13, 9, 10, 7, 17, 16, 17, 18, …
#> $ inso      <dbl> 0, 13, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, NA, NA, N…
#> $ tss5cm    <dbl> 25.9, 25.5, 25.2, 25.2, 25.6, 26.5, 27.8, 29.6, 31.5, 33.3, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 28.9, 28.6, 28.4, 28.2, 28.0, 27.8, 27.7, 27.7, 27.8, 28.1, …
```
