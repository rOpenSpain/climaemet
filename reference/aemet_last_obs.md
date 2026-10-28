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
#> Rows: 26
#> Columns: 25
#> $ idema     <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "943…
#> $ lon       <dbl> -1.004167, -1.004167, -1.004167, -1.004167, -1.004167, -1.00…
#> $ fint      <dttm> 2026-10-28 05:00:00, 2026-10-28 06:00:00, 2026-10-28 07:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 9.2, 8.8, 7.2, 6.5, 11.4, 10.9, 10.3, 7.8, 7.0, 7.3, 5.7, 5.…
#> $ vv        <dbl> 6.9, 5.6, 4.8, 4.5, 7.5, 8.1, 6.4, 4.6, 5.1, 4.2, 3.4, 4.0, …
#> $ dv        <dbl> 296, 297, 295, 301, 309, 309, 311, 299, 309, 306, 299, 309, …
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 293, 303, 288, 295, 308, 308, 298, 310, 305, 305, 283, 320, …
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 994.2, 994.7, 995.0, 995.6, NA, NA, 995.2, 994.6, 993.8, 993…
#> $ hr        <dbl> 78, 80, 81, 74, 67, 60, 56, 51, 48, 43, 44, 43, 46, 70, 72, …
#> $ stdvv     <dbl> 0.7, 0.6, 0.5, 0.7, 1.3, 1.2, 0.8, 0.9, 1.0, 0.7, 0.9, 0.4, …
#> $ ts        <dbl> 13.4, 13.2, 12.8, 15.7, 17.9, 20.0, 22.1, 24.5, 25.2, 25.9, …
#> $ pres_nmar <dbl> 1024.3, 1024.9, 1025.2, 1025.7, NA, NA, 1024.8, 1024.1, 1023…
#> $ tamin     <dbl> 13.9, 13.7, 13.3, 13.3, 15.1, 16.6, 17.9, 19.0, 20.3, 21.1, …
#> $ ta        <dbl> 13.9, 13.7, 13.3, 15.1, 16.6, 17.9, 19.1, 20.3, 21.1, 22.0, …
#> $ tamax     <dbl> 14.4, 14.0, 13.7, 15.1, 16.6, 17.9, 19.1, 20.3, 21.1, 22.0, …
#> $ tpr       <dbl> 10.2, 10.3, 10.0, 10.5, NA, NA, 10.2, 9.8, 9.7, 8.8, 9.7, 9.…
#> $ stddv     <dbl> 6, 6, 6, 7, 8, 8, 12, 10, 10, 13, 14, 8, 5, 22, 25, 17, 21, …
#> $ inso      <dbl> 0.0, 0.0, 14.6, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60…
#> $ tss5cm    <dbl> 16.6, 16.4, 16.2, 16.1, 16.2, 16.8, 17.7, 18.8, 19.9, 20.7, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, N…
#> $ tss20cm   <dbl> 18.3, 18.2, 18.1, 17.9, 17.8, 17.7, 17.7, 17.8, 17.9, 18.1, …
```
