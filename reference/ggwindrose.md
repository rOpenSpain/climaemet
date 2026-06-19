# Plot a wind rose

Plots a wind rose showing wind speed and direction with
[ggplot2](https://CRAN.R-project.org/package=ggplot2).

## Usage

``` r
ggwindrose(
  speed,
  direction,
  n_directions = 8,
  n_speeds = 5,
  speed_cuts = NA,
  col_pal = "GnBu",
  legend_title = "Wind speed (m/s)",
  calm_wind = 0,
  n_col = 1,
  facet = NULL,
  plot_title = "",
  stack_reverse = FALSE,
  ...
)
```

## Arguments

- speed:

  Numeric vector of wind speeds.

- direction:

  Numeric vector of wind directions.

- n_directions:

  Numeric value with the number of direction bins to plot (petals on the
  rose). Valid values are `4`, `8` or `16`.

- n_speeds:

  Number of equally spaced wind speed bins to plot when `speed_cuts` is
  `NA`. Defaults to `5`.

- speed_cuts:

  Numeric vector with the cut points for the wind speed intervals, or
  `NA` (default).

- col_pal:

  Character string indicating the name of the
  [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
  palette to be used for plotting.

- legend_title:

  Character string to be used for the legend title.

- calm_wind:

  Upper wind speed limit considered calm. Defaults to `0`.

- n_col:

  Number of plot columns. Defaults to `1`.

- facet:

  Character or factor vector of facets used to plot wind roses.

- plot_title:

  Character string to be used for the plot title.

- stack_reverse:

  Logical. If `TRUE`, the stack order of speed cuts is inverted. See
  **Examples**.

- ...:

  Further arguments (ignored).

## Value

A [ggplot2](https://CRAN.R-project.org/package=ggplot2) object. See
[`help("ggplot2")`](https://ggplot2.tidyverse.org/reference/ggplot2-package.html).

## API key

You need to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).
Query timeout can be controlled with `options(climaemet_timeout = 60)`
(default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
for additional arguments to pass to `ggwindrose()` and
[climaemet_9434_wind](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md)

Wind roses:
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

## Examples

``` r
library(ggplot2)

speed <- climaemet::climaemet_9434_wind$velmedia
direction <- climaemet::climaemet_9434_wind$dir

rose <- ggwindrose(
  speed = speed,
  direction = direction,
  speed_cuts = seq(0, 16, 4),
  legend_title = "Wind speed (m/s)",
  calm_wind = 0,
  n_col = 1,
  plot_title = "Zaragoza Airport"
)
rose + labs(
  subtitle = "2000-2020",
  caption = "Source: AEMET"
)


# Reverse the stack.

ggwindrose(
  speed = speed,
  direction = direction,
  speed_cuts = seq(0, 16, 4),
  legend_title = "Wind speed (m/s)",
  calm_wind = 0,
  n_col = 1,
  plot_title = "Zaragoza Airport",
  stack_reverse = TRUE
) +
  labs(
    subtitle = "2000-2020",
    caption = "Source: AEMET"
  )

```
