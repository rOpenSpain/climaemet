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
#> Rows: 25
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-10-01 08:00:00, 2026-10-01 09:00:00, 2026-10-01 10:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 11.2, 12.8, 11.6, 11.3, 10.9, 11.2, 10.1, 10.5, 8.4, 9.7, 8.…
#> $ vv        <dbl> 8.7, 6.6, 8.6, 7.1, 8.7, 6.7, 5.9, 6.4, 6.0, 6.2, 6.1, 5.9, …
#> $ dv        <dbl> 306, 314, 309, 317, 307, 312, 319, 313, 315, 313, 306, 310, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 305, 308, 308, 318, 300, 300, 305, 315, 300, 305, 310, 308, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 994.1, 994.5, 994.8, 994.6, 994.2, 993.9, 993.4, 993.5, 993.…
#> $ hr        <dbl> 69, 64, 58, 53, 48, 47, 45, 45, 46, 49, 51, 54, 62, 60, 56, …
#> $ stdvv     <dbl> 1.3, 1.3, 1.0, 1.4, 1.0, 1.3, 1.1, 1.2, 0.9, 0.9, 0.7, 0.8, …
#> $ ts        <dbl> 19.7, 23.1, 23.7, 25.4, 25.7, 26.5, 26.9, 26.0, 24.9, 23.5, …
#> $ pres_nmar <dbl> 1023.7, 1023.9, 1024.1, 1023.8, 1023.3, 1022.9, 1022.4, 1022…
#> $ tamin     <dbl> 18.5, 19.1, 20.2, 21.4, 22.5, 23.3, 24.0, 24.4, 24.2, 23.3, …
#> $ ta        <dbl> 19.1, 20.4, 21.4, 22.5, 23.4, 24.1, 24.5, 24.6, 24.2, 23.3, …
#> $ tamax     <dbl> 19.1, 20.5, 21.4, 22.5, 23.4, 24.1, 24.8, 25.1, 24.7, 24.3, …
#> $ tpr       <dbl> 13.3, 13.4, 12.7, 12.4, 11.8, 12.1, 11.8, 11.9, 11.9, 12.0, …
#> $ stddv     <dbl> 7, 9, 7, 10, 6, 11, 13, 9, 8, 7, 7, 9, 23, 26, 30, 18, 42, 5…
#> $ inso      <dbl> 57.4, 60.0, 23.1, 60.0, 38.5, 29.3, 34.0, 33.5, 0.0, 0.0, 0.…
#> $ tss5cm    <dbl> 20.2, 20.4, 20.9, 21.7, 22.6, 23.3, 23.7, 24.1, 24.0, 23.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 23.0, 22.9, 22.7, 22.7, 22.8, 22.9, 23.1, 23.3, 23.5, 23.7, …
```
