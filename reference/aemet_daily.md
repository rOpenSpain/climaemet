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

`start` and `end` arguments should be:

- For `aemet_daily_clim()`: A `Date` object or a string with format
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
#> $ fecha       <date> 2026-04-15, 2026-04-16, 2026-04-17, 2026-04-18, 2026-04-1…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 18.6, 19.7, 20.0, 20.8, 17.0, 18.4, 19.6, 20.7
#> $ prec        <dbl> 0, 0, 0, 0, 0, 0, 0, 0
#> $ tmin        <dbl> 11.6, 12.4, 11.8, 13.3, 10.0, 11.4, 12.7, 13.7
#> $ horatmin    <time> 05:00:00, 04:50:00, 05:30:00, 04:00:00, 06:20:00, 06:00:00…
#> $ tmax        <dbl> 25.5, 27.0, 28.1, 28.4, 23.9, 25.5, 26.5, 27.7
#> $ horatmax    <chr> "16:00", "16:00", "16:40", "16:40", "14:30", "Varias", "14…
#> $ dir         <chr> "29", "30", "22", "24", "22", "28", "26", "04"
#> $ velmedia    <dbl> 5.0, 2.5, 1.7, 1.9, 2.5, 2.2, 1.7, 1.9
#> $ racha       <dbl> 10.3, 9.2, 5.6, 10.8, 7.2, 6.7, 6.4, 8.3
#> $ horaracha   <time> 02:50:00, 01:20:00, 06:30:00, 21:30:00, 14:40:00, 14:50:00…
#> $ sol         <dbl> 12.8, 12.7, 12.6, 11.6, NA, NA, NA, NA
#> $ presMax     <dbl> 991.2, 991.8, 990.5, 990.3, 944.4, 943.8, 942.6, 942.0
#> $ horaPresMax <chr> "23", "Varias", "07", "08", "09", "09", "10", "09"
#> $ presMin     <dbl> 987.7, 986.8, 986.3, 985.6, 941.2, 940.5, 939.7, 938.6
#> $ horaPresMin <dbl> 17, 17, 18, 16, 16, 18, 16, 17
#> $ hrMedia     <dbl> 47, 47, 46, 48, 49, 39, 39, 39
#> $ hrMax       <dbl> 81, 80, 81, 80, 83, 73, 66, 69
#> $ horaHrMax   <time> 05:00:00, 04:50:00, 05:30:00, 05:40:00, 06:20:00, 02:10:00…
#> $ hrMin       <dbl> 30, 23, 19, 26, 32, 21, 25, 19
#> $ horaHrMin   <chr> "14:00", "14:00", "15:30", "17:10", "Varias", "18:10", "1…

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
