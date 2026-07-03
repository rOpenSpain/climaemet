# Average annual temperatures for Zaragoza Airport ("9434"), 1950–2020

Yearly observations of average temperature for Zaragoza Airport
(1950–2020). This is an example dataset.

## Format

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
columns:

- year:

  Year of reference.

- indicativo:

  Identifier of the station.

- temp:

  Average temperature (Celsius).

## Source

AEMET.

## See also

- [`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md)
  retrieves annual temperature data.

- [`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)
  creates warming stripe plots.

## Examples

``` r
data(climaemet_9434_temp)
```
