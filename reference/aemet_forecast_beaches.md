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

palma_b <- aemet_beaches() %>%
  filter(ID_MUNICIPIO == "07040")

forecast_b <- aemet_forecast_beaches(palma_b$ID_PLAYA)
glimpse(forecast_b)
#> Rows: 6
#> Columns: 36
#> $ elaborado                <dttm> 2025-11-12 08:50:18, 2025-11-12 08:50:18, 20…
#> $ id                       <chr> "0704001", "0704001", "0704001", "0704007", "…
#> $ localidad                <chr> "07040", "07040", "07040", "07040", "07040", …
#> $ fecha                    <date> 2025-11-12, 2025-11-13, 2025-11-14, 2025-11-…
#> $ nombre                   <chr> "Cala Major", "Cala Major", "Cala Major", "Pl…
#> $ estadoCielo_value        <lgl> NA, NA, NA, NA, NA, NA
#> $ estadoCielo_f1           <int> 100, 100, 120, 100, 100, 120
#> $ estadoCielo_descripcion1 <chr> "despejado", "despejado", "muy nuboso", "desp…
#> $ estadoCielo_f2           <int> 100, 100, 100, 100, 100, 100
#> $ estadoCielo_descripcion2 <chr> "despejado", "despejado", "despejado", "despe…
#> $ viento_value             <lgl> NA, NA, NA, NA, NA, NA
#> $ viento_f1                <int> 220, 220, 220, 210, 210, 220
#> $ viento_descripcion1      <chr> "moderado", "moderado", "moderado", "flojo", …
#> $ viento_f2                <int> 220, 210, 220, 210, 210, 220
#> $ viento_descripcion2      <chr> "moderado", "flojo", "moderado", "flojo", "fl…
#> $ oleaje_value             <lgl> NA, NA, NA, NA, NA, NA
#> $ oleaje_f1                <int> 310, 310, 320, 310, 310, 310
#> $ oleaje_descripcion1      <chr> "débil", "débil", "moderado", "débil", "débil…
#> $ oleaje_f2                <int> 310, 310, 320, 310, 310, 310
#> $ oleaje_descripcion2      <chr> "débil", "débil", "moderado", "débil", "débil…
#> $ tMaxima_value            <lgl> NA, NA, NA, NA, NA, NA
#> $ tMaxima_valor1           <int> 25, 25, 25, 24, 25, 24
#> $ sTermica_value           <lgl> NA, NA, NA, NA, NA, NA
#> $ sTermica_valor1          <int> 460, 460, 450, 450, 460, 450
#> $ sTermica_descripcion1    <chr> "calor agradable", "calor agradable", "suave"…
#> $ tAgua_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ tAgua_valor1             <int> 22, 22, 22, 20, 21, 22
#> $ uvMax_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ uvMax_valor1             <int> 2, 2, 2, 2, 2, 2
#> $ tmaxima_value            <lgl> NA, NA, NA, NA, NA, NA
#> $ tmaxima_valor1           <int> 25, 25, 25, 24, 25, 24
#> $ stermica_value           <lgl> NA, NA, NA, NA, NA, NA
#> $ stermica_valor1          <int> 460, 460, 450, 450, 460, 450
#> $ stermica_descripcion1    <chr> "calor agradable", "calor agradable", "suave"…
#> $ tagua_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ tagua_valor1             <int> 22, 22, 22, 20, 21, 22

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
