# Walter-Lieth climate diagram from climatological normals

Plots a Walter-Lieth climate diagram from climatological normal values
for a station. The diagram summarizes local climate conditions for
1981–2010.

## Usage

``` r
climatogram_normal(
  station,
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

A plot produced by
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)
or [`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html),
depending on `ggplot2`.

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

- Guijarro J. A. (2023).
  [climatol](https://CRAN.R-project.org/package=climatol), *Climate
  Tools (Series Homogenization and Derived Products)*, version 4.0.0,
  <https://climatol.eu>.

## See also

[climaemet_9434_climatogram](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md).

Walter-Lieth climate diagrams:
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)

## Examples

``` r
climatogram_normal("9434")
```
