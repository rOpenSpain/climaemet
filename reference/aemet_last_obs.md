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
#> $ fint      <dttm> 2026-09-02 03:00:00, 2026-09-02 04:00:00, 2026-09-02 05:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 6.3, 5.7, 6.5, 6.6, 8.2, 7.6, 7.3, 5.5, 4.7, 3.4, 3.7, 3.9, …
#> $ vv        <dbl> 4.0, 3.9, 5.2, 3.9, 5.8, 5.0, 3.3, 3.3, 1.8, 1.8, 2.1, 2.0, …
#> $ dv        <dbl> 296, 285, 298, 302, 301, 307, 304, 293, 295, 25, 111, 41, 13…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 300, 300, 288, 295, 293, 300, 313, 293, 268, 20, 100, 65, 90…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 990.9, 991.1, 991.3, 991.9, 992.5, 992.8, 993.0, 993.0, 992.…
#> $ hr        <dbl> 65, 67, 69, 70, 69, 63, 60, 53, 50, 46, 41, 35, 29, 36, 40, …
#> $ stdvv     <dbl> 0.5, 0.4, 0.5, 0.7, 0.6, 0.6, 0.7, 0.6, 0.8, 0.6, 0.4, 0.7, …
#> $ ts        <dbl> 22.4, 21.7, 21.5, 21.3, 23.0, 25.9, 28.9, 31.8, 35.1, 36.9, …
#> $ pres_nmar <dbl> 1020.0, 1020.3, 1020.5, 1021.2, 1021.8, 1021.9, 1022.0, 1021…
#> $ tamin     <dbl> 22.3, 21.8, 21.4, 21.0, 20.9, 21.3, 22.6, 24.2, 26.4, 28.1, …
#> $ ta        <dbl> 22.3, 21.8, 21.4, 21.0, 21.3, 22.6, 24.2, 26.4, 28.2, 30.1, …
#> $ tamax     <dbl> 22.7, 22.4, 21.8, 21.4, 21.3, 22.6, 24.2, 26.5, 28.2, 30.3, …
#> $ tpr       <dbl> 15.4, 15.4, 15.4, 15.3, 15.3, 15.2, 16.0, 16.0, 16.8, 17.2, …
#> $ stddv     <dbl> 7, 6, 6, 7, 8, 10, 12, 14, 54, 42, 16, 49, 94, 17, 16, 22, 2…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 8.6, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0…
#> $ tss5cm    <dbl> 30.3, 29.8, 29.4, 29.0, 28.7, 28.8, 29.3, 30.4, 31.9, 33.8, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 32.3, 32.1, 31.9, 31.7, 31.5, 31.3, 31.1, 31.0, 30.9, 30.9, …
```
