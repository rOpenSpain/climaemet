# AEMET beaches

Get AEMET beaches.

## Usage

``` r
aemet_beaches(verbose = FALSE, return_sf = FALSE)
```

## Arguments

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

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## Details

The first result of the API call in each session is temporarily cached
in [`tempdir()`](https://rdrr.io/r/base/tempfile.html) to avoid
unnecessary API calls.

## API key

You need to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).
Query timeout can be controlled with `options(climaemet_timeout = 60)`
(default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md)

AEMET data functions:
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
#> ℹ Loading beaches from temporary cached file saved at 2026-06-01 19:34:01 UTC

identical(beaches, beaches2)
#> [1] FALSE

# Select and map beaches
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
