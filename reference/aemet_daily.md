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
#> $ fecha       <date> 2026-03-17, 2026-03-18, 2026-03-19, 2026-03-20, 2026-03-1…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "3195", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "MADRID", …
#> $ altitud     <dbl> 249, 249, 249, 249, 667, 667, 667, 667
#> $ tmed        <dbl> 13.4, 14.0, 13.0, 11.2, 14.0, 13.6, 13.1, 9.6
#> $ prec        <dbl> 0, 0, 0, 0, 0, 0, 0, 4
#> $ tmin        <dbl> 5.1, 6.4, 8.7, 4.9, 6.3, 9.2, 8.3, 8.1
#> $ horatmin    <time> 06:30:00, 06:30:00, 23:50:00, 06:10:00, 05:50:00, 06:50:00…
#> $ tmax        <dbl> 21.8, 21.5, 17.3, 17.4, 21.6, 17.9, 17.9, 11.1
#> $ horatmax    <time> 16:10:00, 15:10:00, 15:50:00, 15:50:00, 16:40:00, 14:40:00…
#> $ dir         <chr> "14", "12", "13", "10", "06", "04", "14", "20"
#> $ velmedia    <dbl> 2.5, 1.9, 5.6, 3.6, 1.7, 1.7, 2.5, 1.9
#> $ racha       <dbl> 7.2, 13.9, 11.9, 10.8, 5.0, 5.8, 8.3, 7.2
#> $ horaracha   <time> 17:40:00, 22:20:00, 11:30:00, 12:30:00, 01:00:00, 03:00:00…
#> $ sol         <dbl> 11.7, 11.0, 6.5, 10.3, NA, NA, NA, NA
#> $ presMax     <dbl> 989.1, 982.9, 986.4, 986.7, 941.2, 932.3, 935.9, 936.0
#> $ horaPresMax <chr> "00", "24", "Varias", "08", "00", "00", "10", "11"
#> $ presMin     <dbl> 980.8, 975.7, 982.9, 982.4, 932.3, 929.2, 931.3, 933.3
#> $ horaPresMin <chr> "24", "16", "00", "16", "Varias", "Varias", "00", "16"
#> $ hrMedia     <dbl> 57, 57, 63, 53, 40, 35, 55, 80
#> $ hrMax       <dbl> 95, 88, 86, 89, 77, 53, 76, 97
#> $ horaHrMax   <chr> "06:40", "06:30", "02:50", "Varias", "05:30", "22:30", "Va…
#> $ hrMin       <dbl> 24, 36, 42, 25, 20, 27, 36, 63
#> $ horaHrMin   <time> 15:20:00, 15:10:00, 15:50:00, 16:00:00, 15:30:00, 13:10:0…

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
