# Extract values from forecasts

**\[experimental\]** `aemet_forecast_vars_available()` lists the
variables in output from
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
or
[`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md).
`aemet_forecast_tidy()` extracts the forecast for `var` as a
[tibble](https://tibble.tidyverse.org/reference/tibble.html).

## Usage

``` r
aemet_forecast_tidy(x, var)

aemet_forecast_vars_available(x)
```

## Arguments

- x:

  A dataset extracted with
  [`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  or
  [`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md).

- var:

  The name of the forecast variable to extract.

## Value

A character vector from `aemet_forecast_vars_available()` or a
[tibble](https://tibble.tidyverse.org/reference/tibble.html) from
`aemet_forecast_tidy()`.

## See also

Forecasts:
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)

## Examples

``` r
# Hourly values.
hourly <- aemet_forecast_hourly(c("15030", "28079"))
#> ! HTTP status 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying.
#> Waiting 3s for retry backoff ■■■■■■■■■■■                     
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■          
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■    
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 16s for retry backoff ■■■                             
#> Waiting 16s for retry backoff ■■■■■■■■■                       
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■            
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■      
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> 

# Variables available.
aemet_forecast_vars_available(hourly)
#>  [1] "estadoCielo"       "precipitacion"     "probPrecipitacion"
#>  [4] "probTormenta"      "nieve"             "probNieve"        
#>  [7] "temperatura"       "sensTermica"       "humedadRelativa"  
#> [10] "vientoAndRachaMax"

# Get temperature.
temp <- aemet_forecast_tidy(hourly, "temperatura")

library(dplyr)
# Create a forecast time and adjust its time zone.
temp_end <- temp |>
  mutate(
    forecast_time = lubridate::force_tz(
      as.POSIXct(fecha) + hora,
      tz = "Europe/Madrid"
    )
  )

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

# Plot.

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
    title = "Forecast: temperature",
    subtitle = paste("Forecast produced on", format(temp_end$elaborado[1],
      usetz = TRUE
    ))
  )
```
