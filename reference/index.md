# Package index

## Get data

Query AEMET API endpoints.

- [`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md)
  : AEMET alert zones
- [`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md)
  **\[experimental\]** : AEMET meteorological warnings
- [`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)
  : AEMET beaches
- [`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)
  [`aemet_daily_period()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)
  [`aemet_daily_period_all()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)
  : Daily/annual climatology values
- [`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md)
  : Extreme values for a station
- [`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  [`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  : Forecast database by municipality
- [`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md)
  : Forecast database for beaches
- [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
  : AEMET fires forecast
- [`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md)
  : Last observation values for a station
- [`aemet_monthly_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md)
  [`aemet_monthly_period()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md)
  [`aemet_monthly_period_all()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md)
  : Monthly/annual climatology
- [`aemet_normal_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)
  [`aemet_normal_clim_all()`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)
  : Normal climatology values
- [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)
  : AEMET stations

## Forecasts

Retrieve forecast data.

- [`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  [`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  : Forecast database by municipality
- [`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md)
  : Forecast database for beaches
- [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
  : AEMET fires forecast
- [`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)
  [`aemet_forecast_vars_available()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)
  **\[experimental\]** : Helper functions for extracting forecasts

## Authentication

Manage AEMET API keys.

- [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
  : Install an AEMET API key
- [`aemet_detect_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_detect_api_key.md)
  [`aemet_show_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_detect_api_key.md)
  : Check whether an AEMET API key is present for the current session

## Plot data

Create climate-related plots.

- [`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md)
  : Station climate stripes graph

- [`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md)
  : Walter & Lieth climatic diagram from normal climatology values

- [`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md)
  : Walter & Lieth climatic diagram for a time period

- [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)
  **\[experimental\]** :

  Walter & Lieth climatic diagram with
  [ggplot2](https://CRAN.R-project.org/package=ggplot2)

- [`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)
  : Warming stripes graph

- [`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md)
  : Windrose (speed/direction) diagram

- [`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md)
  : Windrose (speed/direction) diagram of a station over a period of
  days

- [`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)
  : Windrose (speed/direction) diagram of a station over a time period

## Helpers

Internal utility and API helper functions.

- [`first_day_of_year()`](https://ropenspain.github.io/climaemet/reference/day_of_year.md)
  [`last_day_of_year()`](https://ropenspain.github.io/climaemet/reference/day_of_year.md)
  : First and last day of year

- [`dms2decdegrees()`](https://ropenspain.github.io/climaemet/reference/dms2decdegrees.md)
  [`dms2decdegrees_2()`](https://ropenspain.github.io/climaemet/reference/dms2decdegrees.md)
  :

  Converts `dms` format to decimal degrees

- [`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  : Client tool for the AEMET API

## Datasets

Example datasets included in the package.

- [`aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  : Dataset with all the municipalities of Spain
- [`climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md)
  : Climatogram data for Zaragoza Airport ("9434") period 1981-2010
- [`climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md)
  : Average annual temperatures for Zaragoza Airport ("9434") period
  1950-2020
- [`climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md)
  : Wind conditions for Zaragoza Airport ("9434") period 2000-2020

## About the package

- [`climaemet`](https://ropenspain.github.io/climaemet/reference/climaemet-package.md)
  [`climaemet-package`](https://ropenspain.github.io/climaemet/reference/climaemet-package.md)
  : climaemet: Tools for AEMET Climate Data
