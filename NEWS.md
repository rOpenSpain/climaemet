# climaemet 1.6.0

- Documentation, user-facing messages and internal code were reviewed and
  refactored with AI assistance to improve consistency, maintainability, wording
  and **roxygen2** tag ordering.
- Tests now rely less on live AEMET OpenData API calls and cover additional
  forecast-parsing branches using local fixtures.
- Requests now use a configurable timeout via `options(climaemet_timeout = 60)`.
- `aemet_api_key()` now uses `tools::R_user_dir()` for persistent API key
  storage. Existing users are migrated automatically to the new location,
  ensuring backward compatibility.
- `aemet_forecast_fires()` has been updated to support the new API, which now
  returns six risk levels. Risk values are returned as named factors instead of
  numeric level codes.

# climaemet 1.5.1

- Vignettes were migrated to Quarto.

# climaemet 1.5.0

- Updated code for deprecations in **ggplot2** \>= 3.5.0.
- Messages, warnings and errors are now more informative thanks to **cli**.
- Performance improvements: **climaemet** now uses `httr2::req_throttle()` to
  manage API calls. The rate is strictly limited by the AEMET OpenData API
  policy to no more than 40 connections per minute per API key.
- The minimum **R** version is now \>= 4.1.0.
- Documentation and tests were updated.

# climaemet 1.4.2

- Functions were adapted to new AEMET OpenData API response codes (#74).
- `aemet_munic` was updated with January 2025 data.
- `ggwindrose()` now uses `ggplot2::coord_radial()` instead of
  `ggplot2::coord_polar()` and gains the `stack_reverse` argument to change the
  order of the stacks on each petal (see #72).
- The minimum required **ggplot2** version is now \>= 3.5.0 because
  `ggwindrose()` now uses `ggplot2::coord_radial()`.

# climaemet 1.4.1

- The API key with the highest remaining quota is now selected when performing a
  call. In prior versions, the API key was chosen randomly. This is expected to
  reduce API throttling.
- Use **CRAN** DOI:
  [10.32614/CRAN.package.climaemet](https://doi.org/10.32614/CRAN.package.climaemet).
- `aemet_forecast_fires()` now uses `terra::combineLevels()` (**terra** \>=
  1.8-10).

# climaemet 1.4.0

- Increased the timeout limit with `httr2::req_timeout()`.
- Improved handling of invalid, duplicated and empty API keys.
- Added **terra** to `Suggests`.
- `aemet_alert_zones()` retrieves the AEMET geographical zones used for
  meteorological alerts.
- `aemet_alerts()` retrieves current meteorological alerts issued by AEMET.
- `aemet_forecast_fires()` retrieves forecast wildfire risk levels as a
  `SpatRaster`.

# climaemet 1.3.0

- It is possible to use several API keys to avoid API throttling. See
  `?climaemet::aemet_api_key` (#53).
- Migrate from **httr** to **httr2** (#50).
- Added the `dms2decdegrees_2()` helper.
- Added **mapSpain** to `Suggests`.
- Progress bars are used in downloads thanks to **cli**. Most functions gain a
  new `progress = TRUE` argument.
- Updated `aemet_munic` with January 2024 data.
- `aemet_beaches()` and `aemet_forecast_beaches()` are new functions for beaches
  (#54).

# climaemet 1.2.1

- `aemet_monthly_period(extract_metadata = TRUE)` now honors the `start` and
  `end` arguments.
- Documentation was updated.

# climaemet 1.2.0

- Metadata can now be extracted from each API call using the
  `extract_metadata = TRUE` argument (#40).
- The `aemet_stations()` result is cached temporarily in `tempdir()`, avoiding
  unnecessary API calls.
- The API call system has improved to avoid API throttling.

# climaemet 1.1.1

- Fix an error in the conversion to **sf** objects.
- Documentation was improved.

# climaemet 1.1.0

- Added **lubridate** and **scales** to `Suggests`.
- Added the `aemet_munic` dataset.
- Added `vignette("extending-climaemet", package = "climaemet")`.
- Fixed an error in `ggclimat_walter_lieth()` (#35).
- Improved `get_data_aemet()` and `get_metadata_aemet()` to support more
  endpoints.
- `aemet_forecast_daily()`, `aemet_forecast_tidy()`, `aemet_forecast_hourly()`
  and `aemet_forecast_vars_available()` are new forecast functions.

# climaemet 1.0.2

- Documentation was updated as requested by CRAN.

# climaemet 1.0.1

- Added a new citation.
- Updated examples.
- **climaemet** no longer emits messages when loaded.
- Removed the **lubridate** dependency.

# climaemet 1.0.0

- **climaemet** joined the **rOpenSpain** project and its repository moved to
  <https://github.com/rOpenSpain/climaemet>.

## Breaking changes

- The `apikey` argument has been deprecated in all functions. The API key is now
  globally managed via an environment variable. See `aemet_api_key()`.

## Major changes

- API functions gain new arguments, such as `verbose`, to check results.
- Tabular results are now returned as **tibble** objects.
- Results are parsed into the correct formats when possible, including numbers
  and dates.
- Spatial support: the `return_sf` argument returns **sf** objects instead of
  **tibble** objects. **sf** (\>= 0.9) is listed in `Suggests`, so it is not
  strictly required.

## Enhancements

- New example datasets: `climaemet_9434_climatogram`, `climaemet_9434_temp` and
  `climaemet_9434_wind`.
- Plot functions gain new arguments (`verbose` and `...`). Colors can now be
  passed to the plotting functions.
- `aemet_daily_clim()` is now vectorized and can also retrieve all stations with
  `station = "all"`.
- `aemet_last_obs()` is now vectorized and can also retrieve all stations with
  `station = "all"`.
- `get_metadata_aemet()` is a new function.
- `ggclimat_walter_lieth()` is a new function. It is now the default for
  `climatogram_*` functions (experimental). Old behavior can be reproduced with
  option `ggplot2 = FALSE`.

## Internal changes

- Code was optimized.
- Dependencies were reviewed.
- Palettes are now generated with `base::hcl.colors()` (base **R**).

# climaemet 0.2.0

- `climatogram_normal()` is a new function for plotting a Walter-Lieth climate
  diagram from climatological normal values.
- `climatogram_period()` is a new function for plotting a Walter-Lieth climate
  diagram for a specified period.
- `ggstripes_station()` has been renamed to `climatestripes_station()`.
- `ggwindrose()` is a new function for plotting wind roses.
- `windrose_days()` is a new function for plotting a wind rose for a weather
  station over a range of days.
- `windrose_period()` is a new function for plotting a wind rose for a weather
  station over a specified period.

# climaemet 0.1.0

- First release, July 2020.
