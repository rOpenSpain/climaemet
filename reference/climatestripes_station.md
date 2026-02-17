# Station climate stripes graph

Plot climate stripes graph for a station.

## Usage

``` r
climatestripes_station(
  station,
  start = 1950,
  end = 2020,
  with_labels = "yes",
  verbose = FALSE,
  ...
)
```

## Arguments

- station:

  Character string with station identifier code(s) (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)).

- start:

  Numeric value as start year (format: `YYYY`).

- end:

  Numeric value as end year (format: `YYYY`).

- with_labels:

  Character string as yes/no. Indicates whether to use labels for the
  graph or not.

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

- ...:

  Arguments passed on to
  [`ggstripes`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)

  `n_temp`

  :   Numeric value as the number of colors of the palette. (default
      `11`).

  `col_pal`

  :   Character string indicating the name of the
      [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
      palette to be used for plotting.

## Value

A [ggplot2](https://CRAN.R-project.org/package=ggplot2) object

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)

Other aemet_plots:
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md),
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

Other stripes:
[`climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)

## Examples

``` r
# \donttest{

# Don't run example
if (FALSE) {
  # Data download may take a few minutes...
  climatestripes_station(
    "9434",
    start = 2020,
    end = 2024,
    with_labels = "yes",
    col_pal = "Inferno"
  )
}
# }
```
