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
#> $ fecha       <date> 2026-05-20, 2026-05-21, 2026-05-22, 2026-05-23, 2026-05-2…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 23.0, 24.6, 26.0, 26.0, 25.6, 21.8, 24.4, 25.0, 24.8, 24.8
#> $ prec        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#> $ tmin        <dbl> 15.8, 16.0, 17.9, 17.9, 17.9, 14.2, 17.2, 18.3, 18.2, 17.8
#> $ horatmin    <time> 05:00:00, 04:40:00, 04:50:00, 05:00:00, 04:40:00, 04:20:00…
#> $ tmax        <dbl> 30.1, 33.3, 34.2, 34.1, 33.4, 29.5, 31.5, 31.6, 31.3, 31.8
#> $ horatmax    <time> 16:10:00, 16:10:00, 15:10:00, 16:10:00, 16:00:00, 14:40:00…
#> $ dir         <chr> "31", "12", "99", "12", "14", "27", "03", "28", "36", "32"
#> $ velmedia    <dbl> 3.3, 1.9, 2.2, 2.2, 4.4, 1.4, 1.9, 2.2, 1.9, 2.5
#> $ racha       <dbl> 9.7, 5.3, 5.3, 6.7, 10.8, 5.6, 7.2, 8.6, 6.7, 8.3
#> $ horaracha   <chr> "07:10", "14:10", "Varias", "01:50", "17:50", "06:20", "12…
#> $ sol         <dbl> 14.0, 14.1, 13.7, 14.0, 13.6, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 995.2, 995.8, 995.3, 995.0, 996.3, 946.8, 948.0, 948.3, 94…
#> $ horaPresMax <chr> "08", "07", "09", "08", "24", "10", "08", "08", "08", "08"
#> $ presMin     <dbl> 990.9, 990.9, 990.6, 991.0, 992.6, 944.2, 944.6, 943.9, 9…
#> $ horaPresMin <chr> "00", "18", "18", "18", "16", "17", "17", "Varias", "19", …
#> $ hrMedia     <dbl> 44, 37, 35, 35, 33, 39, 33, 29, 28, 27
#> $ hrMax       <dbl> 77, 70, 70, 73, 72, 77, 58, 50, 57, 51
#> $ horaHrMax   <chr> "05:00", "04:30", "04:40", "05:00", "Varias", "04:00", "0…
#> $ hrMin       <dbl> 25, 19, 17, 20, 15, 22, 18, 17, 13, 14
#> $ horaHrMin   <time> 16:30:00, 16:30:00, 15:40:00, 15:10:00, 17:50:00, 14:50:00…

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
