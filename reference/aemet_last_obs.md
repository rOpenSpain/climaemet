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
#> Rows: 23
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-10-27 22:00:00, 2026-10-27 23:00:00, 2026-10-28 00:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 667, …
#> $ vmax      <dbl> 12.2, 11.7, 11.4, 10.5, 11.5, 10.1, 8.5, 9.2, 8.8, 7.2, 6.5,…
#> $ vv        <dbl> 7.3, 6.6, 7.2, 7.5, 7.7, 6.2, 6.7, 6.9, 5.6, 4.8, 4.5, 2.8, …
#> $ dv        <dbl> 297, 302, 302, 302, 307, 310, 300, 296, 297, 295, 301, 37, 5…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 290, 310, 308, 303, 305, 318, 293, 293, 303, 288, 295, 60, 5…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 992.9, 993.4, 993.5, 993.6, 993.5, 993.5, 993.8, 994.2, 994.…
#> $ hr        <dbl> 67, 69, 69, 71, 70, 72, 76, 78, 80, 81, 74, 56, 57, 59, 64, …
#> $ stdvv     <dbl> 1.0, 0.9, 1.0, 0.8, 0.9, 0.8, 0.6, 0.7, 0.6, 0.5, 0.7, 0.9, …
#> $ ts        <dbl> 16.6, 16.2, 16.0, 15.4, 15.2, 14.7, 13.9, 13.4, 13.2, 12.8, …
#> $ pres_nmar <dbl> 1022.7, 1023.2, 1023.3, 1023.5, 1023.4, 1023.5, 1023.9, 1024…
#> $ tamin     <dbl> 17.0, 16.7, 16.5, 15.9, 15.6, 15.1, 14.4, 13.9, 13.7, 13.3, …
#> $ ta        <dbl> 17.0, 16.7, 16.5, 15.9, 15.6, 15.1, 14.4, 13.9, 13.7, 13.3, …
#> $ tamax     <dbl> 17.3, 17.0, 16.7, 16.6, 15.9, 15.6, 15.1, 14.4, 14.0, 13.7, …
#> $ tpr       <dbl> 10.9, 11.0, 10.8, 10.6, 10.2, 10.0, 10.2, 10.2, 10.3, 10.0, …
#> $ stddv     <dbl> 8, 8, 8, 5, 6, 7, 5, 6, 6, 6, 7, 20, 23, 18, 65, 18, 17, 20,…
#> $ inso      <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 14.6, 60.0, NA,…
#> $ tss5cm    <dbl> 18.3, 18.0, 17.8, 17.6, 17.3, 17.1, 16.9, 16.6, 16.4, 16.2, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, NA,…
#> $ tss20cm   <dbl> 18.9, 18.8, 18.7, 18.7, 18.6, 18.5, 18.4, 18.3, 18.2, 18.1, …
```
