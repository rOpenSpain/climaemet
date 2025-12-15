# Forecast database for beaches

Get a database of daily weather forecasts for a beach. Beach database
can be accessed with
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md).

## Usage

``` r
aemet_forecast_beaches(
  x,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)
```

## Arguments

- x:

  A vector of beaches codes to extract. See
  [`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md).

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

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)
for beaches codes.

Other aemet_api_data:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md),
[`aemet_monthly`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md),
[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)

Other forecasts:
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)

## Examples

``` r
# Forecast for beaches in Palma, Mallorca
library(dplyr)
library(ggplot2)

palma_b <- aemet_beaches() |>
  filter(ID_MUNICIPIO == "07040")

forecast_b <- aemet_forecast_beaches(palma_b$ID_PLAYA)
glimpse(forecast_b)
#> Rows: 6
#> Columns: 36
#> $ elaborado                <dttm> 2025-12-15 08:50:21, 2025-12-15 08:50:21, 20…
#> $ id                       <chr> "0704001", "0704001", "0704001", "0704007", "…
#> $ localidad                <chr> "07040", "07040", "07040", "07040", "07040", …
#> $ fecha                    <date> 2025-12-15, 2025-12-16, 2025-12-17, 2025-12-…
#> $ nombre                   <chr> "Cala Major", "Cala Major", "Cala Major", "Pl…
#> $ estadoCielo_value        <lgl> NA, NA, NA, NA, NA, NA
#> $ estadoCielo_f1           <int> 100, -116, 100, 110, -126, 110
#> $ estadoCielo_descripcion1 <chr> "despejado", "muy nuboso con lluvia", "despej…
#> $ estadoCielo_f2           <int> 120, 120, 100, 120, 140, 100
#> $ estadoCielo_descripcion2 <chr> "muy nuboso", "muy nuboso", "despejado", "muy…
#> $ viento_value             <lgl> NA, NA, NA, NA, NA, NA
#> $ viento_f1                <int> 210, 220, 210, 210, 220, 210
#> $ viento_descripcion1      <chr> "flojo", "moderado", "flojo", "flojo", "moder…
#> $ viento_f2                <int> 210, 220, 210, 210, 210, 210
#> $ viento_descripcion2      <chr> "flojo", "moderado", "flojo", "flojo", "flojo…
#> $ oleaje_value             <lgl> NA, NA, NA, NA, NA, NA
#> $ oleaje_f1                <int> 310, 320, 320, 310, 310, 310
#> $ oleaje_descripcion1      <chr> "débil", "moderado", "moderado", "débil", "dé…
#> $ oleaje_f2                <int> 310, 320, 310, 310, 310, 310
#> $ oleaje_descripcion2      <chr> "débil", "moderado", "débil", "débil", "débil…
#> $ tMaxima_value            <lgl> NA, NA, NA, NA, NA, NA
#> $ tMaxima_valor1           <int> 19, 18, 19, 19, 17, 19
#> $ sTermica_value           <lgl> NA, NA, NA, NA, NA, NA
#> $ sTermica_valor1          <int> 440, 440, 440, 450, 440, 440
#> $ sTermica_descripcion1    <chr> "fresco", "fresco", "fresco", "suave", "fresc…
#> $ tAgua_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ tAgua_valor1             <int> 17, 18, 17, 16, 18, 16
#> $ uvMax_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ uvMax_valor1             <int> 1, 1, 1, 1, 1, 1
#> $ tmaxima_value            <lgl> NA, NA, NA, NA, NA, NA
#> $ tmaxima_valor1           <int> 19, 18, 19, 19, 17, 19
#> $ stermica_value           <lgl> NA, NA, NA, NA, NA, NA
#> $ stermica_valor1          <int> 440, 440, 440, 450, 440, 440
#> $ stermica_descripcion1    <chr> "fresco", "fresco", "fresco", "suave", "fresc…
#> $ tagua_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ tagua_valor1             <int> 17, 18, 17, 16, 18, 16

ggplot(forecast_b) +
  geom_line(aes(fecha, tagua_valor1, color = nombre)) +
  facet_wrap(~nombre, ncol = 1) +
  labs(
    title = "Water temperature in beaches of Palma (ES)",
    subtitle = "Forecast 3-days",
    x = "Date",
    y = "Temperature (Celsius)",
    color = "Beach"
  )
```
