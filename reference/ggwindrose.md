# Windrose (speed/direction) diagram

Plot a windrose showing the wind speed and direction using
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

  Numeric value as the number of direction bins to plot (petals on the
  rose). Valid values are `4`, `8` or `16`.

- n_speeds:

  Numeric value as the number of equally spaced wind speed bins to plot.
  This is used if `speed_cuts` is `NA` (default `5`).

- speed_cuts:

  Numeric vector containing the cut points for the wind speed intervals,
  or `NA` (default).

- col_pal:

  Character string indicating the name of the
  [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
  palette to be used for plotting.

- legend_title:

  Character string to be used for the legend title.

- calm_wind:

  Numeric value as the upper limit for wind speed that is considered
  calm (default `0`).

- n_col:

  The number of columns of plots (default 1).

- facet:

  Character or factor vector of the facets used to plot the various
  windroses.

- plot_title:

  Character string to be used for the plot title.

- stack_reverse:

  Logical. If `TRUE` the stack order of the speed cuts would be
  inverted. See **Examples**.

- ...:

  further arguments (ignored).

## Value

A [ggplot2](https://CRAN.R-project.org/package=ggplot2) object`.`

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
for more possible arguments to pass to `ggwindrose`.

Other aemet_plots:
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md),
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

Other wind:
[`climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md),
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


# Reverse stack

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
