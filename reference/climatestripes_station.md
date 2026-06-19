# Climate stripes for a weather station

Plots climate stripes for a weather station over a specified period.

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

  Character string indicating whether to display plot labels: `"yes"` or
  `"no"`.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

- ...:

  Arguments passed on to
  [`ggstripes`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)

  `n_temp`

  :   Number of colors in the palette. Defaults to `11`.

  `col_pal`

  :   Character string indicating the name of the
      [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) color
      palette to be used for plotting.

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

[climaemet_9434_wind](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md)

Warming stripes:
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
