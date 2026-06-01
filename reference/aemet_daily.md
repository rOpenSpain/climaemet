# Daily/annual climatology values

Get climatology values for a station or for all the available stations.
Note that `aemet_daily_period()` and `aemet_daily_period_all()` are
shortcuts of `aemet_daily_clim()`.

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

  Character string with station identifier code(s) (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md))
  or `"all"` for all the stations.

- start, end:

  Character strings with start and end dates. See **Details**.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

- return_sf:

  Logical. If `TRUE`, the function returns an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object. If `FALSE` (the default value), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  The [sf](https://CRAN.R-project.org/package=sf) package must be
  installed.

- extract_metadata:

  Logical. If `TRUE`, the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical. Displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE`, it will not be displayed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## Details

`start` and `end` arguments must be:

- For `aemet_daily_clim()`: A `Date` object or a string with format
  `YYYY-MM-DD` (`"2020-12-31"`) coercible with
  [`as.Date()`](https://rdrr.io/r/base/as.Date.html).

- For `aemet_daily_period()` and `aemet_daily_period_all()`: A string
  representing the year(s) to be extracted: `"2020"`, `"2018"`.

## API key

You need to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).
Query timeout can be controlled with `options(climaemet_timeout = 60)`
(default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md),
[`as.Date()`](https://rdrr.io/r/base/as.Date.html)

AEMET data functions:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md),
[`aemet_monthly`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md),
[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)

## Examples

``` r

library(tibble)
obs <- aemet_daily_clim(c("9434", "3195"))
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying.
#> 
glimpse(obs)
#> Rows: 10
#> Columns: 25
#> $ fecha       <date> 2026-05-25, 2026-05-26, 2026-05-27, 2026-05-28, 2026-05-2…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 24.6, 24.4, 26.6, 27.3, 28.8, 25.0, 24.6, 26.2, 27.1, 28.2
#> $ prec        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#> $ tmin        <dbl> 15.7, 15.7, 17.0, 18.8, 20.1, 18.5, 17.4, 18.6, 19.6, 20.9
#> $ horatmin    <time> 04:30:00, 05:00:00, 04:40:00, 04:20:00, 04:40:00, 06:00:00…
#> $ tmax        <dbl> 33.4, 33.2, 36.3, 35.8, 37.4, 31.4, 31.8, 33.8, 34.6, 35.4
#> $ horatmax    <time> 15:20:00, 16:20:00, 17:20:00, 15:00:00, 15:40:00, 14:30:00…
#> $ dir         <chr> "10", "09", "22", "30", "99", "01", "34", "31", "36", "99"
#> $ velmedia    <dbl> 5.0, 2.5, 0.8, 1.1, 1.9, 2.5, 1.9, 1.7, 1.7, 1.4
#> $ racha       <dbl> 13.1, 8.3, 6.1, 5.8, 6.4, 8.3, 5.8, 7.2, 6.7, 5.6
#> $ horaracha   <chr> "15:40", "12:50", "20:10", "22:00", "Varias", "21:10", "12…
#> $ sol         <dbl> 14.3, 14.4, 13.9, 14.0, 13.3, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 997.9, 997.5, 993.8, 991.3, 990.6, 949.5, 949.8, 947.1, 94…
#> $ horaPresMax <chr> "Varias", "06", "00", "08", "08", "08", "08", "07", "08",…
#> $ presMin     <dbl> 994.4, 992.5, 987.9, 987.0, 986.5, 946.3, 945.6, 941.2, 94…
#> $ horaPresMin <dbl> 17, 18, 19, 17, 17, 18, 19, 18, 18, 18
#> $ hrMedia     <dbl> 31, 28, 27, 29, 35, 27, 26, 26, 26, 24
#> $ hrMax       <dbl> 63, 61, 54, 61, 63, 49, 50, 49, 45, 40
#> $ horaHrMax   <time> 04:10:00, 04:50:00, 05:00:00, 04:10:00, 04:40:00, 06:30:0…
#> $ hrMin       <dbl> 19, 7, 11, 10, 16, 15, 15, 15, 14, 11
#> $ horaHrMin   <chr> "Varias", "17:00", "16:30", "17:40", "14:40", "15:40", "14…

# Metadata
meta <- aemet_daily_clim(c("9434", "3195"), extract_metadata = TRUE)
#> Error in httr2::req_perform(req1): Failed to perform HTTP request.
#> Caused by error in `curl::curl_fetch_memory()`:
#> ! Server returned nothing (no headers, no data) [opendata.aemet.es]:
#> Empty reply from server

glimpse(meta$campos)
#> Error: object 'meta' not found
```
