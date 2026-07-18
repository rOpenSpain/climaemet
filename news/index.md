# Changelog

## climaemet 1.6.0

CRAN release: 2026-06-03

- Documentation, user-facing messages and internal code were reviewed
  and refactored with AI assistance to improve consistency,
  maintainability, wording and **roxygen2** tag ordering.
- Tests now rely less on live AEMET OpenData API calls and cover
  additional forecast-parsing branches using local fixtures.
- Requests now use a configurable timeout via
  `options(climaemet_timeout = 60)`.
- [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
  now uses [`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html)
  for persistent API key storage. Existing users are migrated
  automatically to the new location, ensuring backward compatibility.
- [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
  has been updated to support the new API, which now returns six risk
  levels. Risk values are returned as named factors instead of numeric
  level codes.

## climaemet 1.5.1

CRAN release: 2026-03-23

- Vignettes were migrated to Quarto.

## climaemet 1.5.0

CRAN release: 2026-01-11

- Updated code for deprecations in **ggplot2** \>= 3.5.0.
- Messages, warnings and errors are now more informative thanks to
  **cli**.
- Performance improvements: **climaemet** now uses
  [`httr2::req_throttle()`](https://rdrr.io/pkg/httr2/man/req_throttle.html)
  to manage API calls. The rate is strictly limited by the AEMET
  OpenData API policy to no more than 40 connections per minute per API
  key.
- The minimum **R** version is now \>= 4.1.0.
- Documentation and tests were updated.

## climaemet 1.4.2

CRAN release: 2025-06-25

- Functions were adapted to new AEMET OpenData API response codes
  ([\#74](https://github.com/rOpenSpain/climaemet/issues/74)).
- `aemet_munic` was updated with January 2025 data.
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

- Increased the timeout limit with
  [`httr2::req_timeout()`](https://rdrr.io/pkg/httr2/man/req_timeout.html).
- Improved handling of invalid, duplicated and empty API keys.
- Added **terra** to `Suggests`.
- [`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md)
  retrieves the AEMET geographical zones used for meteorological alerts.
- [`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md)
  retrieves current meteorological alerts issued by AEMET.
- [`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md)
  retrieves forecast wildfire risk levels as a `SpatRaster`.

## climaemet 1.3.0

CRAN release: 2024-06-23

- It is possible to use several API keys to avoid API throttling. See
  [`?climaemet::aemet_api_key`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
  ([\#53](https://github.com/rOpenSpain/climaemet/issues/53)).
- Migrate from **httr** to **httr2**
  ([\#50](https://github.com/rOpenSpain/climaemet/issues/50)).
- Added the
  [`dms2decdegrees_2()`](https://ropenspain.github.io/climaemet/reference/dms2decdegrees.md)
  helper.
- Added **mapSpain** to `Suggests`.
- Progress bars are used in downloads thanks to **cli**. Most functions
  gain a new `progress = TRUE` argument.
- Updated `aemet_munic` with January 2024 data.
- [`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)
  and
  [`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md)
  are new functions for beaches
  ([\#54](https://github.com/rOpenSpain/climaemet/issues/54)).

## climaemet 1.2.1

CRAN release: 2024-01-30

- `aemet_monthly_period(extract_metadata = TRUE)` now honors the `start`
  and `end` arguments.
- Documentation was updated.

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
- Documentation was improved.

## climaemet 1.1.0

CRAN release: 2023-02-16

- Added **lubridate** and **scales** to `Suggests`.
- Added the `aemet_munic` dataset.
- Added
  [`vignette("extending-climaemet", package = "climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md).
- Fixed an error in
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)
  ([\#35](https://github.com/rOpenSpain/climaemet/issues/35)).
- Improved
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

- Documentation was updated as requested by CRAN.

## climaemet 1.0.1

CRAN release: 2022-02-24

- Added a new citation.
- Updated examples.
- **climaemet** no longer emits messages when loaded.
- Removed the **lubridate** dependency.

## climaemet 1.0.0

CRAN release: 2021-09-16

- **climaemet** joined the **rOpenSpain** project and its repository
  moved to <https://github.com/rOpenSpain/climaemet>.

### Breaking changes

- The `apikey` argument has been deprecated in all functions. The API
  key is now globally managed via an environment variable. See
  [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

### Major changes

- API functions gain new arguments, such as `verbose`, to check results.
- Tabular results are now returned as **tibble** objects.
- Results are parsed into the correct formats when possible, including
  numbers and dates.
- Spatial support: the `return_sf` argument returns **sf** objects
  instead of **tibble** objects. **sf** (\>= 0.9) is listed in
  `Suggests`, so it is not strictly required.

### Enhancements

- New example datasets: `climaemet_9434_climatogram`,
  `climaemet_9434_temp` and `climaemet_9434_wind`.
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

- Code was optimized.
- Dependencies were reviewed.
- Palettes are now generated with `base::hcl.colors()` (base **R**).

## climaemet 0.2.0

CRAN release: 2020-07-17

- [`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md)
  is a new function for plotting a Walter-Lieth climate diagram from
  climatological normal values.
- [`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md)
  is a new function for plotting a Walter-Lieth climate diagram for a
  specified period.
- [`ggstripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md)
  has been renamed to
  [`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md).
- [`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md)
  is a new function for plotting wind roses.
- [`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md)
  is a new function for plotting a wind rose for a weather station over
  a range of days.
- [`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)
  is a new function for plotting a wind rose for a weather station over
  a specified period.

## climaemet 0.1.0

CRAN release: 2020-07-07

- First release, July 2020.
