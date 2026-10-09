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
#> $ fint      <dttm> 2026-10-09 04:00:00, 2026-10-09 05:00:00, 2026-10-09 06:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 10.3, 9.6, 10.3, 12.4, 12.6, 14.3, 13.5, 14.7, 12.3, 11.7, 1…
#> $ vv        <dbl> 7.0, 6.3, 7.5, 8.4, 8.1, 8.8, 8.3, 8.0, 7.9, 7.2, 7.3, 8.0, …
#> $ dv        <dbl> 305, 303, 299, 300, 305, 311, 322, 320, 319, 313, 323, 315, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 318, 300, 325, 310, 290, 318, 323, 318, 315, 333, 318, 308, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 994.1, 994.0, 994.0, 993.9, 994.1, 994.4, 993.9, 993.7, 993.…
#> $ hr        <dbl> 66, 68, 72, 70, 62, 53, 48, 45, 41, 37, 36, 31, 69, 73, 74, …
#> $ stdvv     <dbl> 1.1, 0.8, 0.8, 1.1, 1.5, 1.7, 1.5, 1.6, 1.5, 1.6, 1.3, 1.5, …
#> $ ts        <dbl> 11.6, 11.4, 10.9, 12.1, 14.3, 15.9, 18.3, 19.9, 21.2, 22.4, …
#> $ pres_nmar <dbl> 1024.5, 1024.4, 1024.4, 1024.3, 1024.3, 1024.4, 1023.8, 1023…
#> $ tamin     <dbl> 12.0, 11.9, 11.4, 11.4, 12.0, 13.6, 15.3, 16.5, 17.7, 18.7, …
#> $ ta        <dbl> 12.1, 11.9, 11.4, 12.0, 13.7, 15.3, 16.6, 17.7, 18.7, 19.9, …
#> $ tamax     <dbl> 12.2, 12.1, 11.9, 12.0, 13.7, 15.3, 16.6, 17.7, 18.8, 19.9, …
#> $ tpr       <dbl> 5.9, 6.2, 6.5, 6.7, 6.5, 5.8, 5.5, 5.6, 5.1, 4.8, 4.8, 3.0, …
#> $ stddv     <dbl> 8, 8, 6, 7, 11, 11, 11, 22, 11, 14, 25, 10, 27, 17, 23, 18, …
#> $ inso      <dbl> 0.0, 0.0, 0.0, 43.1, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.…
#> $ tss5cm    <dbl> 13.9, 13.7, 13.5, 13.4, 13.5, 13.9, 14.7, 15.8, 16.9, 18.0, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 17.8, 17.6, 17.5, 17.3, 17.1, 17.0, 16.9, 16.9, 17.0, 17.2, …
```
