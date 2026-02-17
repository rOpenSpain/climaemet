# Average annual temperatures for Zaragoza Airport ("9434") period 1950-2020

Yearly observations of average temperature for Zaragoza Airport
(1950-2020). This is an example dataset.

## Format

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
with columns:

- year:

  Year of reference.

- indicativo:

  Identifier of the station.

- temp:

  Average temperature (Celsius).

## Source

AEMET.

## See also

Other dataset:
[`aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md),
[`climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
[`climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md)

Other stripes:
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)

## Examples

``` r
data(climaemet_9434_temp)
```
