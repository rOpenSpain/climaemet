# AEMET Meteorological warnings

**\[experimental\]** Get a database of current meteorological alerts.

## Usage

``` r
aemet_alerts(
  ccaa = NULL,
  lang = c("es", "en"),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)
```

## Source

<https://www.aemet.es/en/eltiempo/prediccion/avisos>.

<https://www.aemet.es/es/eltiempo/prediccion/avisos/ayuda>. See also
Annex 2 and Annex 3 docs, linked in this page.

## Arguments

- ccaa:

  A vector of names for autonomous communities or `NULL` to get all the
  autonomous communities.

- lang:

  Language of the results. It can be `"es"` (Spanish) or `"en"`
  (English).

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

## See also

[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md).
See also
[mapSpain::esp_codelist](https://ropenspain.github.io/mapSpain/reference/esp_codelist.html),
[`mapSpain::esp_dict_region_code()`](https://ropenspain.github.io/mapSpain/reference/esp_dict.html)
to get the names of the autonomous communities.

Other aemet_api_data:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
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
# Display names of CCAAs
library(dplyr)
aemet_alert_zones() |>
  select(NOM_CCAA) |>
  distinct()
#> # A tibble: 19 × 1
#>    NOM_CCAA                  
#>    <chr>                     
#>  1 Andalucía                 
#>  2 Aragón                    
#>  3 Principado de Asturias    
#>  4 Illes Balears             
#>  5 Canarias                  
#>  6 Cantabria                 
#>  7 Castilla y León           
#>  8 Castilla - La Mancha      
#>  9 Cataluña                  
#> 10 Extremadura               
#> 11 Galicia                   
#> 12 Comunidad de Madrid       
#> 13 Región de Murcia          
#> 14 Comunidad Foral de Navarra
#> 15 País Vasco                
#> 16 La Rioja                  
#> 17 Comunitat Valenciana      
#> 18 Ciudad de Ceuta           
#> 19 Ciudad de Melilla         

# Base map
cbasemap <- mapSpain::esp_get_ccaa(ccaa = c(
  "Galicia", "Asturias", "Cantabria",
  "Euskadi"
))

# Alerts
alerts_north <- aemet_alerts(
  ccaa = c("Galicia", "Asturias", "Cantabria", "Euskadi"),
  return_sf = TRUE
)

# If any alert
if (inherits(alerts_north, "sf")) {
  library(ggplot2)
  library(lubridate)

  alerts_north$day <- date(alerts_north$effective)

  ggplot(alerts_north) +
    geom_sf(data = cbasemap, fill = "grey60") +
    geom_sf(aes(fill = `AEMET-Meteoalerta nivel`)) +
    geom_sf(
      data = cbasemap, fill = "transparent", color = "black",
      linewidth = 0.5
    ) +
    facet_grid(vars(`AEMET-Meteoalerta fenomeno`), vars(day)) +
    scale_fill_manual(values = c(
      "amarillo" = "yellow", naranja = "orange",
      "rojo" = "red"
    ))
}
#> 
#> Attaching package: ‘lubridate’
#> The following objects are masked from ‘package:base’:
#> 
#>     date, intersect, setdiff, union
```
