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
  [`tibble`](https://tibble.tidyverse.org/reference/tibble.html). Note
  that you need to have the [sf](https://CRAN.R-project.org/package=sf)
  package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with
  the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical, display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE` won't be displayed.

## Value

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object.

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
#> $ fecha       <date> 2025-12-17, 2025-12-18, 2025-12-19, 2025-12-20, 2025-12-1…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 11.7, 9.9, 9.2, 7.8, NA, NA, NA, 7.8
#> $ prec        <dbl> 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.1, 7.4
#> $ tmin        <dbl> 8.4, 7.3, 8.1, 6.1, NA, NA, NA, 6.0
#> $ horatmin    <chr> "23:40", "05:50", "Varias", "09:30", NA, NA, NA, "Varias"
#> $ tmax        <dbl> 15.0, 12.5, 10.4, 9.5, NA, NA, NA, 9.5
#> $ horatmax    <time> 15:40:00, 14:10:00, 14:50:00, 15:40:00,       NA,       NA…
#> $ dir         <chr> "30", "13", "99", "13", "03", "23", "33", "08"
#> $ velmedia    <dbl> 1.9, 3.6, 1.4, 3.3, 1.9, 1.7, 1.4, 1.1
#> $ racha       <dbl> 5.8, 8.3, 6.9, 5.8, 12.5, 4.2, 3.6, 8.9
#> $ horaracha   <chr> "00:20", "13:40", "Varias", "13:50", "07:10", "07:00", "04…
#> $ sol         <dbl> 2.7, 4.1, 0.0, 0.7, NA, NA, NA, NA
#> $ presMax     <dbl> 994.2, 994.6, 991.6, 988.2, 945.9, NA, 943.0, 939.4
#> $ horaPresMax <chr> "23", "09", "10", "00", "24", NA, "00", "00"
#> $ presMin     <dbl> 986.8, 991.0, 988.2, 979.6, 937.2, NA, 939.4, 932.5
#> $ horaPresMin <chr> "00", "15", "24", "24", "00", NA, "24", "24"
#> $ hrMedia     <dbl> 84, 90, 95, 97, NA, NA, NA, 91
#> $ hrMax       <dbl> 97, 100, 100, 100, NA, NA, NA, 95
#> $ horaHrMax   <chr> "23:50", "Varias", "03:50", "Varias", NA, NA, NA, "14:00"
#> $ hrMin       <dbl> 67, 76, 91, 88, NA, NA, NA, 85
#> $ horaHrMin   <time> 15:20:00, 15:00:00, 15:30:00, 15:40:00,       NA,       NA…

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
