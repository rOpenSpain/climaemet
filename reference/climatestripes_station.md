# Station climate stripes plot

Plot a climate stripes graph for a station.

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

  Character string with station identifier code(s). See
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md).

- start:

  Numeric value with the start year (format: `YYYY`).

- end:

  Numeric value with the end year (format: `YYYY`).

- with_labels:

  Character string, either `"yes"` or `"no"`, to indicate whether plot
  labels are displayed.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

- ...:

  Arguments passed on to
  [`ggstripes`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)

  `n_temp`

  :   Numeric value with the number of colors of the palette. (default
      `11`).

  `col_pal`

  :   Character string indicating the name of the
      [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
      palette to be used for plotting.

## Value

A [ggplot2](https://CRAN.R-project.org/package=ggplot2) object. See
[`help("ggplot2")`](https://ggplot2.tidyverse.org/reference/ggplot2-package.html).

## Note

"Warming stripes" charts are a conceptual idea of Professor Ed Hawkins
(University of Reading) and are specifically designed to be as simple as
possible and to warn about climate change risks. For more details, see
[ShowYourStripes](https://showyourstripes.info/).

## API key

You need to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).
Query timeout can be controlled with `options(climaemet_timeout = 60)`
(default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)

Plotting functions:
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md),
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

Warming stripes functions:
[`climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)

## Examples

``` r
# \donttest{

# Do not run this example.
if (FALSE) {
  # Downloading data may take a few minutes.
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
