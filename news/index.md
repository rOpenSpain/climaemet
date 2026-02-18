# Changelog

## climaemet (development version)

- Migrate vignettes to Quarto.

## climaemet 1.5.0

- Performance improvements: now **climaemet** uses
  [`httr2::req_throttle()`](https://httr2.r-lib.org/reference/req_throttle.html)
  to manage API calls. The rate is strictly limited to AEMET API policy:
  No more than 40 connections per minute per API key.
- Update docs and tests.
- Adapt deprecations of **ggplot2** \>= 3.5.0.
- Messages, warnings and errors are now more informative thanks to
  **cli**.
- Minimal **R** version now is \>= 4.1.0.

## climaemet 1.4.2

- Improvements in
  [`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md)
  (see [\#72](https://github.com/rOpenSpain/climaemet/issues/72)):
  - Use
    [`ggplot2::coord_radial()`](https://ggplot2.tidyverse.org/reference/coord_radial.html)
    instead of
    [`ggplot2::coord_polar()`](https://ggplot2.tidyverse.org/reference/coord_radial.html).
  - New parameter `stack_reverse` for changing the order of the stacks
    on each petal.
- Minimal **ggplot2** version required is now \>= 3.5.0 as a consequence
  of migrating to
  [`ggplot2::coord_radial()`](https://ggplot2.tidyverse.org/reference/coord_radial.html).
- [`?aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  updated to January 2025.
- Adapt functions to new response codes
  ([\#74](https://github.com/rOpenSpain/climaemet/issues/74)).

## climaemet 1.4.1

- [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
  now uses
  [`terra::combineLevels()`](https://rspatial.github.io/terra/reference/factors.html)
  (**terra** \>= 1.8-10).
- Use **CRAN** DOI:
  [10.32614/CRAN.package.climaemet](https://doi.org/10.32614/CRAN.package.climaemet).
- Now the API key with the highest remaining quota is selected when
  performing a call (in prior versions the API key was chosen randomly).
  This is expected to delay API throttling.

## climaemet 1.4.0

- New functions:
  - [`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md)
    to get current meteorological alerts issued by AEMET.
  - Helper function
    [`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md)
    to obtain the zoning defined by AEMET for the alerts.
  - [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
    to get a `SpatRaster` with the forecast of risk level of wildfires.
- Increase timeout limit with
  [`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html).
- Better management of non-valid/duplicated/empty API keys.
- New package added to ‘Suggests’: **terra**.

## climaemet 1.3.0

- Migrate from **httr** to **httr2**
  ([\#50](https://github.com/rOpenSpain/climaemet/issues/50)).
- New functions for beaches:
  [`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md)
  and
  [`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)
  ([\#54](https://github.com/rOpenSpain/climaemet/issues/54)).
- Use progress bars in downloads thanks to **cli**. New argument
  `progress = TRUE` in most functions.
- It is possible to use several API keys to avoid API throttling, see
  [`?climaemet::aemet_api_key`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
  ([\#53](https://github.com/rOpenSpain/climaemet/issues/53)).
- New helper function
  [`dms2decdegrees_2()`](https://ropenspain.github.io/climaemet/reference/dms2decdegrees.md).
- Update
  [`?aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  with January 2024 data.
- New package in ‘Suggests’: **mapSpain**.

## climaemet 1.2.1

- On `aemet_monthly_period(extract_metadata = TRUE)` honor the `start`
  and `end` parameters.
- Update docs.

## climaemet 1.2.0

- Now it is possible to extract metadata from each API call using the
  parameter `extract_metadata = TRUE`
  ([\#40](https://github.com/rOpenSpain/climaemet/issues/40)).
- Improve the API call system to avoid API throttling.
- [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)
  result is cached temporarily on
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html), avoiding unneeded
  API calls.

## climaemet 1.1.1

- Fix an error on the conversion to **sf** objects.
- Documentation improvements.

## climaemet 1.1.0

- Add **lubridate** to “Suggests”.
- Add
  [`?aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  dataset.
- Add **scales** to Suggests.
- Add forecast functions:
  - [`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  - [`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)
  - [`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  - [`aemet_forecast_vars_available()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)
- Improve
  [`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)/[`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  to support more endpoints.
- Add new vignette:
  [`vignette("extending-climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md).
- Fix error on
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)
  ([\#35](https://github.com/rOpenSpain/climaemet/issues/35)).

## climaemet 1.0.2

- Fix docs as per **CRAN** request.

## climaemet 1.0.1

- Add new citation.
- Adapt some examples.
- Remove **lubridate** dependency.
- No more messages when loading the library.

## climaemet 1.0.0

- Package added to **rOpenSpain** project: repo transferred to
  <https://github.com/rOpenSpain/climaemet>

### Breaking changes:

- `apikey` parameter has been deprecated on all functions. Now the API
  key is globally managed via an environment variable: see
  [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

### Major changes

- Results are provided in tibble format.
- Results are parsed to the correct formats (numbers and dates when
  possible).
- Spatial support: New option `return_sf` returns `sf` objects instead
  of tibble objects. **sf** (\>= 0.9) required, listed in ‘Suggests’ so
  it is not strictly required.
- API functions gain new parameters, such as `verbose`, to check
  results.

### Enhancements

- [`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md)
  is now vectorized and can also retrieve all stations at a glance with
  `station = "all"`
- [`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)
  is now vectorized and can also retrieve all stations at a glance with
  `station = "all"`
- New function
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).
- New function
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md).
  This function is now the default for `climatogram_*` functions
  (experimental). Old behavior can be reproduced with option
  `ggplot2 = FALSE`.
- Plot functions gain new parameters (`verbose` and `...`). Now it is
  possible to pass colors to the plotting functions.
- New example datasets:
  [`?climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
  [`?climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md),
  [`?climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md).

### Internal changes

- Code optimization.
- Dependencies have been reviewed.
- Now palettes are generated with `base::hcl.colors()` (base **R**).

## climaemet 0.2.0

- Rename
  [`ggstripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md)
  to
  [`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md).
- [`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md).
  New function to plot a Walter & Lieth climatic diagram from normal
  climatology values.
- [`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md).
  New function to plot a Walter & Lieth climatic diagram for a specified
  time period.
- [`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md).
  New function to plot windrose diagram.
- [`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md).
  New function to plot a windrose (speed/direction) diagram of a station
  over days.
- [`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md).
  New function to plot a windrose (speed/direction) diagram of a station
  over a time period.

## climaemet 0.1.0

- First release July 2020.
