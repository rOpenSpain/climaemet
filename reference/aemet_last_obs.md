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
#> ! HTTP status 429:
#>   Se ha alcanzado uno de los límites globales de uso. Vuelva a intentarlo el
#>   próximo minuto.
#> ℹ Retrying.
#> Waiting 3s for retry backoff ■■■■■■■■■■■                     
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■   
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> 
dplyr::glimpse(obs)
#> Rows: 24
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-07-18 03:00:00, 2026-07-18 04:00:00, 2026-07-18 05:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 10.3, 8.8, 7.5, 7.7, 8.3, 9.0, 7.5, 5.1, 5.4, 3.9, 3.5, 4.1,…
#> $ vv        <dbl> 6.3, 5.4, 4.7, 4.5, 5.5, 6.0, 3.4, 2.7, 2.3, 1.6, 1.7, 1.7, …
#> $ dv        <dbl> 298, 301, 310, 302, 314, 319, 319, 312, 315, 258, 124, 86, 1…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 288, 300, 313, 305, 315, 310, 295, 273, 220, 330, 115, 110, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 986.2, 986.2, 986.6, 986.9, 987.0, 987.1, 986.7, 986.2, 985.…
#> $ hr        <dbl> 62, 63, 65, 64, 60, 58, 54, 47, 42, 37, 34, 31, 39, 36, 32, …
#> $ stdvv     <dbl> 1.3, 0.8, 0.6, 0.7, 1.0, 1.0, 1.0, 1.1, 0.6, 0.7, 0.6, 0.7, …
#> $ ts        <dbl> 23.3, 22.9, 22.3, 23.3, 25.7, 27.6, 31.1, 34.0, 36.5, 38.5, …
#> $ pres_nmar <dbl> 1015.1, 1015.1, 1015.6, 1015.9, 1015.9, 1015.9, 1015.3, 1014…
#> $ tamin     <dbl> 23.0, 22.7, 22.0, 22.0, 22.3, 23.3, 24.1, 25.6, 27.6, 29.6, …
#> $ ta        <dbl> 23.0, 22.7, 22.1, 22.3, 23.3, 24.1, 25.6, 27.7, 29.8, 31.5, …
#> $ tamax     <dbl> 23.2, 23.0, 22.7, 22.3, 23.3, 24.2, 25.6, 27.8, 30.1, 31.5, …
#> $ tpr       <dbl> 15.3, 15.3, 15.2, 15.2, 15.1, 15.3, 15.6, 15.3, 15.5, 15.1, …
#> $ stddv     <dbl> 8, 8, 9, 8, 12, 11, 16, 24, 28, 49, 36, 27, 15, 20, 16, 28, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 35.7, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.…
#> $ tss5cm    <dbl> 33.3, 32.7, 32.3, 31.8, 31.6, 31.7, 32.3, 33.5, 35.2, 37.1, …
#> $ pacutp    <dbl> 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, …
#> $ tss20cm   <dbl> 35.5, 35.2, 35.0, 34.7, 34.4, 34.2, 33.9, 33.8, 33.7, 33.7, …
```
