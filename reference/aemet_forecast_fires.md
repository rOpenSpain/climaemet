# AEMET fires forecast

Get a
[`SpatRaster`](https://rspatial.github.io/terra/reference/rast.html) as
provided by [terra](https://CRAN.R-project.org/package=terra) with the
daily meteorological risk level for wildfires.

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

  The area, being:

  - `"p"` for Mainland Spain and Balearic Islands.

  - `"c"` for Canary Islands.

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [`SpatRaster`](https://rspatial.github.io/terra/reference/rast.html)
object.

## Details

The `SpatRaster` provides 5
([`factor()`](https://rdrr.io/r/base/factor.html))levels with the
following meaning:

- `"1"`: Low risk.

- `"2"`: Moderate risk.

- `"3"`: High risk.

- `"4"`: Very high risk.

- `"5"`: Extreme risk.

The resulting object has several layers, each one representing the
forecast for the upcoming 7 days. It also has additional attributes
provided by the [terra](https://CRAN.R-project.org/package=terra)
package, such as
[`terra::time()`](https://rspatial.github.io/terra/reference/time.html)
and
[`terra::coltab()`](https://rspatial.github.io/terra/reference/colors.html).

## See also

Other aemet_api_data:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md),
[`aemet_monthly`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md),
[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)

Other forecasts:
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)

## Examples

``` r
aemet_forecast_fires(extract_metadata = TRUE)
#> # A tibble: 1 × 6
#>   unidad_generadora         descripción periodicidad formato copyright notaLegal
#>   <chr>                     <chr>       <chr>        <chr>   <chr>     <chr>    
#> 1 Servicio de Aplicaciones… Mapa de ni… diario       image/… © AEMET.… https://…

# Extract alerts
alerts <- aemet_forecast_fires()

alerts
#> class       : SpatRaster 
#> size        : 180, 277, 8  (nrow, ncol, nlyr)
#> resolution  : 0.05, 0.05  (x, y)
#> extent      : -9.5, 4.35, 35.05, 44.05  (xmin, xmax, ymin, ymax)
#> coord. ref. : lon/lat WGS 84 (EPSG:4326) 
#> source(s)   : memory
#> color table : 1, 2, 3, 4, 5, 6, 7, 8 
#> names       : 2026-02-17, 2026-02-18, 2026-02-19, 2026-02-20, 2026-02-21, 2026-02-22, ... 
#> min values  :          1,          1,          1,          1,          1,          1, ... 
#> max values  :          2,          3,          5,          4,          2,          3, ... 
#> time (days) : 2026-02-17 to 2026-02-24 (8 steps) 

# Nice plotting with terra
library(terra)
#> terra 1.8.93
plot(alerts, all_levels = TRUE)


# Zoom in an area
cyl <- mapSpain::esp_get_ccaa("Castilla y Leon", epsg = 4326)

# SpatVector
cyl <- vect(cyl)

fires_cyl <- crop(alerts, cyl)
fires_cyl <- crop(alerts, cyl)
title <- names(fires_cyl)[1]

plot(fires_cyl[[1]], main = title, all_levels = TRUE)
plot(cyl, add = TRUE)
```
