# Plot warming stripes

Plots "climate stripes" or "warming stripes" with
[ggplot2](https://CRAN.R-project.org/package=ggplot2). These graphics
represent temperature change at a location over at least 70 years. Each
stripe shows the annual average temperature at that station.

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

  A [data.frame](https://rdrr.io/r/base/data.frame.html) with date
  (`year`) and temperature (`temp`) variables.

- plot_type:

  Plot type. Accepted values are `"background"`, `"stripes"`, `"trend"`
  or `"animation"`.

- plot_title:

  Character string to be used for the plot title.

- n_temp:

  Number of colors in the palette. Defaults to `11`.

- col_pal:

  Character string indicating the name of the
  [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
  palette to be used for plotting.

- ...:

  Further arguments passed to
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html).

## Value

A [ggplot2](https://CRAN.R-project.org/package=ggplot2) object. See
[`help("ggplot2")`](https://ggplot2.tidyverse.org/reference/ggplot2-package.html).

## Note

Professor Ed Hawkins of the University of Reading developed the "warming
stripes" concept to communicate climate change risks as simply as
possible. For more details, see
[ShowYourStripes](https://showyourstripes.info/).

## API key

You need to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).
Query timeout can be controlled with `options(climaemet_timeout = 60)`
(default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
for additional arguments to `ggstripes()` and
[climaemet_9434_wind](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md).

Warming stripes:
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md)

## Examples

``` r
# \donttest{
library(ggplot2)

data <- climaemet::climaemet_9434_temp

ggstripes(data, plot_title = "Zaragoza Airport") +
  labs(subtitle = "(1950-2020)")
#> ℹ Plotting climate stripes.
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_tile()`).


ggstripes(data, plot_title = "Zaragoza Airport", plot_type = "trend") +
  labs(subtitle = "(1950-2020)")
#> ℹ Plotting climate stripes with temperature line trend.
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_tile()`).

# }
```
