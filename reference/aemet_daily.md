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
glimpse(obs)
#> Rows: 10
#> Columns: 25
#> $ fecha       <date> 2026-06-03, 2026-06-04, 2026-06-05, 2026-06-06, 2026-06-0…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 22.9, 21.4, 20.0, 24.2, 24.2, 23.5, 23.8, 20.8, 23.3, 25.1
#> $ prec        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#> $ tmin        <dbl> 15.8, 15.4, 13.8, 17.2, 15.9, 16.5, 18.4, 13.8, 17.0, 18.8
#> $ horatmin    <chr> "Varias", "23:30", "04:20", "04:50", "04:50", "06:00", "06…
#> $ tmax        <dbl> 30.0, 27.4, 26.2, 31.1, 32.4, 30.5, 29.1, 27.9, 29.6, 31.4
#> $ horatmax    <time> 16:50:00, 11:40:00, 15:40:00, 17:20:00, 15:40:00, 14:40:00…
#> $ dir         <dbl> 32, 34, 30, 31, 12, 14, 15, 27, 13, 99
#> $ velmedia    <dbl> 6.4, 6.4, 4.2, 2.2, 4.7, 1.7, 3.1, 2.5, 1.1, 1.4
#> $ racha       <dbl> 15.8, 15.0, 11.4, 13.1, 11.9, 8.3, 11.1, 9.7, 6.4, 7.5
#> $ horaracha   <chr> "11:10", "13:20", "06:40", "21:00", "19:00", "16:10", "12:…
#> $ sol         <dbl> 14.2, 7.7, 10.8, 11.3, 11.0, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 990.0, 987.2, 988.2, 991.7, 993.7, 942.5, 937.3, 938.5, 94…
#> $ horaPresMax <chr> "07", "24", "07", "Varias", "07", "09", "00", "Varias", "1…
#> $ presMin     <dbl> 982.9, 981.2, 982.7, 985.4, 987.1, 937.3, 934.4, 935.0, 93…
#> $ horaPresMin <chr> "24", "12", "18", "00", "17", "24", "16", "18", "02", "18"
#> $ hrMedia     <dbl> 40, 52, 41, 42, 43, 39, 36, 41, 41, 37
#> $ hrMax       <dbl> 63, 74, 68, 78, 66, 67, 72, 69, 72, 70
#> $ horaHrMax   <time> 04:30:00, 05:00:00, 23:50:00, 05:10:00, 04:30:00, 06:00:0…
#> $ hrMin       <dbl> 29, 37, 30, 21, 29, 23, 18, 22, 20, 21
#> $ horaHrMin   <time> 12:00:00, 13:30:00, 13:40:00, 17:20:00, 15:30:00, 14:40:00…

# Metadata
meta <- aemet_daily_clim(c("9434", "3195"), extract_metadata = TRUE)

glimpse(meta$campos)
#> Rows: 25
#> Columns: 5
#> $ id          <chr> "fecha", "indicativo", "nombre", "provincia", "altitud", "…
#> $ descripcion <chr> "fecha del dia (AAAA-MM-DD)", "indicativo climatológico", …
#> $ tipo_datos  <chr> "string", "string", "string", "string", "float", "float", …
#> $ requerido   <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, …
#> $ unidad      <chr> NA, NA, NA, NA, "m", "°C", "mm (Ip = inferior a 0,1 mm) (A…
```
