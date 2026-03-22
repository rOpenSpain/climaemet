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
#> Rows: 10
#> Columns: 25
#> $ fecha       <date> 2026-03-15, 2026-03-16, 2026-03-17, 2026-03-18, 2026-03-1…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 10.2, 12.8, 13.4, 14.0, 13.0, 10.8, 11.8, 14.0, 13.6, 13.1
#> $ prec        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#> $ tmin        <dbl> 6.5, 7.1, 5.1, 6.4, 8.7, 6.2, 4.2, 6.3, 9.2, 8.3
#> $ horatmin    <chr> "06:30", "03:40", "06:30", "06:30", "23:50", "Varias", "06…
#> $ tmax        <dbl> 13.8, 18.4, 21.8, 21.5, 17.3, 15.4, 19.3, 21.6, 17.9, 17.9
#> $ horatmax    <time> 15:00:00, 15:40:00, 16:10:00, 15:10:00, 15:50:00, 14:50:00…
#> $ dir         <chr> "32", "30", "14", "12", "13", "02", "04", "06", "04", "14"
#> $ velmedia    <dbl> 10.8, 6.7, 2.5, 1.9, 5.6, 3.3, 0.6, 1.7, 1.7, 2.5
#> $ racha       <dbl> 20.6, 14.2, 7.2, 13.9, 11.9, 14.7, 5.8, 5.0, 5.8, 8.3
#> $ horaracha   <time> 12:40:00, 09:20:00, 17:40:00, 22:20:00, 11:30:00, 11:20:00…
#> $ sol         <dbl> 11.5, 11.5, 11.7, 11.0, 6.5, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 990.5, 992.5, 989.1, 982.9, 986.4, 942.2, 944.3, 941.2, 93…
#> $ horaPresMax <chr> "24", "10", "00", "24", "Varias", "24", "10", "00", "00", …
#> $ presMin     <dbl> 981.8, 989.1, 980.8, 975.7, 982.9, 933.3, 941.2, 932.3, 92…
#> $ horaPresMin <chr> "00", "24", "24", "16", "00", "00", "24", "Varias", "Vari…
#> $ hrMedia     <dbl> 59, 64, 57, 57, 63, 46, 52, 40, 35, 55
#> $ hrMax       <dbl> 81, 86, 95, 88, 86, 74, 85, 77, 53, 76
#> $ horaHrMax   <chr> "04:50", "05:00", "06:40", "06:30", "02:50", "05:50", "06:…
#> $ hrMin       <dbl> 44, 46, 24, 36, 42, 32, 25, 20, 27, 36
#> $ horaHrMin   <chr> "14:00", "14:50", "15:20", "15:10", "15:50", "13:40", "Var…

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
