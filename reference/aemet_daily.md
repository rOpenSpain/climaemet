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
  or "all" for all the stations.

- start, end:

  Character string with start and end date. See **Details**.

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

- return_sf:

  Logical `TRUE` or `FALSE`. Should the function return an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object? If `FALSE` (the default value) it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  Note that you need to have the
  [sf](https://CRAN.R-project.org/package=sf) package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical, display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE` won't be displayed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## Details

`start` and `end` parameters should be:

- For `aemet_daily_clim()`: A `Date` object or a string with format:
  `YYYY-MM-DD` (`"2020-12-31"`) coercible with
  [`as.Date()`](https://rdrr.io/r/base/as.Date.html).

- For `aemet_daily_period()` and `aemet_daily_period_all()`: A string
  representing the year(s) to be extracted: `"2020"`, `"2018"`.

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md),
[`as.Date()`](https://rdrr.io/r/base/as.Date.html)

Other aemet_api_data:
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
#> Rows: 8
#> Columns: 25
#> $ fecha       <date> 2026-02-11, 2026-02-12, 2026-02-13, 2026-02-14, 2026-02-1…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 15.3, 14.0, 10.6, 9.0, 12.4, 10.5, 8.2, 7.0
#> $ prec        <dbl> 1.6, 2.0, 5.4, 0.0, 0.9, 9.9, 2.4, 0.0
#> $ tmin        <dbl> 13.0, 10.3, 8.2, 6.8, 10.8, 7.7, 6.1, 3.9
#> $ horatmin    <chr> "19:00", "07:40", "07:40", "23:59", "Varias", "07:00", "23…
#> $ tmax        <dbl> 17.6, 17.8, 12.9, 11.1, 13.9, 13.3, 10.4, 10.2
#> $ horatmax    <chr> "21:00", "14:40", "00:00", "13:50", "Varias", "13:50", "16…
#> $ dir         <chr> "28", "28", "31", "32", "32", "05", "12", "23"
#> $ velmedia    <dbl> 5.6, 5.3, 3.3, 11.9, 4.2, 2.5, 4.4, 2.2
#> $ racha       <dbl> 20.6, 23.9, 18.1, 24.7, 16.4, 11.9, 16.4, 21.1
#> $ horaracha   <time> 23:20:00, 01:50:00, 23:50:00, 11:40:00, 14:50:00, 17:40:00…
#> $ sol         <dbl> 0.1, 8.4, 0.0, 8.0, NA, NA, NA, NA
#> $ presMax     <dbl> 980.1, 981.1, 977.0, 991.0, 936.4, 939.0, 931.8, 945.3
#> $ horaPresMax <chr> "09", "11", "00", "Varias", "08", "11", "00", "23"
#> $ presMin     <dbl> 970.7, 972.5, 958.3, 967.1, 930.6, 931.8, 916.3, 925.7
#> $ horaPresMin <chr> "20", "01", "15", "00", "16", "24", "09", "00"
#> $ hrMedia     <dbl> 76, 47, 90, 71, 94, 68, 77, 47
#> $ hrMax       <dbl> 92, 59, 95, 74, 99, 95, 99, 73
#> $ horaHrMax   <chr> "19:10", "08:50", "Varias", "17:00", "Varias", "23:50", "V…
#> $ hrMin       <dbl> 48, 30, 55, 62, 56, 51, 59, 36
#> $ horaHrMin   <chr> "23:20", "14:40", "00:00", "Varias", "23:40", "12:10", "16…

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
