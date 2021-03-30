# climaemet (development version)

-   package added to rOpenSpain project: repo transferred to <https://github.com/rOpenSpain/climaemet>

## Major changes

-   Results are provided on `tibble/tidyverse` format.
-   Results are parsed to the correct formats (numbers and dates when possible).
-   Spatial support: New option `return_sf` would return `sf` objects intead of tibbles. `sf (>= 0.9)` required, listed on 'Suggests' so it is not strictly required.
-   API functions gain new parameters, as `verbose`, to check results.

## Enhancements

-   New API Key management. It can be set via `aemet_api_key()` or `Sys.setenv(AEMET_API_KEY = "<your api key")`
-   `aemet_last_obs()` now is vectorized and it can also retrieve all the stations at a glance with `station = "all"`
-   `aemet_last_obs()` now is vectorized and it can also retrieve all the stations at a glance with `station = "all"`
-   `aemet_daily_clim()` now is vectorized and it can also retrieve all the stations at a glance with `station = "all"`
-   New function `get_metadata_aemet()`.
-   New function `ggclimat_walter_lieth()`. This function is now the default for `climatogram_*` functions (experimental). Old behavior can be reproduced with options `ggplot2 = FALSE`.
-   Plot functions gains new parameters (`verbose` and `...`). Now it is possible to pass colors to the plotting functions.

## Internal changes

-   Code optimization.
-   Dependencies have been reviewed.
-   Now palettes are generated with `hcl.colors()` (base **R**)

# climaemet 0.2.0

-   rename `ggstripes_station()` to `climatestripes_station()`.

-   `climatogram_normal()`. New function to plot a Walter & Lieth climatic diagram from normal climatology values.

-   `climatogram_period()`. New function to plot a Walter & Lieth climatic diagram for a specified time period.

-   `ggwindrose()`. New function to plot windrose diagram.

-   `windrose_days()`. New function to plot a windrose (speed/direction) diagram of a station over a days period.

-   `windrose_period()`. New function to plot a windrose (speed/direction) diagram of a station over a time period.

# climaemet 0.1.0

-   Firts release July 2020.
