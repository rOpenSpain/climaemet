# Wind conditions for Zaragoza Airport ("9434") period 2000-2020

Daily observations of wind speed and directions for Zaragoza Airport
(2000-2020). This is an example dataset.

## Format

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
with columns:

- fecha:

  Date of observation.

- dir:

  Wind directions (0-360).

- velmedia:

  Average wind speed (km/h)

## Source

AEMET.

## See also

Other dataset:
[`aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md),
[`climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
[`climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md)

Other wind:
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

## Examples

``` r
data(climaemet_9434_wind)
```
