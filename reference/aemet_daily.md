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
#> Rows: 10
#> Columns: 25
#> $ fecha       <date> 2026-04-25, 2026-04-26, 2026-04-27, 2026-04-28, 2026-04-2…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 20.6, 21.2, 20.8, 19.7, 19.2, 19.4, 19.8, 20.1, 19.7, 18.3
#> $ prec        <dbl> 0.0, 0.0, 0.0, 0.2, 8.8, 0.0, 0.0, 0.0, 0.0, 0.5
#> $ tmin        <dbl> 14.2, 14.1, 13.0, 11.6, 15.2, 15.1, 13.8, 13.7, 14.3, 13.8
#> $ horatmin    <chr> "05:10", "05:30", "05:30", "05:10", "Varias", "06:00", "05…
#> $ tmax        <dbl> 26.9, 28.4, 28.5, 27.8, 23.1, 23.8, 25.7, 26.5, 25.1, 22.8
#> $ horatmax    <time> 15:50:00, 14:50:00, 15:30:00, 16:00:00, 15:20:00, 13:40:00…
#> $ dir         <chr> "30", "30", "12", "11", "10", "28", "27", "02", "10", "08"
#> $ velmedia    <dbl> 2.2, 2.5, 3.1, 4.2, 4.7, 1.4, 1.4, 1.1, 1.7, 3.1
#> $ racha       <dbl> 8.9, 8.6, 9.4, 12.2, 11.9, 8.6, 6.7, 8.1, 9.2, 12.2
#> $ horaracha   <time> 08:10:00, 01:50:00, 15:10:00, 18:50:00, 16:50:00, 21:20:00…
#> $ sol         <dbl> 12.0, 10.8, 12.9, 10.5, 4.5, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 988.9, 989.5, 988.9, 985.7, 985.1, 941.3, 941.3, 940.6, 93…
#> $ horaPresMax <chr> "09", "Varias", "07", "00", "24", "23", "09", "00", "Varia…
#> $ presMin     <dbl> 985.1, 985.4, 982.8, 977.6, 978.1, 937.2, 938.1, 935.2, 93…
#> $ horaPresMin <dbl> 16, 18, 17, 17, 17, 16, 17, 19, 18, 15
#> $ hrMedia     <dbl> 55, 48, 36, 39, 64, 61, 48, 42, 34, 66
#> $ hrMax       <dbl> 81, 81, 75, 86, 96, 84, 85, 81, 71, 91
#> $ horaHrMax   <time> 05:20:00, 05:30:00, 23:50:00, 03:10:00, 23:59:00, 06:00:0…
#> $ hrMin       <dbl> 35, 28, 22, 17, 51, 40, 29, 16, 27, 42
#> $ horaHrMin   <chr> "17:20", "16:20", "17:40", "13:40", "16:00", "16:20", "Var…

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
