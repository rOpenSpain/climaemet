# Changelog

## climaemet (development version)

- Documentation and user-facing messages were reviewed with AI
  assistance to improve consistency, wording and roxygen2 tag order.
- Tests now rely less on live AEMET API calls and cover additional
  forecast parsing branches with local fixtures.
- Internal code was comprehensively refactored with AI assistance to
  improve maintainability and consistency.
- Requests now use a configurable timeout via
  `options(climaemet_timeout = 60)`.
- [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
  has been adapted to the new API, returning 6 risk levels. The values
  are now displayed as named factors instead of level numbers.

## climaemet 1.5.1

CRAN release: 2026-03-23

- Migrate vignettes to Quarto.

## climaemet 1.5.0

CRAN release: 2026-01-11

- Adapt **ggplot2** \>= 3.5.0 deprecations.
- Messages, warnings and errors are now more informative thanks to
  **cli**.
- Performance improvements: **climaemet** now uses
  [`httr2::req_throttle()`](https://httr2.r-lib.org/reference/req_throttle.html)
  to manage API calls. The rate is strictly limited to the AEMET API
  policy: no more than 40 connections per minute per API key.
- The minimum **R** version is now \>= 4.1.0.
- Update docs and tests.

## climaemet 1.4.2

CRAN release: 2025-06-25

- Adapt functions to new response codes
  ([\#74](https://github.com/rOpenSpain/climaemet/issues/74)).
- [`?aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  updated to January 2025.
- [`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md)
  now uses
  [`ggplot2::coord_radial()`](https://ggplot2.tidyverse.org/reference/coord_radial.html)
  instead of
  [`ggplot2::coord_polar()`](https://ggplot2.tidyverse.org/reference/coord_radial.html)
  and gains the `stack_reverse` argument to change the order of the
  stacks on each petal (see
  [\#72](https://github.com/rOpenSpain/climaemet/issues/72)).
- The minimum required **ggplot2** version is now \>= 3.5.0 because
  [`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md)
  now uses
  [`ggplot2::coord_radial()`](https://ggplot2.tidyverse.org/reference/coord_radial.html).

## climaemet 1.4.1

CRAN release: 2025-03-25

- The API key with the highest remaining quota is now selected when
  performing a call. In prior versions, the API key was chosen randomly.
  This is expected to reduce API throttling.
- Use **CRAN** DOI:
  [10.32614/CRAN.package.climaemet](https://doi.org/10.32614/CRAN.package.climaemet).
- [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
  now uses
  [`terra::combineLevels()`](https://rspatial.github.io/terra/reference/factors.html)
  (**terra** \>= 1.8-10).

## climaemet 1.4.0

CRAN release: 2024-08-28

- Increase timeout limit with
  [`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html).
- Manage invalid, duplicated and empty API keys more clearly.
- New package added to `Suggests`: **terra**.
- [`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md)
  obtains the zoning defined by AEMET for the alerts.
- [`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md)
  gets current meteorological alerts issued by AEMET.
- [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
  gets a `SpatRaster` with the forecast wildfire risk level.

## climaemet 1.3.0

CRAN release: 2024-06-23

- It is possible to use several API keys to avoid API throttling. See
  [`?climaemet::aemet_api_key`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
  ([\#53](https://github.com/rOpenSpain/climaemet/issues/53)).
- Migrate from **httr** to **httr2**
  ([\#50](https://github.com/rOpenSpain/climaemet/issues/50)).
- New helper function
  [`dms2decdegrees_2()`](https://ropenspain.github.io/climaemet/reference/dms2decdegrees.md).
- New package in `Suggests`: **mapSpain**.
- Progress bars are used in downloads thanks to **cli**. Most functions
  gain a new `progress = TRUE` argument.
- Update
  [`?aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  with January 2024 data.
- [`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)
  and
  [`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md)
  are new functions for beaches
  ([\#54](https://github.com/rOpenSpain/climaemet/issues/54)).

## climaemet 1.2.1

CRAN release: 2024-01-30

- `aemet_monthly_period(extract_metadata = TRUE)` now honors the `start`
  and `end` arguments.
- Update docs.

## climaemet 1.2.0

CRAN release: 2023-08-30

- Metadata can now be extracted from each API call using the
  `extract_metadata = TRUE` argument
  ([\#40](https://github.com/rOpenSpain/climaemet/issues/40)).
- The
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)
  result is cached temporarily in
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html), avoiding
  unnecessary API calls.
- The API call system has improved to avoid API throttling.

## climaemet 1.1.1

CRAN release: 2023-05-25

- Fix an error in the conversion to **sf** objects.
- Improve documentation.

## climaemet 1.1.0

CRAN release: 2023-02-16

- Add **lubridate** to `Suggests`.
- Add **scales** to `Suggests`.
- Add
  [`?aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md)
  dataset.
- Add new vignette:
  [`vignette("extending-climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md).
- Fix error on
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)
  ([\#35](https://github.com/rOpenSpain/climaemet/issues/35)).
- Improve
  [`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  and
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  to support more endpoints.
- [`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
  [`aemet_forecast_tidy()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md),
  [`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)
  and
  [`aemet_forecast_vars_available()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_utils.md)
  are new forecast functions.

## climaemet 1.0.2

CRAN release: 2022-08-14

- Fix docs as requested by **CRAN**.

## climaemet 1.0.1

CRAN release: 2022-02-24

- Add new citation.
- Adapt some examples.
- No more messages when loading the library.
- Remove **lubridate** dependency.

## climaemet 1.0.0

CRAN release: 2021-09-16

- Package added to **rOpenSpain** project: repo transferred to
  <https://github.com/rOpenSpain/climaemet>.

### Breaking changes

- The `apikey` argument has been deprecated in all functions. The API
  key is now globally managed via an environment variable. See
  [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

### Major changes

- API functions gain new arguments, such as `verbose`, to check results.
- Results are now provided in **tibble** format.
- Results are parsed into the correct formats when possible, including
  numbers and dates.
- Spatial support: New option `return_sf` returns **sf** objects instead
  of **tibble** objects. **sf** (\>= 0.9) is listed in `Suggests`, so it
  is not strictly required.

### Enhancements

- New example datasets:
  [`?climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
  [`?climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md)
  and
  [`?climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md).
- Plot functions gain new arguments (`verbose` and `...`). Colors can
  now be passed to the plotting functions.
- [`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)
  is now vectorized and can also retrieve all stations with
  `station = "all"`.
- [`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md)
  is now vectorized and can also retrieve all stations with
  `station = "all"`.
- [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  is a new function.
- [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)
  is a new function. It is now the default for `climatogram_*` functions
  (experimental). Old behavior can be reproduced with option
  `ggplot2 = FALSE`.

### Internal changes

- Code optimization.
- Dependencies have been reviewed.
- Palettes are now generated with `base::hcl.colors()` (base **R**).

## climaemet 0.2.0

CRAN release: 2020-07-17

- [`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md)
  is a new function to plot a Walter & Lieth climatic diagram from
  normal climatology values.
- [`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md)
  is a new function to plot a Walter & Lieth climatic diagram for a
  specified time period.
- [`ggstripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md)
  has been renamed to
  [`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md).
- [`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md)
  is a new function to plot a windrose diagram.
- [`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md)
  is a new function to plot a windrose (speed/direction) diagram of a
  station over days.
- [`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)
  is a new function to plot a windrose (speed/direction) diagram of a
  station over a time period.

## climaemet 0.1.0

CRAN release: 2020-07-07

- First release, July 2020.
