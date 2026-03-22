# Windrose (speed/direction) diagram of a station over a days period

Plot a windrose showing the wind speed and direction for a station over
a days period.

## Usage

``` r
windrose_days(
  station,
  start = "2000-12-01",
  end = "2000-12-31",
  n_directions = 8,
  n_speeds = 5,
  speed_cuts = NA,
  col_pal = "GnBu",
  calm_wind = 0,
  legend_title = "Wind Speed (m/s)",
  verbose = FALSE
)
```

## Arguments

- station:

  Character string with station identifier code(s) (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md))
  or "all" for all the stations.

- start:

  Character string as start date (format: `"YYYY-MM-DD"`).

- end:

  Character string as end date (format: `"YYYY-MM-DD"`).

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

- calm_wind:

  Numeric value as the upper limit for wind speed that is considered
  calm (default `0`).

- legend_title:

  Character string to be used for the legend title.

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

## Value

A [ggplot2](https://CRAN.R-project.org/package=ggplot2) object.

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)

Other aemet_plots:
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md),
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

Other wind:
[`climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md),
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

## Examples

``` r
windrose_days("9434",
  start = "2000-12-01",
  end = "2000-12-31",
  speed_cuts = 4
)
#> ℹ Data download may take a few seconds ... please wait.
```
