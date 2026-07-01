# Forecast weather in municipalities

Retrieves daily or hourly weather forecasts for one or more
municipalities.

## Usage

``` r
aemet_forecast_daily(
  x,
  verbose = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)

aemet_forecast_hourly(
  x,
  verbose = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)
```

## Arguments

- x:

  A character vector of municipality codes to extract. For convenience,
  [climaemet](https://CRAN.R-project.org/package=climaemet) provides
  these data in the
  [aemet_munic](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  dataset (see `municipio` field) as of January 2024.

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

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

A nested [tibble](https://tibble.tidyverse.org/reference/tibble.html).
Forecast values can be extracted with
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md).
See also **Details**.

## Details

Forecasts provided by the AEMET API have a complex structure. Although
[climaemet](https://CRAN.R-project.org/package=climaemet) returns a
[tibble](https://tibble.tidyverse.org/reference/tibble.html), each
forecast value is provided as a nested
[tibble](https://tibble.tidyverse.org/reference/tibble.html). The
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)
helper can unnest these values and provide a single unnested
[tibble](https://tibble.tidyverse.org/reference/tibble.html) for the
requested variable.

If `extract_metadata = TRUE`, the function returns a simple
[tibble](https://tibble.tidyverse.org/reference/tibble.html) describing
each forecast field.

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[aemet_munic](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
for municipality codes and
[mapSpain](https://CRAN.R-project.org/package=mapSpain) for working with
`sf` objects of municipalities (see
[`mapSpain::esp_get_munic()`](https://ropenspain.github.io/mapSpain/reference/esp_get_munic.html)
and **Examples**).

Forecasts:
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)

## Examples

``` r

# Select cities.
data("aemet_munic")
library(dplyr)
munis <- aemet_munic |>
  filter(municipio_nombre %in% c("Santiago de Compostela", "Lugo")) |>
  pull(municipio)

daily <- aemet_forecast_daily(munis)

# Metadata.
meta <- aemet_forecast_daily(munis, extract_metadata = TRUE)
glimpse(meta$campos)
#> Rows: 23
#> Columns: 5
#> $ id          <chr> "id", "version", "elaborado", "nombre", "provincia", "fech…
#> $ descripcion <chr> "Indicativo de municipio", "Versión", "Fecha de elaboració…
#> $ tipo_datos  <chr> "string", "float", "dataTime", "string", "string", "date",…
#> $ requerido   <lgl> TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, …
#> $ unidad      <chr> NA, NA, NA, NA, NA, NA, "Tanto por ciento (%)", "metros (m…

# Variables available.
aemet_forecast_vars_available(daily)
#> [1] "probPrecipitacion" "cotaNieveProv"     "estadoCielo"      
#> [4] "viento"            "rachaMax"          "temperatura"      
#> [7] "sensTermica"       "humedadRelativa"  

# This is nested.
daily |>
  select(municipio, fecha, nombre, temperatura)
#> # A tibble: 14 × 4
#>    municipio fecha      nombre                 temperatura$maxima $minima $dato 
#>    <chr>     <date>     <chr>                               <int>   <int> <list>
#>  1 15078     2026-07-01 Santiago de Compostela                 26      15 <df>  
#>  2 15078     2026-07-02 Santiago de Compostela                 30      17 <df>  
#>  3 15078     2026-07-03 Santiago de Compostela                 32      17 <df>  
#>  4 15078     2026-07-04 Santiago de Compostela                 37      18 <df>  
#>  5 15078     2026-07-05 Santiago de Compostela                 38      19 <df>  
#>  6 15078     2026-07-06 Santiago de Compostela                 38      20 <df>  
#>  7 15078     2026-07-07 Santiago de Compostela                 38      20 <df>  
#>  8 27028     2026-07-01 Lugo                                   23      15 <df>  
#>  9 27028     2026-07-02 Lugo                                   26      13 <df>  
#> 10 27028     2026-07-03 Lugo                                   28      15 <df>  
#> 11 27028     2026-07-04 Lugo                                   31      16 <df>  
#> 12 27028     2026-07-05 Lugo                                   35      15 <df>  
#> 13 27028     2026-07-06 Lugo                                   38      17 <df>  
#> 14 27028     2026-07-07 Lugo                                   37      20 <df>  

# Select and unnest.
daily_temp <- aemet_forecast_tidy(daily, "temperatura")

# This is not nested.
daily_temp
#> # A tibble: 14 × 14
#>    elaborado           municipio nombre provincia id    version uvMax fecha     
#>    <dttm>              <chr>     <chr>  <chr>     <chr>   <dbl> <int> <date>    
#>  1 2026-07-01 13:08:09 15078     Santi… A Coruña  15078       1     9 2026-07-01
#>  2 2026-07-01 13:08:09 15078     Santi… A Coruña  15078       1     9 2026-07-02
#>  3 2026-07-01 13:08:09 15078     Santi… A Coruña  15078       1     8 2026-07-03
#>  4 2026-07-01 13:08:09 15078     Santi… A Coruña  15078       1     8 2026-07-04
#>  5 2026-07-01 13:08:09 15078     Santi… A Coruña  15078       1     9 2026-07-05
#>  6 2026-07-01 13:08:09 15078     Santi… A Coruña  15078       1    NA 2026-07-06
#>  7 2026-07-01 13:08:09 15078     Santi… A Coruña  15078       1    NA 2026-07-07
#>  8 2026-07-01 13:08:09 27028     Lugo   Lugo      27028       1     9 2026-07-01
#>  9 2026-07-01 13:08:09 27028     Lugo   Lugo      27028       1     9 2026-07-02
#> 10 2026-07-01 13:08:09 27028     Lugo   Lugo      27028       1     8 2026-07-03
#> 11 2026-07-01 13:08:09 27028     Lugo   Lugo      27028       1     9 2026-07-04
#> 12 2026-07-01 13:08:09 27028     Lugo   Lugo      27028       1     8 2026-07-05
#> 13 2026-07-01 13:08:09 27028     Lugo   Lugo      27028       1    NA 2026-07-06
#> 14 2026-07-01 13:08:09 27028     Lugo   Lugo      27028       1    NA 2026-07-07
#> # ℹ 6 more variables: temperatura_maxima <int>, temperatura_minima <int>,
#> #   temperatura_6 <int>, temperatura_12 <int>, temperatura_18 <int>,
#> #   temperatura_24 <int>

# Wrangle and plot.
daily_temp_end <- daily_temp |>
  select(
    elaborado, fecha, municipio, nombre, temperatura_minima,
    temperatura_maxima
  ) |>
  tidyr::pivot_longer(cols = contains("temperatura"))

# Plot.
library(ggplot2)
ggplot(daily_temp_end) +
  geom_line(aes(fecha, value, color = name)) +
  facet_wrap(~nombre, ncol = 1) +
  scale_color_manual(
    values = c("red", "blue"),
    labels = c("max", "min")
  ) +
  scale_x_date(
    labels = scales::label_date_short(),
    breaks = "day"
  ) +
  scale_y_continuous(
    labels = scales::label_comma(suffix = "º")
  ) +
  theme_minimal() +
  labs(
    x = "", y = "",
    color = "",
    title = "Forecast: 7-day temperature",
    subtitle = paste(
      "Forecast produced on",
      format(daily_temp_end$elaborado[1], usetz = TRUE)
    )
  )


# Spatial data.
library(mapSpain)
library(sf)
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE

lugo_sf <- esp_get_munic(munic = "Lugo") |>
  select(LAU_CODE)
#> ! The file to download is "74.6 Mb".

daily_temp_end_lugo_sf <- daily_temp_end |>
  filter(nombre == "Lugo" & name == "temperatura_maxima") |>
  # Join by LAU_CODE.
  left_join(lugo_sf, by = c("municipio" = "LAU_CODE")) |>
  st_as_sf()

ggplot(daily_temp_end_lugo_sf) +
  geom_sf(aes(fill = value)) +
  facet_wrap(~fecha) +
  scale_fill_gradientn(
    colors = c("blue", "red"),
    guide = guide_legend()
  ) +
  labs(
    main = "Forecast: 7-day max temperature",
    subtitle = "Lugo, ES"
  )
#> Ignoring unknown labels:
#> • main : "Forecast: 7-day max temperature"
```
