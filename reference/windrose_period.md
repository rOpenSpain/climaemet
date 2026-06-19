# Wind rose for a range of years

Plots a wind rose showing wind speed and direction at a station over a
time period.

## Usage

``` r
windrose_period(
  station,
  start = 2000,
  end = 2010,
  n_directions = 8,
  n_speeds = 5,
  speed_cuts = NA,
  col_pal = "GnBu",
  calm_wind = 0,
  legend_title = "Wind speed (m/s)",
  verbose = FALSE
)
```

## Arguments

- station:

  Character string with station identifier code(s). See
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md).

- start:

  Numeric value with the start year (format: `YYYY`).

- end:

  Numeric value with the end year (format: `YYYY`).

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

- calm_wind:

  Upper wind speed limit considered calm. Defaults to `0`.

- legend_title:

  Character string to be used for the legend title.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

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

[`aemet_daily_period()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
[climaemet_9434_wind](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md)

Wind roses:
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md)

## Examples

``` r
# \donttest{
# Do not run this example.
if (FALSE) {
  # Downloading data may take a few minutes.
  windrose_period("9434",
    start = 2000, end = 2010,
    speed_cuts = 4
  )
}
# }
```
