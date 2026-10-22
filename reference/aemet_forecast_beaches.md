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
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  A logical value. If `TRUE`, displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  unless `verbose = TRUE`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
an [`sf`](https://r-spatial.github.io/sf/reference/sf.html) object.

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
#> ✖ Tu apiKey ha superado el plazo establecido hasta el 15/10/2026 para su renovación. Debes renovar la credencial antes de continuar utilizando el servicio.
#> ! AEMET OpenData API request for "0704007" returned an error.
#> ℹ Returning `NULL` for this request.
glimpse(forecast_b)
#> Rows: 3
#> Columns: 36
#> $ elaborado                <dttm> 2026-10-22 08:51:15, 2026-10-22 08:51:15, 20…
#> $ id                       <chr> "0704001", "0704001", "0704001"
#> $ localidad                <chr> "07040", "07040", "07040"
#> $ fecha                    <date> 2026-10-22, 2026-10-23, 2026-10-24
#> $ nombre                   <chr> "Cala Major", "Cala Major", "Cala Major"
#> $ estadoCielo_value        <lgl> NA, NA, NA
#> $ estadoCielo_f1           <int> 110, 110, 120
#> $ estadoCielo_descripcion1 <chr> "nuboso", "nuboso", "muy nuboso"
#> $ estadoCielo_f2           <int> 100, 110, 120
#> $ estadoCielo_descripcion2 <chr> "despejado", "nuboso", "muy nuboso"
#> $ viento_value             <lgl> NA, NA, NA
#> $ viento_f1                <int> 210, 220, 210
#> $ viento_descripcion1      <chr> "flojo", "moderado", "flojo"
#> $ viento_f2                <int> 210, 220, 210
#> $ viento_descripcion2      <chr> "flojo", "moderado", "flojo"
#> $ oleaje_value             <lgl> NA, NA, NA
#> $ oleaje_f1                <int> 310, 320, 310
#> $ oleaje_descripcion1      <chr> "débil", "moderado", "débil"
#> $ oleaje_f2                <int> 310, 310, 310
#> $ oleaje_descripcion2      <chr> "débil", "débil", "débil"
#> $ tMaxima_value            <lgl> NA, NA, NA
#> $ tMaxima_valor1           <int> 23, 24, 21
#> $ sTermica_value           <lgl> NA, NA, NA
#> $ sTermica_valor1          <int> 450, 450, 450
#> $ sTermica_descripcion1    <chr> "suave", "suave", "suave"
#> $ tAgua_value              <lgl> NA, NA, NA
#> $ tAgua_valor1             <int> 25, 24, 23
#> $ uvMax_value              <lgl> NA, NA, NA
#> $ uvMax_valor1             <int> 4, 3, 3
#> $ tmaxima_value            <lgl> NA, NA, NA
#> $ tmaxima_valor1           <int> 23, 24, 21
#> $ stermica_value           <lgl> NA, NA, NA
#> $ stermica_valor1          <int> 450, 450, 450
#> $ stermica_descripcion1    <chr> "suave", "suave", "suave"
#> $ tagua_value              <lgl> NA, NA, NA
#> $ tagua_valor1             <int> 25, 24, 23

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
