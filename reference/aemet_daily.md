# Daily and annual climatology values

Retrieves climatology values for one station or all available stations.
`aemet_daily_period()` and `aemet_daily_period_all()` are shortcuts for
`aemet_daily_clim()`.

## Usage

``` r
aemet_daily_clim(
  station = "all",
  start = Sys.Date() - 7,
  end = Sys.Date(),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)

aemet_daily_period(
  station,
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)

aemet_daily_period_all(
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
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

- start, end:

  Character strings containing the start and end dates. See **Details**.

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

## Details

For `aemet_daily_clim()`, `start` and `end` must be `Date` objects or
strings in `YYYY-MM-DD` format, such as `"2020-12-31"`, that can be
coerced with [`as.Date()`](https://rdrr.io/r/base/as.Date.html). For
`aemet_daily_period()` and `aemet_daily_period_all()`, they must be
strings representing the years to extract, such as `"2018"` and
`"2020"`.

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

Climatology:
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_monthly_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)

## Examples

``` r

library(dplyr)
obs <- aemet_daily_clim(c("9434", "3195"))
#> ! HTTP status 500:
#>   API rate limit reached.
#> ℹ Retrying.
#> 
glimpse(obs)
#> Rows: 8
#> Columns: 26
#> $ fecha       <date> 2026-10-21, 2026-10-22, 2026-10-23, 2026-10-24, 2026-10-2…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 13.6, 13.6, 15.2, 13.5, 13.6, 13.8, 14.6, 12.6
#> $ prec        <dbl> 0, 0, 0, 0, 0, 0, 0, 0
#> $ tmin        <dbl> 8.5, 7.5, 10.4, 7.9, 8.5, 8.6, 10.1, 7.4
#> $ horatmin    <time> 06:30:00, 03:30:00, 06:50:00, 06:50:00, 06:50:00, 06:50:00…
#> $ tmax        <dbl> 18.7, 19.7, 20.0, 19.1, 18.6, 18.9, 19.2, 17.9
#> $ horatmax    <time> 13:40:00, 14:50:00, 14:00:00, 14:20:00, 13:10:00, 13:10:00…
#> $ dir         <dbl> 31, 12, 30, 30, 32, 99, 31, 99
#> $ velmedia    <dbl> 4.4, 2.8, 3.9, 1.4, 2.2, 2.5, 1.9, 1.7
#> $ racha       <dbl> 11.4, 7.5, 11.7, 7.2, 8.1, 8.9, 10.3, 6.4
#> $ horaracha   <chr> "13:40", "15:00", "12:20", "11:20", "14:10", "Varias", "09…
#> $ sol         <dbl> 6.0, 7.7, 8.0, 6.6, NA, NA, NA, NA
#> $ presMax     <dbl> 996.3, 995.7, 998.9, 998.8, 948.3, 948.2, 951.0, 951.7
#> $ horaPresMax <chr> "22", "Varias", "23", "00", "22", "11", "Varias", "09"
#> $ presMin     <dbl> 985.6, 990.4, 989.7, 992.7, 940.5, 945.0, 945.5, 947.7
#> $ horaPresMin <chr> "00", "16", "03", "24", "00", "17", "04", "24"
#> $ hrMedia     <dbl> 58, 59, 52, 52, 56, 56, 55, 49
#> $ hrMax       <dbl> 83, 82, 79, 76, 79, 76, 79, 67
#> $ horaHrMax   <chr> "06:10", "Varias", "06:40", "06:40", "07:20", "05:00", "07…
#> $ hrMin       <dbl> 39, 39, 29, 35, 35, 38, 28, 31
#> $ horaHrMin   <chr> "15:40", "Varias", "14:50", "13:40", "Varias", "15:40", "…
#> $ pintMax     <dbl> 0, 0, 0, 0, 0, 0, 0, 0

# Metadata.
meta <- aemet_daily_clim(c("9434", "3195"), extract_metadata = TRUE)
#> ✖ Tu apiKey ha superado el plazo establecido hasta el 15/10/2026 para su renovación. Debes renovar la credencial antes de continuar utilizando el servicio.
#> Error in aemet_api_call(apidest, verbose, apikey = apikey): HTTP 401 Unauthorized.

glimpse(meta$campos)
#> Error: object 'meta' not found
```
