# AEMET wildfire risk forecast

Retrieves daily wildfire risk levels as either tabular data or a
[`SpatRaster`](https://rspatial.github.io/terra/reference/rast.html).

## Usage

``` r
aemet_forecast_fires(
  area = c("p", "c"),
  verbose = FALSE,
  extract_metadata = FALSE
)
```

## Source

<https://www.aemet.es/en/eltiempo/prediccion/incendios>.

## Arguments

- area:

  A character string specifying the forecast area: `"p"` for mainland
  Spain and the Balearic Islands or `"c"` for the Canary Islands.

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) or a
[`SpatRaster`](https://rspatial.github.io/terra/reference/rast.html).

## Details

The `SpatRaster` provides six
[`factor()`](https://rdrr.io/r/base/factor.html) levels: `"1"` for very
low risk, `"2"` for low risk, `"3"` for moderate risk, `"4"` for high
risk, `"5"` for very high risk and `"6"` for extreme risk.

The resulting object has several layers, each representing one of the
next seven forecast days. It also has additional attributes provided by
the [terra](https://CRAN.R-project.org/package=terra), such as
[`terra::time()`](https://rspatial.github.io/terra/reference/time.html)
and
[`terra::coltab()`](https://rspatial.github.io/terra/reference/colors.html).

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

Forecasts:
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)

## Examples

``` r
aemet_forecast_fires(extract_metadata = TRUE)
#> ! HTTP status 429:
#>   Límite de peticiones o caudal por minuto excedido. Espere al siguiente
#>   minuto.
#> ℹ Retrying.
#> Waiting 3s for retry backoff ■■■■■■■■■■■                     
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■    
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 16s for retry backoff ■■■                             
#> Waiting 16s for retry backoff ■■■■■■■■                        
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■            
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■      
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> 
#> # A tibble: 1 × 6
#>   unidad_generadora         descripción periodicidad formato copyright notaLegal
#>   <chr>                     <chr>       <chr>        <chr>   <chr>     <chr>    
#> 1 Servicio de Aplicaciones… Mapa de ni… diario       image/… © AEMET.… https://…

# Extract alerts.
alerts <- aemet_forecast_fires()

alerts
#> class       : SpatRaster
#> size        : 922, 1541, 8  (nrow, ncol, nlyr)
#> resolution  : 0.01, 0.01  (x, y)
#> extent      : -10.205, 5.205, 34.995, 44.215  (xmin, xmax, ymin, ymax)
#> coord. ref. : lon/lat WGS 84 (EPSG:4326)
#> source(s)   : memory
#> color table : 1, 2, 3, 4, 5, 6, 7, 8
#> names       : 2026-07-12, 2026-07-13, 2026-07-14, 2026-07-15, 2026-07-16, 2026-07-17, ...
#> min values  :   Very low,   Very low,   Very low,   Very low,   Very low,   Very low, ...
#> max values  :    Extreme,    Extreme,    Extreme,    Extreme,    Extreme,    Extreme, ...
#> time (days) : 2026-07-12 to 2026-07-19 (8 steps)

# Plot the raster.
library(terra)
#> terra 1.9.34
plot(alerts, all_levels = TRUE)


# Zoom in on an area.
cyl <- mapSpain::esp_get_ccaa("Castilla y Leon", epsg = 4326)

# Convert to a SpatVector.
cyl <- vect(cyl)

fires_cyl <- crop(alerts, cyl)
title <- names(fires_cyl)[1]

plot(fires_cyl[[1]], main = title, all_levels = TRUE)
plot(cyl, add = TRUE)
```
