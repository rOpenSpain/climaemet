# Forecast database for beaches

Get a database of daily weather forecasts for a beach. The beach
database can be accessed with
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

  A vector of beach codes to extract. See
  [`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md).

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

## API key

You need to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)
for beach codes.

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
#> $ elaborado                <dttm> 2026-05-20 08:50:21, 2026-05-20 08:50:21, 20…
#> $ id                       <chr> "0704001", "0704001", "0704001", "0704007", "…
#> $ localidad                <chr> "07040", "07040", "07040", "07040", "07040", …
#> $ fecha                    <date> 2026-05-20, 2026-05-21, 2026-05-22, 2026-05-…
#> $ nombre                   <chr> "Cala Major", "Cala Major", "Cala Major", "Pl…
#> $ estadoCielo_value        <lgl> NA, NA, NA, NA, NA, NA
#> $ estadoCielo_f1           <int> 110, 100, 100, 110, 100, 100
#> $ estadoCielo_descripcion1 <chr> "nuboso", "despejado", "despejado", "nuboso",…
#> $ estadoCielo_f2           <int> 110, 100, 100, 110, 100, 100
#> $ estadoCielo_descripcion2 <chr> "nuboso", "despejado", "despejado", "nuboso",…
#> $ viento_value             <lgl> NA, NA, NA, NA, NA, NA
#> $ viento_f1                <int> 210, 210, 210, 210, 210, 210
#> $ viento_descripcion1      <chr> "flojo", "flojo", "flojo", "flojo", "flojo", …
#> $ viento_f2                <int> 210, 210, 210, 210, 210, 210
#> $ viento_descripcion2      <chr> "flojo", "flojo", "flojo", "flojo", "flojo", …
#> $ oleaje_value             <lgl> NA, NA, NA, NA, NA, NA
#> $ oleaje_f1                <int> 310, 310, 310, 310, 310, 310
#> $ oleaje_descripcion1      <chr> "débil", "débil", "débil", "débil", "débil", …
#> $ oleaje_f2                <int> 310, 310, 310, 310, 310, 310
#> $ oleaje_descripcion2      <chr> "débil", "débil", "débil", "débil", "débil", …
#> $ tMaxima_value            <lgl> NA, NA, NA, NA, NA, NA
#> $ tMaxima_valor1           <int> 25, 26, 26, 26, 26, 26
#> $ sTermica_value           <lgl> NA, NA, NA, NA, NA, NA
#> $ sTermica_valor1          <int> 460, 460, 460, 460, 460, 460
#> $ sTermica_descripcion1    <chr> "calor agradable", "calor agradable", "calor …
#> $ tAgua_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ tAgua_valor1             <int> 21, 21, 22, 21, 22, 22
#> $ uvMax_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ uvMax_valor1             <int> 8, 8, 8, 8, 8, 8
#> $ tmaxima_value            <lgl> NA, NA, NA, NA, NA, NA
#> $ tmaxima_valor1           <int> 25, 26, 26, 26, 26, 26
#> $ stermica_value           <lgl> NA, NA, NA, NA, NA, NA
#> $ stermica_valor1          <int> 460, 460, 460, 460, 460, 460
#> $ stermica_descripcion1    <chr> "calor agradable", "calor agradable", "calor …
#> $ tagua_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ tagua_valor1             <int> 21, 21, 22, 21, 22, 22

ggplot(forecast_b) +
  geom_line(aes(fecha, tagua_valor1, color = nombre)) +
  facet_wrap(~nombre, ncol = 1) +
  labs(
    title = "Water temperature in beaches of Palma (ES)",
    subtitle = "3-day forecast",
    x = "Date",
    y = "Temperature (Celsius)",
    color = "Beach"
  )
```
