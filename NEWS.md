# climaemet 1.3.0

-   Migrate from **httr** to **httr2** (#50).
-   New functions for beaches: `aemet_forecast_beaches()` and `aemet_beaches()`
    (#54).
-   Use progress bars in downloads thanks to **cli**. New argument
    `progress = TRUE` in most functions.
-   It is possible to use several API keys to avoid API throttling, see
    `?climaemet::aemet_api_key` (#53).
-   New helper function `dms2decdegrees_2()`.
-   Update `aemet_munic` with January 2024 data.
-   New package in 'Suggests': **mapSpain**.

# climaemet 1.2.1

-   On `aemet_monthly_period(extract_metadata = TRUE)` honor the `start` and
    `end` parameters.
-   Update docs.

# climaemet 1.2.0

-   Now it is possible to extract metadata from each API call using the
    parameter `extract_metadata = TRUE` (#40).
-   Improve the API call system to avoid API throttling.
-   `aemet_stations()` result is cached temporarily on `tempdir()`, avoiding
    unneeded API calls.

# climaemet 1.1.1

-   Fix an error on the conversion to **sf** objects.
-   Documentation improvements.

# climaemet 1.1.0

-   Add **lubridate** to "Suggest".
-   Add `aemet_munic` dataset.
-   Add `scales` to Suggests.
-   Add forecast functions:
    -   `aemet_forecast_daily()`
    -   `aemet_forecast_tidy()`
    -   `aemet_forecast_hourly()`
    -   `aemet_forecast_vars_available()`
-   Improve `get_data_aemet()`/`get_metadata_aemet()` to support more endpoints.
-   Add new vignette: `vignette("extending-climaemet")`.
-   Fix error on `ggclimat_walter_lieth()` (#35).

# climaemet 1.0.2

-   Fix docs as per **CRAN** request

# climaemet 1.0.1

-   Add new citation.
-   Adapt some examples.
-   Remove **lubridate** dependency.
-   No more messages when loading the library.

# climaemet 1.0.0

-   package added to **rOpenSpain** project: repo transferred to
    <https://github.com/rOpenSpain/climaemet>

## Breaking changes:

-   `apikey` parameter has been deprecated on all the functions. Now the API Key
    is globally managed via an environment variable: see `aemet_api_key()`.

## Major changes

-   Results are provided on `tibble` format.
-   Results are parsed to the correct formats (numbers and dates when possible).
-   Spatial support: New option `return_sf` would return `sf` objects instead of
    `tibble` objects. **sf**`(>= 0.9)` required, listed on 'Suggests' so it is
    not strictly required.
-   API functions gain new parameters, as `verbose`, to check results.

## Enhancements

-   `aemet_last_obs()` now is vectorized and it can also retrieve all the
    stations at a glance with `station = "all"`
-   `aemet_last_obs()` now is vectorized and it can also retrieve all the
    stations at a glance with `station = "all"`
-   `aemet_daily_clim()` now is vectorized and it can also retrieve all the
    stations at a glance with `station = "all"`
-   New function `get_metadata_aemet()`.
-   New function `ggclimat_walter_lieth()`. This function is now the default for
    `climatogram_*` functions (experimental). Old behavior can be reproduced
    with options `ggplot2 = FALSE`.
-   Plot functions gains new parameters (`verbose` and `...`). Now it is
    possible to pass colors to the plotting functions.
-   New example data sets: `climaemet_9434_climatogram`, `climaemet_9434_temp`,
    `climaemet_9434_wind`.

## Internal changes

-   Code optimization.
-   Dependencies have been reviewed.
-   Now palettes are generated with `hcl.colors()` (base **R**)

# climaemet 0.2.0

-   rename `ggstripes_station()` to `climatestripes_station()`.
-   `climatogram_normal()`. New function to plot a Walter & Lieth climatic
    diagram from normal climatology values.
-   `climatogram_period()`. New function to plot a Walter & Lieth climatic
    diagram for a specified time period.
-   `ggwindrose()`. New function to plot windrose diagram.
-   `windrose_days()`. New function to plot a windrose (speed/direction) diagram
    of a station over a days period.
-   `windrose_period()`. New function to plot a windrose (speed/direction)
    diagram of a station over a time period.

# climaemet 0.1.0

-   First release July 2020.
