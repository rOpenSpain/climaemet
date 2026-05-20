# climaemet 1.5.1

- Migrate vignettes to Quarto.

# climaemet 1.5.0

- Adapt **ggplot2** \>= 3.5.0 deprecations.
- Messages, warnings and errors are now more informative thanks to **cli**.
- Performance improvements: **climaemet** now uses `httr2::req_throttle()` to manage API calls. The rate is strictly limited to the AEMET API policy: no more than 40 connections per minute per API key.
- The minimum **R** version is now \>= 4.1.0.
- Update docs and tests.

# climaemet 1.4.2

- Adapt functions to new response codes (#74).
- `?aemet_munic` updated to January 2025.
- `ggwindrose()` now uses `ggplot2::coord_radial()` instead of `ggplot2::coord_polar()` and gains the `stack_reverse` argument to change the order of the stacks on each petal (see #72).
- The minimum required **ggplot2** version is now \>= 3.5.0 because `ggwindrose()` now uses `ggplot2::coord_radial()`.

# climaemet 1.4.1

- The API key with the highest remaining quota is now selected when performing a call. In prior versions, the API key was chosen randomly. This is expected to reduce API throttling.
- Use **CRAN** DOI: [10.32614/CRAN.package.climaemet](https://doi.org/10.32614/CRAN.package.climaemet).
- `aemet_forecast_fires()` now uses `terra::combineLevels()` (**terra** \>= 1.8-10).

# climaemet 1.4.0

- Increase timeout limit with `httr2::req_timeout()`.
- Manage invalid, duplicated and empty API keys more clearly.
- New package added to `Suggests`: **terra**.
- `aemet_alert_zones()` obtains the zoning defined by AEMET for the alerts.
- `aemet_alerts()` gets current meteorological alerts issued by AEMET.
- `aemet_forecast_fires()` gets a `SpatRaster` with the forecast wildfire risk level.

# climaemet 1.3.0

- It is possible to use several API keys to avoid API throttling. See `?climaemet::aemet_api_key` (#53).
- Migrate from **httr** to **httr2** (#50).
- New helper function `dms2decdegrees_2()`.
- New package in `Suggests`: **mapSpain**.
- Progress bars are used in downloads thanks to **cli**. Most functions gain a new `progress = TRUE` argument.
- Update `?aemet_munic` with January 2024 data.
- `aemet_beaches()` and `aemet_forecast_beaches()` are new functions for beaches (#54).

# climaemet 1.2.1

- `aemet_monthly_period(extract_metadata = TRUE)` now honors the `start` and `end` arguments.
- Update docs.

# climaemet 1.2.0

- Metadata can now be extracted from each API call using the `extract_metadata = TRUE` argument (#40).
- The `aemet_stations()` result is cached temporarily in `tempdir()`, avoiding unnecessary API calls.
- The API call system has improved to avoid API throttling.

# climaemet 1.1.1

- Fix an error in the conversion to **sf** objects.
- Improve documentation.

# climaemet 1.1.0

- Add **lubridate** to `Suggests`.
- Add **scales** to `Suggests`.
- Add `?aemet_munic` dataset.
- Add new vignette: `vignette("extending-climaemet")`.
- Fix error on `ggclimat_walter_lieth()` (#35).
- Improve `get_data_aemet()` and `get_metadata_aemet()` to support more endpoints.
- `aemet_forecast_daily()`, `aemet_forecast_tidy()`, `aemet_forecast_hourly()` and `aemet_forecast_vars_available()` are new forecast functions.

# climaemet 1.0.2

- Fix docs as requested by **CRAN**.

# climaemet 1.0.1

- Add new citation.
- Adapt some examples.
- No more messages when loading the library.
- Remove **lubridate** dependency.

# climaemet 1.0.0

- Package added to **rOpenSpain** project: repo transferred to <https://github.com/rOpenSpain/climaemet>.

## Breaking changes

- The `apikey` argument has been deprecated in all functions. The API key is now globally managed via an environment variable. See `aemet_api_key()`.

## Major changes

- API functions gain new arguments, such as `verbose`, to check results.
- Results are now provided in **tibble** format.
- Results are parsed into the correct formats when possible, including numbers and dates.
- Spatial support: New option `return_sf` returns **sf** objects instead of **tibble** objects. **sf** (\>= 0.9) is listed in `Suggests`, so it is not strictly required.

## Enhancements

- New example datasets: `?climaemet_9434_climatogram`, `?climaemet_9434_temp` and `?climaemet_9434_wind`.
- Plot functions gain new arguments (`verbose` and `...`). Colors can now be passed to the plotting functions.
- `aemet_daily_clim()` is now vectorized and can also retrieve all stations with `station = "all"`.
- `aemet_last_obs()` is now vectorized and can also retrieve all stations with `station = "all"`.
- `get_metadata_aemet()` is a new function.
- `ggclimat_walter_lieth()` is a new function. It is now the default for `climatogram_*` functions (experimental). Old behavior can be reproduced with option `ggplot2 = FALSE`.

## Internal changes

- Code optimization.
- Dependencies have been reviewed.
- Palettes are now generated with `base::hcl.colors()` (base **R**).

# climaemet 0.2.0

- `climatogram_normal()` is a new function to plot a Walter & Lieth climatic diagram from normal climatology values.
- `climatogram_period()` is a new function to plot a Walter & Lieth climatic diagram for a specified time period.
- `ggstripes_station()` has been renamed to `climatestripes_station()`.
- `ggwindrose()` is a new function to plot a windrose diagram.
- `windrose_days()` is a new function to plot a windrose (speed/direction) diagram of a station over days.
- `windrose_period()` is a new function to plot a windrose (speed/direction) diagram of a station over a time period.

# climaemet 0.1.0

- First release, July 2020.
