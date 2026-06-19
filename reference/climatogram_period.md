# Walter-Lieth climate diagram for a time period

Plots a Walter-Lieth climate diagram from monthly climatology values for
a station over a specified time period.

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

  A character vector of station identifiers. See
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md).

- start:

  A numeric value specifying the start year in `YYYY` format.

- end:

  A numeric value specifying the end year in `YYYY` format.

- labels:

  A character string specifying the language for the x-axis month
  labels, such as `"en"` (English), `"es"` (Spanish) or `"fr"` (French).

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- ggplot2:

  A logical value. If `TRUE`, the function uses
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md).
  If `FALSE`, it uses
  [`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html).

- ...:

  Further arguments passed to
  [`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html)
  or
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
  depending on the value of `ggplot2`.

## Value

A plot.

## Note

The implementation is based on
[climatol](https://CRAN.R-project.org/package=climatol).

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## References

- Walter, H. K., Harnickell, E., Lieth, F. H. H. and Rehder, H. (1967).
  *Klimadiagramm-weltatlas*. Jena: Fischer.

- Guijarro J. A. (2023). *climatol: Climate Tools (Series Homogenization
  and Derived Products)*. R package version 4.0.0,
  <https://climatol.eu>.

## See also

Walter-Lieth climate diagrams:
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)

## Examples

``` r
# \donttest{
climatogram_period("9434", start = 2015, end = 2020, labels = "en")

# }
```
