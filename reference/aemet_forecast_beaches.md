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
#> Rows: 8
#> Columns: 36
#> $ elaborado                <dttm> 2026-02-17 23:50:20, 2026-02-17 23:50:20, 20…
#> $ id                       <chr> "0704001", "0704001", "0704001", "0704001", "…
#> $ localidad                <chr> "07040", "07040", "07040", "07040", "07040", …
#> $ fecha                    <date> 2026-02-17, 2026-02-18, 2026-02-19, 2026-02-…
#> $ nombre                   <chr> "Cala Major", "Cala Major", "Cala Major", "Ca…
#> $ estadoCielo_value        <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ estadoCielo_f1           <int> 110, 100, 100, 100, 120, 100, 100, 100
#> $ estadoCielo_descripcion1 <chr> "nuboso", "despejado", "despejado", "despejad…
#> $ estadoCielo_f2           <int> 100, 120, 100, 110, 100, 120, 100, 110
#> $ estadoCielo_descripcion2 <chr> "despejado", "muy nuboso", "despejado", "nubo…
#> $ viento_value             <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ viento_f1                <int> 230, 210, 230, 230, 210, 210, 220, 220
#> $ viento_descripcion1      <chr> "fuerte", "flojo", "fuerte", "fuerte", "flojo…
#> $ viento_f2                <int> 210, 210, 230, 210, 210, 210, 230, 210
#> $ viento_descripcion2      <chr> "flojo", "flojo", "fuerte", "flojo", "flojo",…
#> $ oleaje_value             <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ oleaje_f1                <int> 310, 310, 310, 310, 320, 320, 320, 320
#> $ oleaje_descripcion1      <chr> "débil", "débil", "débil", "débil", "moderado…
#> $ oleaje_f2                <int> 320, 310, 310, 310, 320, 320, 320, 310
#> $ oleaje_descripcion2      <chr> "moderado", "débil", "débil", "débil", "moder…
#> $ tMaxima_value            <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ tMaxima_valor1           <int> 19, 18, 18, 16, 19, 18, 17, 17
#> $ sTermica_value           <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ sTermica_valor1          <int> 440, 440, 440, 440, 440, 440, 440, 440
#> $ sTermica_descripcion1    <chr> "fresco", "fresco", "fresco", "fresco", "fres…
#> $ tAgua_value              <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ tAgua_valor1             <int> 14, 15, 13, 13, 14, 16, 14, 14
#> $ uvMax_value              <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ uvMax_valor1             <int> 3, 3, 2, 3, 3, 3, 2, 3
#> $ tmaxima_value            <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ tmaxima_valor1           <int> 19, 18, 18, 16, 19, 18, 17, 17
#> $ stermica_value           <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ stermica_valor1          <int> 440, 440, 440, 440, 440, 440, 440, 440
#> $ stermica_descripcion1    <chr> "fresco", "fresco", "fresco", "fresco", "fres…
#> $ tagua_value              <lgl> NA, NA, NA, NA, NA, NA, NA, NA
#> $ tagua_valor1             <int> 14, 15, 13, 13, 14, 16, 14, 14

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
