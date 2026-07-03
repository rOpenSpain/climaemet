# Wind conditions for Zaragoza Airport ("9434"), 2000–2020

Daily observations of wind speed and direction for Zaragoza Airport
(2000–2020). This is an example dataset.

## Format

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
columns:

- fecha:

  Date of observation.

- dir:

  Wind direction (0-360 degrees).

- velmedia:

  Average wind speed (km/h).

## Source

AEMET.

## See also

- [`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md)
  and
  [`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)
  retrieve wind observations.

- [`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md)
  creates wind rose plots.

## Examples

``` r
data(climaemet_9434_wind)
```
