# AEMET meteorological alerts

**\[experimental\]** Retrieves current meteorological alerts issued by
AEMET.

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

<https://www.aemet.es/en/eltiempo/prediccion/avisos> and
<https://www.aemet.es/es/eltiempo/prediccion/avisos/ayuda> for API
status and alerts reference, including Annex 2 and Annex 3
documentation.

## Arguments

- ccaa:

  A character vector of autonomous community names or `NULL` to retrieve
  all autonomous communities.

- lang:

  The language of the results, either `"es"` (Spanish) or `"en"`
  (English).

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

See
[mapSpain::esp_codelist](https://ropenspain.github.io/mapSpain/reference/esp_codelist.html)
and
[`mapSpain::esp_dict_region_code()`](https://ropenspain.github.io/mapSpain/reference/esp_dict.html)
for autonomous community names.

Weather alerts:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md)

Weather observations:
[`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md)

## Examples

``` r
# Display CCAA names.
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

# Base map.
cbasemap <- mapSpain::esp_get_ccaa(ccaa = c(
  "Galicia", "Asturias", "Cantabria",
  "Euskadi"
))

# Alerts.
alerts_north <- aemet_alerts(
  ccaa = c("Galicia", "Asturias", "Cantabria", "Euskadi"),
  return_sf = TRUE
)
#> ✔ No current alerts for the selected `ccaa` values.

# Plot if there are alerts.
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
```
