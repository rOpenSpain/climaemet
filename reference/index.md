# Package index

## Data access

Retrieve observations, locations, alerts and climatology data.

### Observations and locations

Work with weather stations, beaches, alerts and recent observations.

- [`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md)
  : AEMET alert zones
- [`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md)
  **\[experimental\]** : AEMET meteorological alerts
- [`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)
  : AEMET beaches
- [`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md)
  : Latest observations from weather stations
- [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)
  : AEMET stations

### Climatology

Retrieve daily, monthly, normal and extreme climatology values.

- [`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)
  [`aemet_daily_period()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)
  [`aemet_daily_period_all()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)
  : Daily and annual climatology values
- [`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md)
  : Extreme values for a station
- [`aemet_monthly_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md)
  [`aemet_monthly_period()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md)
  [`aemet_monthly_period_all()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md)
  : Monthly and annual climatology values
- [`aemet_normal_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)
  [`aemet_normal_clim_all()`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)
  : Climatological normal values

## Forecasts

Retrieve and process municipality, beach and wildfire forecasts.

- [`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  [`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  : Forecast weather in municipalities
- [`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md)
  : Forecast weather at beaches
- [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
  : AEMET wildfire risk forecast
- [`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)
  [`aemet_forecast_vars_available()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)
  **\[experimental\]** : Extract values from forecasts

## API access

Configure authentication and query arbitrary AEMET API endpoints.

### Authentication

- [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
  : Install an AEMET API key
- [`aemet_detect_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_detect_api_key.md)
  [`aemet_show_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_detect_api_key.md)
  : Check for an AEMET API key

### Low-level requests

- [`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  : Query the AEMET API

## Visualize data

Create climatograms, warming stripes and wind roses.

### Climatograms

- [`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md)
  : Walter-Lieth climate diagram from climatological normals

- [`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md)
  : Walter-Lieth climate diagram for a time period

- [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)
  **\[experimental\]** :

  Walter-Lieth climate diagram with
  [ggplot2](https://CRAN.R-project.org/package=ggplot2)

### Warming stripes

- [`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md)
  : Climate stripes for a weather station
- [`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)
  : Plot warming stripes

### Wind roses

- [`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md)
  : Plot a wind rose
- [`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md)
  : Wind rose for a range of days
- [`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)
  : Wind rose for a range of years

## Helpers

Convert coordinates, work with calendar years and view package news.

- [`climaemet_news()`](https://ropenspain.github.io/climaemet/reference/climaemet_news.md)
  :

  Show the latest
  [climaemet](https://CRAN.R-project.org/package=climaemet) news

- [`first_day_of_year()`](https://ropenspain.github.io/climaemet/reference/day_of_year.md)
  [`last_day_of_year()`](https://ropenspain.github.io/climaemet/reference/day_of_year.md)
  : First and last day of a year

- [`dms2decdegrees()`](https://ropenspain.github.io/climaemet/reference/dms2decdegrees.md)
  [`dms2decdegrees_2()`](https://ropenspain.github.io/climaemet/reference/dms2decdegrees.md)
  : Convert DMS coordinates to decimal degrees

## Datasets

Use example datasets included in the package.

- [`aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  : Municipalities of Spain
- [`climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md)
  : Climatogram data for Zaragoza Airport ("9434"), 1981-2010
- [`climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md)
  : Average annual temperatures for Zaragoza Airport ("9434"), 1950-2020
- [`climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md)
  : Wind conditions for Zaragoza Airport ("9434"), 2000-2020

## Package

- [`climaemet`](https://ropenspain.github.io/climaemet/reference/climaemet-package.md)
  [`climaemet-package`](https://ropenspain.github.io/climaemet/reference/climaemet-package.md)
  : climaemet: Tools for AEMET Climate Data
