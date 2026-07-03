# Forecast weather at beaches

Retrieves daily weather forecasts for one or more beaches. Use
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)
to obtain beach codes.

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

  A character vector of beach codes to extract. See
  [`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md).

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- return_sf:

  A logical value. If `TRUE`, the function returns an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object. If `FALSE` (the default), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  A logical value. If `TRUE`, displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  unless `verbose = TRUE`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object.

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)
for beach codes.

Forecasts:
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)

## Examples

``` r
# Forecast for beaches in Palma, Mallorca.
library(dplyr)
library(ggplot2)

palma_b <- aemet_beaches() |>
  filter(ID_MUNICIPIO == "07040")

forecast_b <- aemet_forecast_beaches(palma_b$ID_PLAYA)
glimpse(forecast_b)
#> Rows: 6
#> Columns: 36
#> $ elaborado                <dttm> 2026-07-03 09:00:24, 2026-07-03 09:00:24, 20…
#> $ id                       <chr> "0704001", "0704001", "0704001", "0704007", "…
#> $ localidad                <chr> "07040", "07040", "07040", "07040", "07040", …
#> $ fecha                    <date> 2026-07-03, 2026-07-04, 2026-07-05, 2026-07-…
#> $ nombre                   <chr> "Cala Major", "Cala Major", "Cala Major", "Pl…
#> $ estadoCielo_value        <lgl> NA, NA, NA, NA, NA, NA
#> $ estadoCielo_f1           <int> 100, 100, 100, 100, 100, 100
#> $ estadoCielo_descripcion1 <chr> "despejado", "despejado", "despejado", "despe…
#> $ estadoCielo_f2           <int> 100, 100, 100, 100, 100, 100
#> $ estadoCielo_descripcion2 <chr> "despejado", "despejado", "despejado", "despe…
#> $ viento_value             <lgl> NA, NA, NA, NA, NA, NA
#> $ viento_f1                <int> 220, 210, 210, 220, 210, 210
#> $ viento_descripcion1      <chr> "moderado", "flojo", "flojo", "moderado", "fl…
#> $ viento_f2                <int> 210, 210, 210, 220, 210, 210
#> $ viento_descripcion2      <chr> "flojo", "flojo", "flojo", "moderado", "flojo…
#> $ oleaje_value             <lgl> NA, NA, NA, NA, NA, NA
#> $ oleaje_f1                <int> 310, 310, 310, 310, 310, 310
#> $ oleaje_descripcion1      <chr> "débil", "débil", "débil", "débil", "débil", …
#> $ oleaje_f2                <int> 310, 310, 310, 310, 310, 310
#> $ oleaje_descripcion2      <chr> "débil", "débil", "débil", "débil", "débil", …
#> $ tMaxima_value            <lgl> NA, NA, NA, NA, NA, NA
#> $ tMaxima_valor1           <int> 33, 33, 34, 33, 34, 36
#> $ sTermica_value           <lgl> NA, NA, NA, NA, NA, NA
#> $ sTermica_valor1          <int> 470, 470, 470, 470, 470, 480
#> $ sTermica_descripcion1    <chr> "calor moderado", "calor moderado", "calor mo…
#> $ tAgua_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ tAgua_valor1             <int> 26, 26, 26, 26, 26, 27
#> $ uvMax_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ uvMax_valor1             <int> 9, 9, 8, 9, 9, 8
#> $ tmaxima_value            <lgl> NA, NA, NA, NA, NA, NA
#> $ tmaxima_valor1           <int> 33, 33, 34, 33, 34, 36
#> $ stermica_value           <lgl> NA, NA, NA, NA, NA, NA
#> $ stermica_valor1          <int> 470, 470, 470, 470, 470, 480
#> $ stermica_descripcion1    <chr> "calor moderado", "calor moderado", "calor mo…
#> $ tagua_value              <lgl> NA, NA, NA, NA, NA, NA
#> $ tagua_valor1             <int> 26, 26, 26, 26, 26, 27

ggplot(forecast_b) +
  geom_line(aes(fecha, tagua_valor1, color = nombre)) +
  facet_wrap(~nombre, ncol = 1) +
  labs(
    title = "Water temperature at beaches in Palma (ES)",
    subtitle = "3-day forecast",
    x = "Date",
    y = "Temperature (Celsius)",
    color = "Beach"
  )
```
