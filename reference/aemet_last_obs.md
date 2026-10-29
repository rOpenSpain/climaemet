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
#> $ fint      <dttm> 2026-10-28 23:00:00, 2026-10-29 00:00:00, 2026-10-29 01:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 4.3, 2.5, 5.2, 2.9, 1.5, 2.1, 1.4, 1.5, 2.9, 2.2, 3.4, 5.3, …
#> $ vv        <dbl> 1.2, 1.8, 1.2, 1.0, 0.8, 0.5, 0.7, 0.4, 0.4, 1.5, 1.1, 2.5, …
#> $ dv        <dbl> 289, 296, 257, 345, 3, 31, 83, 75, 8, 316, 329, 299, 45, 44,…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 313, 298, 215, 260, 345, 3, 358, 35, 250, 325, 315, 295, 36,…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 993.1, 992.9, 992.8, 992.8, 992.7, 992.7, 993.0, 993.2, 993.…
#> $ hr        <dbl> 70, 75, 77, 78, 84, 87, 90, 91, 91, 82, 77, 65, 62, 56, 63, …
#> $ stdvv     <dbl> 0.2, 0.2, 0.5, 0.2, 0.3, 0.2, 0.3, 0.3, 0.1, 0.3, 0.4, 0.4, …
#> $ ts        <dbl> 11.8, 11.0, 10.6, 9.7, 8.2, 8.1, 7.7, 7.4, 7.9, 12.6, 16.8, …
#> $ pres_nmar <dbl> 1023.3, 1023.3, 1023.2, 1023.2, 1023.3, 1023.3, 1023.7, 1023…
#> $ tamin     <dbl> 13.0, 11.8, 11.4, 11.1, 9.9, 9.3, 8.7, 8.5, 8.4, 8.8, 10.4, …
#> $ ta        <dbl> 13.0, 11.8, 11.4, 11.1, 9.9, 9.3, 8.7, 8.5, 8.8, 10.4, 12.8,…
#> $ tamax     <dbl> 14.1, 13.0, 11.9, 11.8, 11.1, 9.9, 9.3, 8.7, 8.8, 10.4, 12.8…
#> $ tpr       <dbl> 7.7, 7.6, 7.6, 7.4, 7.3, 7.3, 7.1, 7.1, 7.4, 7.4, 8.9, 8.8, …
#> $ stddv     <dbl> 8, 9, 16, 16, 22, 27, 20, 53, 23, 13, 44, 12, 17, 22, 24, 12…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 17.2, 56.7, 60.0, 60…
#> $ tss5cm    <dbl> 17.3, 16.8, 16.5, 16.1, 15.7, 15.3, 15.0, 14.7, 14.4, 14.3, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 18.9, 18.8, 18.6, 18.4, 18.3, 18.1, 17.9, 17.7, 17.5, 17.3, …
```
