# Wind rose for a range of days

Plots a wind rose showing wind speed and direction at a station over a
period of days.

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
  legend_title = "Wind speed (m/s)",
  verbose = FALSE
)
```

## Arguments

- station:

  A character vector of station identifiers (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md))
  or `"all"` for all stations.

- start:

  A character string containing the start date in `YYYY-MM-DD` format.

- end:

  A character string containing the end date in `YYYY-MM-DD` format.

- n_directions:

  The number of direction bins (petals) to plot. Valid values are `4`,
  `8` or `16`.

- n_speeds:

  The number of equally spaced wind speed bins to plot when `speed_cuts`
  is `NA`. Defaults to `5`.

- speed_cuts:

  A numeric vector with the cut points for the wind speed intervals or
  `NA` (default).

- col_pal:

  A character string specifying an
  [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
  palette.

- calm_wind:

  The upper wind speed limit considered calm. Defaults to `0`.

- legend_title:

  A character string or expression for the legend title.

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

## Value

A
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html)
object.

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://rdrr.io/pkg/httr2/man/req_timeout.html)
for details.

## See also

- [`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)
  retrieves daily climatology data.

- [climaemet_9434_wind](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md)
  provides example wind observations.

Wind roses:
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

## Examples

``` r
windrose_days("9434",
  start = "2000-12-01",
  end = "2000-12-31",
  speed_cuts = 4
)
#> ℹ Downloading data. This may take a few seconds.
```
