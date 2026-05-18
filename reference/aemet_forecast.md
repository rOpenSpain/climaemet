# Forecast database by municipality

Get a database of daily or hourly weather forecasts for a given
municipality.

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

  A vector of municipality codes to extract. For convenience,
  [climaemet](https://CRAN.R-project.org/package=climaemet) provides
  these data in the
  [aemet_munic](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  dataset (see `municipio` field) as of January 2024.

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical. Display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE`, it will not be displayed.

## Value

A nested
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
Forecasted values can be extracted with
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md).
See also **Details**.

## Details

Forecasts provided by the AEMET API have a complex structure. Although
[climaemet](https://CRAN.R-project.org/package=climaemet) returns a
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html), each
forecasted value is provided as a nested
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html). The
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)
helper can unnest these values and provide a single unnested
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) for
the requested variable.

If `extract_metadata = TRUE` a simple
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
describing the value of each field of the forecast is returned.

## API key

You need to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[aemet_munic](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
for municipality codes and
[mapSpain](https://CRAN.R-project.org/package=mapSpain) package for
working with `sf` objects of municipalities (see
[`mapSpain::esp_get_munic()`](https://ropenspain.github.io/mapSpain/reference/esp_get_munic.html)
and **Examples**).

Other aemet_api_data:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md),
[`aemet_monthly`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md),
[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)

Other forecasts:
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)

## Examples

``` r

# Select a city
data("aemet_munic")
library(dplyr)
munis <- aemet_munic |>
  filter(municipio_nombre %in% c("Santiago de Compostela", "Lugo")) |>
  pull(municipio)

daily <- aemet_forecast_daily(munis)
#> ! AEMET API call for "15078" returned an error.
#> ℹ Returning NULL for this query.
#> ! AEMET API call for "27028" returned an error.
#> ℹ Returning NULL for this query.
#> Warning: Unknown or uninitialised column: `id`.

# Metadata
meta <- aemet_forecast_daily(munis, extract_metadata = TRUE)
#> Error in httr2::req_perform(req1): Failed to perform HTTP request.
#> Caused by error in `curl::curl_fetch_memory()`:
#> ! Server returned nothing (no headers, no data) [opendata.aemet.es]:
#> Empty reply from server
glimpse(meta$campos)
#> Error: object 'meta' not found

# Variables available.
aemet_forecast_vars_available(daily)
#> character(0)

# This is nested.
daily |>
  select(municipio, fecha, nombre, temperatura)
#> Error in select(daily, municipio, fecha, nombre, temperatura): Can't select columns that don't exist.
#> ✖ Column `municipio` doesn't exist.

# Select and unnest.
daily_temp <- aemet_forecast_tidy(daily, "temperatura")
#> Error in aemet_forecast_tidy(daily, "temperatura"): Variable "temperatura" not found in `x`.

# This is not nested.
daily_temp
#> Error: object 'daily_temp' not found

# Wrangle and plot.
daily_temp_end <- daily_temp |>
  select(
    elaborado, fecha, municipio, nombre, temperatura_minima,
    temperatura_maxima
  ) |>
  tidyr::pivot_longer(cols = contains("temperatura"))
#> Error: object 'daily_temp' not found

# Plot
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
#> Error: object 'daily_temp_end' not found

# Spatial with mapSpain
library(mapSpain)
library(sf)
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE

lugo_sf <- esp_get_munic(munic = "Lugo") |>
  select(LAU_CODE)
#> ! The file to be downloaded has size 74.6 Mb.

daily_temp_end_lugo_sf <- daily_temp_end |>
  filter(nombre == "Lugo" & name == "temperatura_maxima") |>
  # Join by LAU_CODE.
  left_join(lugo_sf, by = c("municipio" = "LAU_CODE")) |>
  st_as_sf()
#> Error: object 'daily_temp_end' not found

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
#> Error: object 'daily_temp_end_lugo_sf' not found
```
