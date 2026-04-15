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
#> $ fecha       <date> 2026-04-08, 2026-04-09, 2026-04-10, 2026-04-11, 2026-04-0…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 18.5, 19.8, 21.5, 16.4, 13.2, 17.4, 21.8, 18.8
#> $ prec        <dbl> 0.0, 0.0, 0.0, 4.0, 0.0, 0.0, 0.0, 0.5
#> $ tmin        <dbl> 9.5, 11.4, 14.4, 9.0, 10.3, 10.0, 15.6, 15.0
#> $ horatmin    <time> 06:00:00, 05:00:00, 05:40:00, 23:50:00, 23:59:00, 01:40:00…
#> $ tmax        <dbl> 27.5, 28.1, 28.6, 23.7, 16.2, 24.9, 28.0, 22.7
#> $ horatmax    <time> 15:00:00, 16:00:00, 16:10:00, 12:20:00, 14:00:00, 14:20:00…
#> $ dir         <chr> "12", "30", "30", "30", "26", "05", "04", "06"
#> $ velmedia    <dbl> 3.3, 1.1, 3.3, 5.0, 2.2, 2.5, 2.8, 1.1
#> $ racha       <dbl> 10.8, 8.3, 7.8, 22.2, 10.3, 7.2, 7.8, 11.4
#> $ horaracha   <time> 14:40:00, 21:40:00, 01:10:00, 22:10:00, 13:40:00, 04:50:00…
#> $ sol         <dbl> 10.3, 11.5, 11.8, 2.2, NA, NA, NA, NA
#> $ presMax     <dbl> 990.3, 991.0, 989.6, 985.0, 943.3, 943.0, 941.3, 935.8
#> $ horaPresMax <chr> "09", "09", "00", "Varias", "22", "00", "01", "00"
#> $ presMin     <dbl> 986.6, 986.6, 982.3, 980.1, 939.7, 938.6, 935.4, 931.2
#> $ horaPresMin <chr> "16", "18", "18", "13", "00", "18", "24", "16"
#> $ hrMedia     <dbl> 36, 37, 35, 48, 78, 41, 29, 43
#> $ hrMax       <dbl> 66, 66, 60, 75, 99, 81, 45, 67
#> $ horaHrMax   <chr> "06:00", "06:00", "05:50", "23:50", "Varias", "Varias", "0…
#> $ hrMin       <dbl> 20, 17, 20, 27, 57, 19, 17, 32
#> $ horaHrMin   <time> 15:30:00, 16:00:00, 17:00:00, 12:10:00, 14:00:00, 17:20:0…

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
