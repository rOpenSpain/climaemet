# Wind conditions for Zaragoza Airport ("9434"), 2000-2020

Daily observations of wind speed and direction for Zaragoza Airport
(2000-2020). This is an example dataset.

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

Included datasets:
[`aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md),
[`climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
[`climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md)

Wind functions:
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

## Examples

``` r
data(climaemet_9434_wind)
```
