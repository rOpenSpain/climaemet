# Windrose (speed/direction) diagram of a station over a period of days

Plot a windrose showing the wind speed and direction for a station over
a period of days.

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

  Character string with station identifier code(s) (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md))
  or `"all"` for all the stations.

- start:

  Character string with the start date (format: `"YYYY-MM-DD"`).

- end:

  Character string with the end date (format: `"YYYY-MM-DD"`).

- n_directions:

  Numeric value with the number of direction bins to plot (petals on the
  rose). Valid values are `4`, `8` or `16`.

- n_speeds:

  Numeric value with the number of equally spaced wind speed bins to
  plot. This is used if `speed_cuts` is `NA` (default `5`).

- speed_cuts:

  Numeric vector with the cut points for the wind speed intervals, or
  `NA` (default).

- col_pal:

  Character string indicating the name of the
  [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
  palette to be used for plotting.

- calm_wind:

  Numeric value with the upper limit for wind speed that is considered
  calm (default `0`).

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

[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md)

Plotting functions:
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md),
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

Wind functions:
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
#> ℹ Downloading data, this may take a few seconds.
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying.
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> 
```
