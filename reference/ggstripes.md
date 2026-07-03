# Plot warming stripes

Plots warming stripes with
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

  A data frame with date (`year`) and temperature (`temp`) variables.

- plot_type:

  A character string specifying the plot type: `"background"`,
  `"stripes"`, `"trend"` or `"animation"`.

- plot_title:

  A character string for the plot title.

- n_temp:

  The number of colors in the palette. Defaults to `11`.

- col_pal:

  A character string specifying an
  [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
  palette.

- ...:

  Further arguments passed to
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html).

## Value

A
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html)
object.

## Note

Professor Ed Hawkins of the University of Reading developed the "warming
stripes" concept to communicate climate change risks as simply as
possible. For more details, see
[ShowYourStripes](https://showyourstripes.info/).

## See also

[`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
for additional arguments to `ggstripes()` and
[climaemet_9434_temp](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md).

Warming stripes:
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md)

## Examples

``` r
# \donttest{
library(ggplot2)

data <- climaemet::climaemet_9434_temp

ggstripes(data, plot_title = "Zaragoza Airport") +
  labs(subtitle = "(1950-2020)")
#> ℹ Plotting warming stripes.
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_tile()`).


ggstripes(data, plot_title = "Zaragoza Airport", plot_type = "trend") +
  labs(subtitle = "(1950-2020)")
#> ℹ Plotting warming stripes with a temperature trend line.
#> Warning: Removed 2 rows containing missing values or values outside the scale range
#> (`geom_tile()`).

# }
```
