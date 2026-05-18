# Helper functions for extracting forecasts

**\[experimental\]** Helpers for
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
and
[`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md):

- `aemet_forecast_vars_available()` extracts the values available in the
  dataset.

- `aemet_forecast_tidy()` produces a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the forecast for `var`.

## Usage

``` r
aemet_forecast_tidy(x, var)

aemet_forecast_vars_available(x)
```

## Arguments

- x:

  A database extracted with
  [`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  or
  [`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md).

- var:

  Name of the desired variable to extract.

## Value

A vector of characters (`aemet_forecast_vars_available()`) or a
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
(`aemet_forecast_tidy()`).

## See also

Other forecasts:
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)

## Examples

``` r
# Hourly values
hourly <- aemet_forecast_hourly(c("15030", "28079"))
#> ! AEMET API call for "15030" returned an error.
#> ℹ Returning NULL for this query.
#> ! AEMET API call for "28079" returned an error.
#> ℹ Returning NULL for this query.
#> Warning: Unknown or uninitialised column: `id`.

# Variables available.
aemet_forecast_vars_available(hourly)
#> character(0)

# Get temperature
temp <- aemet_forecast_tidy(hourly, "temperatura")
#> Error in aemet_forecast_tidy(hourly, "temperatura"): Variable "temperatura" not found in `x`.

library(dplyr)
# Create a forecast time. This needs lubridate to adjust time zones.
temp_end <- temp |>
  mutate(
    forecast_time = lubridate::force_tz(
      as.POSIXct(fecha) + hora,
      tz = "Europe/Madrid"
    )
  )
#> Error: object 'temp' not found

# Add sunset and sunrise.
suns <- temp_end |>
  select(nombre, fecha, orto, ocaso) |>
  distinct_all() |>
  group_by(nombre) |>
  mutate(
    ocaso_end = lubridate::force_tz(
      as.POSIXct(fecha) + ocaso,
      tz = "Europe/Madrid"
    ),
    orto_end = lubridate::force_tz(
      as.POSIXct(fecha) + orto,
      tz = "Europe/Madrid"
    ),
    orto_lead = lead(orto_end)
  ) |>
  tidyr::drop_na()
#> Error: object 'temp_end' not found

# Plot

library(ggplot2)

ggplot(temp_end) +
  geom_rect(data = suns, aes(
    xmin = ocaso_end, xmax = orto_lead,
    ymin = min(temp_end$temperatura),
    ymax = max(temp_end$temperatura)
  ), alpha = 0.4) +
  geom_line(aes(forecast_time, temperatura), color = "blue4") +
  facet_wrap(~nombre, nrow = 2) +
  scale_x_datetime(labels = scales::label_date_short()) +
  scale_y_continuous(labels = scales::label_number(suffix = "º")) +
  labs(
    x = "", y = "",
    title = "Forecast: Temperature",
    subtitle = paste("Forecast produced on", format(temp_end$elaborado[1],
      usetz = TRUE
    ))
  )
#> Error: object 'temp_end' not found
```
