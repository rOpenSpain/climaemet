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
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying.
#> Waiting 3s for retry backoff ■■■■■■■■■■■                     
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■       
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> 
glimpse(obs)
#> Rows: 10
#> Columns: 25
#> $ fecha       <date> 2026-06-02, 2026-06-03, 2026-06-04, 2026-06-05, 2026-06-0…
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "3195", "3195", "3…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ provincia   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ altitud     <dbl> 249, 249, 249, 249, 249, 667, 667, 667, 667, 667
#> $ tmed        <dbl> 22.4, 22.9, 21.4, 20.0, 24.2, 25.0, 23.5, 23.8, 20.8, 23.3
#> $ prec        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
#> $ tmin        <dbl> 17.6, 15.8, 15.4, 13.8, 17.2, 20.4, 16.5, 18.4, 13.8, 17.0
#> $ horatmin    <chr> "23:50", "Varias", "23:30", "04:20", "04:50", "23:59", "06…
#> $ tmax        <dbl> 27.1, 30.0, 27.4, 26.2, 31.1, 29.5, 30.5, 29.1, 27.9, 29.6
#> $ horatmax    <time> 14:10:00, 16:50:00, 11:40:00, 15:40:00, 17:20:00, 13:00:00…
#> $ dir         <dbl> 32, 32, 34, 30, 31, 15, 14, 15, 27, 13
#> $ velmedia    <dbl> 7.8, 6.4, 6.4, 4.2, 2.2, 3.1, 1.7, 3.1, 2.5, 1.1
#> $ racha       <dbl> 15.0, 15.8, 15.0, 11.4, 13.1, 10.6, 8.3, 11.1, 9.7, 6.4
#> $ horaracha   <time> 19:50:00, 11:10:00, 13:20:00, 06:40:00, 21:00:00, 13:30:00…
#> $ sol         <dbl> 12.3, 14.2, 7.7, 10.8, 11.3, NA, NA, NA, NA, NA
#> $ presMax     <dbl> 989.8, 990.0, 987.2, 988.2, 991.7, 940.2, 942.5, 937.3, 93…
#> $ horaPresMax <chr> "22", "07", "24", "07", "Varias", "23", "09", "00", "Varia…
#> $ presMin     <dbl> 983.0, 982.9, 981.2, 982.7, 985.4, 937.4, 937.3, 934.4, 93…
#> $ horaPresMin <chr> "01", "24", "12", "18", "00", "Varias", "24", "16", "18",…
#> $ hrMedia     <dbl> 45, 40, 52, 41, 42, 34, 39, 36, 41, 41
#> $ hrMax       <dbl> 67, 63, 74, 68, 78, 55, 67, 72, 69, 72
#> $ horaHrMax   <time> 02:50:00, 04:30:00, 05:00:00, 23:50:00, 05:10:00, 05:00:00…
#> $ hrMin       <dbl> 39, 29, 37, 30, 21, 22, 23, 18, 22, 20
#> $ horaHrMin   <chr> "Varias", "12:00", "13:30", "13:40", "17:20", "Varias", "1…

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
