# AEMET wildfire risk forecast

Get a
[`SpatRaster`](https://rspatial.github.io/terra/reference/rast.html)
with the daily wildfire risk level.

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

  Forecast area. Accepted values are:

  - `"p"` for mainland Spain and Balearic Islands.

  - `"c"` for Canary Islands.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

- extract_metadata:

  Logical. If `TRUE`, the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [`SpatRaster`](https://rspatial.github.io/terra/reference/rast.html).

## Details

The `SpatRaster` provides six
[`factor()`](https://rdrr.io/r/base/factor.html) levels with the
following meaning:

- `"1"`: Very low risk.

- `"2"`: Low risk.

- `"3"`: Moderate risk.

- `"4"`: High risk.

- `"5"`: Very high risk.

- `"6"`: Extreme risk.

The resulting object has several layers, each one representing the
forecast for the upcoming 7 days. It also has additional attributes
provided by the [terra](https://CRAN.R-project.org/package=terra)
package, such as
[`terra::time()`](https://rspatial.github.io/terra/reference/time.html)
and
[`terra::coltab()`](https://rspatial.github.io/terra/reference/colors.html).

## See also

AEMET data functions:
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

Forecast functions:
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
#> names       : 2026-06-07, 2026-06-08, 2026-06-09, 2026-06-10, 2026-06-11, 2026-06-12, ...
#> min values  :   Very low,   Very low,   Very low,   Very low,   Very low,   Very low, ...
#> max values  :    Extreme,    Extreme,    Extreme,    Extreme,    Extreme,    Extreme, ...
#> time (days) : 2026-06-07 to 2026-06-14 (8 steps)

# Plot with terra.
library(terra)
#> terra 1.9.27
plot(alerts, all_levels = TRUE)


# Zoom in on an area.
cyl <- mapSpain::esp_get_ccaa("Castilla y Leon", epsg = 4326)

# SpatVector
cyl <- vect(cyl)

fires_cyl <- crop(alerts, cyl)
title <- names(fires_cyl)[1]

plot(fires_cyl[[1]], main = title, all_levels = TRUE)
plot(cyl, add = TRUE)
```
