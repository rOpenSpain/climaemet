# Warming stripes graph

Plot different "climate stripes" or "warming stripes" using
[ggplot2](https://CRAN.R-project.org/package=ggplot2). This graphics are
visual representations of the change in temperature as measured in each
location over the past 70-100+ years. Each stripe represents the
temperature in that station averaged over a year.

## Usage

``` r
ggstripes(
  data,
  plot_type = "stripes",
  plot_title = "",
  n_temp = 11,
  col_pal = "RdBu",
  ...
)
```

## Arguments

- data:

  a data.frame with date(`year`) and temperature(`temp`) variables.

- plot_type:

  plot type (with labels, background, stripes with line trend and
  animation). Accepted values are `"background"`, `"stripes"`, `"trend"`
  or `"animation"`.

- plot_title:

  character string to be used for the graph title.

- n_temp:

  Numeric value as the number of colors of the palette. (default `11`).

- col_pal:

  Character string indicating the name of the
  [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
  palette to be used for plotting.

- ...:

  further arguments passed to
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html).

## Value

A [ggplot2](https://CRAN.R-project.org/package=ggplot2) object

## Note

"Warming stripes" charts are a conceptual idea of Professor Ed Hawkins
(University of Reading) and are specifically designed to be as simple as
possible and alert about risks of climate change. For more details see
[ShowYourStripes](https://showyourstripes.info/).

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md),
[`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
for more possible arguments to pass to `ggstripes`.

Other aemet_plots:
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

Other stripes:
[`climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md),
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md)

## Examples

``` r
# \donttest{
library(ggplot2)

data <- climaemet::climaemet_9434_temp

ggstripes(data, plot_title = "Zaragoza Airport") +
  labs(subtitle = "(1950-2020)")
#> ℹ Climate stripes plotting ...
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_tile()`).


ggstripes(data, plot_title = "Zaragoza Airport", plot_type = "trend") +
  labs(subtitle = "(1950-2020)")
#> ℹ Climate stripes with temperature line trend plotting ...
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_tile()`).

# }
```
