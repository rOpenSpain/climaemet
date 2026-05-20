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
  object? If `FALSE` (the default value), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  Note that you need to have the
  [sf](https://CRAN.R-project.org/package=sf) package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical. Display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE`, it will not be displayed.

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

## API key

You need to set your API key globally using
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
#> Rows: 10
#> Columns: 25
#> $ fecha       <date> 2026-05-13, 2026-05-14, 2026-05-15, 2026-05-16, 2026-05-1…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 15.4, 15.3, 13.4, 13.2, 16.0, 14.8, 16.8, 13.3, 13.9, 16.6
#> $ prec        <dbl> 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.0, 0.0
#> $ tmin        <dbl> 10.6, 11.0, 9.6, 7.9, 8.4, 10.0, 11.9, 10.0, 7.4, 10.7
#> $ horatmin    <time> 05:00:00, 03:30:00, 23:59:00, 02:40:00, 05:10:00, 04:50:00…
#> $ tmax        <dbl> 20.1, 19.6, 17.2, 18.6, 23.5, 19.7, 21.7, 16.6, 20.4, 22.6
#> $ horatmax    <time> 14:10:00, 13:00:00, 14:40:00, 14:50:00, 15:50:00, 16:50:00…
#> $ dir         <chr> "31", "32", "32", "33", "30", "14", "99", "23", "03", "20"
#> $ velmedia    <dbl> 7.5, 5.3, 8.9, 6.4, 3.3, 2.2, 3.6, 3.3, 1.4, 1.9
#> $ racha       <dbl> 16.4, 13.1, 18.3, 14.2, 10.0, 8.6, 10.3, 11.7, 5.8, 8.3
#> $ horaracha   <chr> "09:50", "12:30", "16:00", "13:10", "23:50", "18:30", "Var…
#> $ sol         <dbl> 13.1, 5.3, 10.4, 13.1, 12.5, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 987.2, 985.2, 985.2, 986.8, 987.4, 940.2, 937.2, 937.1, 93…
#> $ horaPresMax <chr> "07", "00", "Varias", "Varias", "24", "10", "00", "24", "…
#> $ presMin     <dbl> 984.7, 977.1, 975.2, 984.7, 983.4, 937.1, 929.6, 929.1, 93…
#> $ horaPresMin <chr> "Varias", "24", "04", "17", "16", "18", "18", "04", "18",…
#> $ hrMedia     <dbl> 48, 51, 54, 48, 48, 63, 45, 57, 42, 49
#> $ hrMax       <dbl> 76, 75, 78, 74, 84, 89, 77, 78, 72, 70
#> $ horaHrMax   <chr> "04:40", "03:20", "01:00", "02:40", "04:40", "05:20", "Var…
#> $ hrMin       <dbl> 40, 35, 37, 36, 28, 44, 28, 30, 28, 27
#> $ horaHrMin   <chr> "12:20", "12:30", "14:00", "12:50", "15:30", "Varias", "Va…

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
