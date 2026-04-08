# Walter & Lieth climatic diagram for a time period

Plot of a Walter & Lieth climatic diagram from monthly climatology data
for a station. This climatogram are great for showing a summary of
climate conditions for a place over a specific time period.

## Usage

``` r
climatogram_period(
  station = NULL,
  start = 1990,
  end = 2020,
  labels = "en",
  verbose = FALSE,
  ggplot2 = TRUE,
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

- labels:

  Character string as month labels for the X axis: `"en"` (english),
  `"es"` (spanish), `"fr"` (french), etc.

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

- ggplot2:

  `TRUE/FALSE`. On `TRUE` the function uses
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
  if `FALSE` uses
  [`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html).

- ...:

  Further arguments to
  [`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html)
  or
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
  depending on the value of
  [ggplot2](https://CRAN.R-project.org/package=ggplot2).

## Value

A plot.

## Note

The code is based on code from the CRAN package
[climatol](https://CRAN.R-project.org/package=climatol).

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## References

- Walter, H. K., Harnickell, E., Lieth, F. H. H., & Rehder, H. (1967).
  *Klimadiagramm-weltatlas*. Jena: Fischer, 1967.

- Guijarro J. A. (2023). *climatol: Climate Tools (Series Homogenization
  and Derived Products)*. R package version 4.0.0,
  <https://climatol.eu>.

## See also

Other aemet_plots:
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md),
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

Other climatogram:
[`climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)

## Examples

``` r
# \donttest{
climatogram_period("9434", start = 2015, end = 2020, labels = "en")

# }
```
