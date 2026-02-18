# AEMET beaches

Get AEMET beaches.

## Usage

``` r
aemet_beaches(verbose = FALSE, return_sf = FALSE)
```

## Arguments

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

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## Details

The first result of the API call on each session is (temporarily) cached
in the assigned [`tempdir()`](https://rdrr.io/r/base/tempfile.html) for
avoiding unneeded API calls.

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md)

Other aemet_api_data:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md),
[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
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
beaches <- aemet_beaches()
beaches
#> # A tibble: 591 × 10
#>    ID_PLAYA NOMBRE_PLAYA              ID_PROVINCIA NOMBRE_PROVINCIA ID_MUNICIPIO
#>    <chr>    <chr>                     <chr>        <chr>            <chr>       
#>  1 0301101  Raco de l'Albir           03           Alacant/Alicante 03011       
#>  2 0301401  Sant Joan / San Juan      03           Alacant/Alicante 03014       
#>  3 0301408  El Postiguet              03           Alacant/Alicante 03014       
#>  4 0301410  Saladar                   03           Alacant/Alicante 03014       
#>  5 0301808  La Roda                   03           Alacant/Alicante 03018       
#>  6 0301809  Cap Blanch                03           Alacant/Alicante 03018       
#>  7 0303102  Llevant / Playa de Levan… 03           Alacant/Alicante 03031       
#>  8 0303104  Ponent / Playa de Ponien… 03           Alacant/Alicante 03031       
#>  9 0304105  Cala Fustera              03           Alacant/Alicante 03041       
#> 10 0304704  La Fossa                  03           Alacant/Alicante 03047       
#> # ℹ 581 more rows
#> # ℹ 5 more variables: NOMBRE_MUNICIPIO <chr>, LATITUD <chr>, LONGITUD <chr>,
#> #   longitud <dbl>, latitud <dbl>

# Cached during this R session
beaches2 <- aemet_beaches(verbose = TRUE)
#> ℹ Loading beaches from temporal cached file saved at 2026-02-18 06:18:43 UTC

identical(beaches, beaches2)
#> [1] FALSE

# Select an map beaches
library(dplyr)
library(ggplot2)
library(mapSpain)

# Alicante / Alacant
beaches_sf <- aemet_beaches(return_sf = TRUE) |>
  filter(ID_PROVINCIA == "03")

prov <- mapSpain::esp_get_prov("Alicante")

ggplot(prov) +
  geom_sf() +
  geom_sf(
    data = beaches_sf, shape = 4, size = 2.5,
    color = "blue"
  )
```
