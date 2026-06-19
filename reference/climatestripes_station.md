# Warming stripes for a weather station

Plots warming stripes for a weather station over a specified period.

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

  A character vector of station identifiers. See
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md).

- start:

  A numeric value specifying the start year in `YYYY` format.

- end:

  A numeric value specifying the end year in `YYYY` format.

- with_labels:

  A character string indicating whether to display plot labels, either
  `"yes"` or `"no"`.

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- ...:

  Arguments passed on to
  [`ggstripes`](https://ropenspain.github.io/climaemet/reference/ggstripes.md)

  `n_temp`

  :   The number of colors in the palette. Defaults to `11`.

  `col_pal`

  :   A character string specifying the
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

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[climaemet_9434_temp](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md).

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
