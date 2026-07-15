# AEMET alert zones

Retrieves the AEMET geographical zones used for meteorological alerts.

## Usage

``` r
aemet_alert_zones(verbose = FALSE, return_sf = FALSE)
```

## Source

<https://www.aemet.es/es/eltiempo/prediccion/avisos/ayuda>. See also
Annex 2 and Annex 3 documents, linked from that page.

## Arguments

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- return_sf:

  A logical value. If `TRUE`, the function returns an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object. If `FALSE` (the default), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object.

## Caching

The first result retrieved in each session is temporarily cached in
[`tempdir()`](https://rdrr.io/r/base/tempfile.html) to avoid unnecessary
requests.

## See also

Weather alerts:
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md)

AEMET locations:
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)

## Examples

``` r
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
alert_zones <- aemet_alert_zones()
alert_zones
#> # A tibble: 233 × 6
#>    COD_Z  NOM_Z                           COD_PROV NOM_PROV COD_CCAA NOM_CCAA 
#>    <chr>  <chr>                           <chr>    <chr>    <chr>    <chr>    
#>  1 610401 Valle del Almanzora y Los Vélez 6104     Almería  61       Andalucía
#>  2 610402 Nacimiento y Campo de Tabernas  6104     Almería  61       Andalucía
#>  3 610403 Poniente y Almería Capital      6104     Almería  61       Andalucía
#>  4 610404 Levante almeriense              6104     Almería  61       Andalucía
#>  5 611101 Grazalema                       6111     Cádiz    61       Andalucía
#>  6 611102 Campiña gaditana                6111     Cádiz    61       Andalucía
#>  7 611103 Litoral gaditano                6111     Cádiz    61       Andalucía
#>  8 611104 Estrecho                        6111     Cádiz    61       Andalucía
#>  9 611401 Sierra y Pedroches              6114     Córdoba  61       Andalucía
#> 10 611402 Campiña cordobesa               6114     Córdoba  61       Andalucía
#> # ℹ 223 more rows

# Cached during this R session.
alert_zones2 <- aemet_alert_zones(verbose = TRUE)
#> ℹ Loading "alert zones" from temporary cache file /tmp/RtmppyYGcq/aemet_alert_zones.gpkg, saved at 2026-07-15 13:18:09 UTC.

identical(alert_zones, alert_zones2)
#> [1] TRUE

# Select and map alert zones.
library(ggplot2)

# Galicia.
alert_zones_sf <- aemet_alert_zones(return_sf = TRUE) |>
  filter(COD_CCAA == "71")

# Coast zones have codes ending in "C".
alert_zones_sf$type <- ifelse(grepl("C$", alert_zones_sf$COD_Z),
  "Coast", "Mainland"
)

ggplot(alert_zones_sf) +
  geom_sf(aes(fill = NOM_PROV)) +
  facet_wrap(~type) +
  scale_fill_brewer(palette = "Blues")
```
