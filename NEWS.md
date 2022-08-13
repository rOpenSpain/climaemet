# climaemet 1.0.2

-   Fix docs as per CRAN request

# climaemet 1.0.1

-   Add new citation.
-   Adapt some examples.
-   Remove `lubridate` dependency.
-   No more messages when loading the library.

# climaemet 1.0.0

-   package added to rOpenSpain project: repo transferred to
    <https://github.com/rOpenSpain/climaemet>

## Breaking changes:

-   `apikey` parameter has been deprecated on all the functions. Now the API Key
    is globally managed via an environment variable: see `aemet_api_key()`.

## Major changes

-   Results are provided on `tibble/tidyverse` format.
-   Results are parsed to the correct formats (numbers and dates when possible).
-   Spatial support: New option `return_sf` would return `sf` objects instead of
    tibbles. `sf (>= 0.9)` required, listed on 'Suggests' so it is not strictly
    required.
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
-   New example datasets: `climaemet_9434_climatogram`, `climaemet_9434_temp`,
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

-   Firts release July 2020.
