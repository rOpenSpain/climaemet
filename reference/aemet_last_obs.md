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
#> $ fint      <dttm> 2026-11-20 11:00:00, 2026-11-20 12:00:00, 2026-11-20 13:00:…
#> $ prec      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
#> $ alt       <dbl> 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, 249, …
#> $ vmax      <dbl> 2.8, 4.4, 4.4, 4.0, 3.4, 2.9, 2.7, 6.2, 5.0, 1.7, 3.9, 1.9, …
#> $ vv        <dbl> 1.9, 2.2, 2.1, 1.6, 1.9, 1.5, 1.6, 2.3, 1.3, 0.3, 0.2, 0.8, …
#> $ dv        <dbl> 334, 343, 348, 340, 350, 338, 298, 243, 195, 218, 167, 76, 2…
#> $ lat       <dbl> 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, 41.66056, …
#> $ dmax      <dbl> 333, 325, 360, 350, 325, 355, 310, 240, 243, 273, 233, 90, 1…
#> $ ubi       <chr> "ZARAGOZA  AEROPUERTO", "ZARAGOZA  AEROPUERTO", "ZARAGOZA  A…
#> $ pres      <dbl> 992.2, 991.8, 991.2, 991.0, 990.8, 991.4, 991.6, 992.0, 992.…
#> $ hr        <dbl> 54, 50, 48, 46, 45, 50, 57, 69, 68, 74, 76, 79, 85, 81, 80, …
#> $ stdvv     <dbl> 0.4, 0.6, 0.6, 0.6, 0.5, 0.2, 0.3, 0.4, 0.2, 0.3, 0.2, 0.3, …
#> $ ts        <dbl> 16.9, 19.2, 19.8, 20.9, 20.2, 16.7, 14.2, 11.8, 11.1, 9.9, 9…
#> $ pres_nmar <dbl> 1022.2, 1021.6, 1020.9, 1020.6, 1020.4, 1021.1, 1021.5, 1022…
#> $ tamin     <dbl> 15.1, 15.4, 16.6, 17.4, 17.9, 17.2, 15.6, 13.1, 12.7, 11.8, …
#> $ ta        <dbl> 15.4, 16.6, 17.4, 18.0, 18.3, 17.2, 15.6, 13.1, 12.8, 11.8, …
#> $ tamax     <dbl> 15.4, 16.6, 17.4, 18.1, 18.3, 18.3, 17.2, 15.6, 13.1, 12.8, …
#> $ tpr       <dbl> 6.1, 6.1, 6.2, 6.2, 6.1, 6.7, 7.1, 7.6, 7.0, 7.3, 7.0, 7.1, …
#> $ stddv     <dbl> 19, 18, 21, 24, 19, 12, 17, 9, 11, 74, 91, 33, 35, 28, 25, 3…
#> $ inso      <dbl> 1.0, 29.5, 60.0, 60.0, 60.0, 50.0, 0.0, 0.0, 0.0, 0.0, 0.0, …
#> $ tss5cm    <dbl> 14.2, 14.7, 15.5, 16.3, 16.5, 16.5, 16.0, 15.3, 14.7, 14.2, …
#> $ pacutp    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, NA, NA, NA, …
#> $ tss20cm   <dbl> 14.5, 14.5, 14.6, 14.7, 14.9, 15.1, 15.3, 15.4, 15.5, 15.4, …
```
