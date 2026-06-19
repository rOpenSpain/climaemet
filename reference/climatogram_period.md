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

  Character string with station identifier code(s). See
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md).

- start:

  Numeric value with the start year (format: `YYYY`).

- end:

  Numeric value with the end year (format: `YYYY`).

- labels:

  Character string with month labels for the x-axis: `"en"` (English),
  `"es"` (Spanish), `"fr"` (French), etc.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

- ggplot2:

  Logical. If `TRUE`, the function uses
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md).
  If `FALSE`, it uses
  [`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html).

- ...:

  Further arguments passed to
  [`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html)
  or
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
  depending on the value of
  [ggplot2](https://CRAN.R-project.org/package=ggplot2).

## Value

A plot.

## Note

The code is based on code from
[climatol](https://CRAN.R-project.org/package=climatol).

## API key

You need to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).
Query timeout can be controlled with `options(climaemet_timeout = 60)`
(default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## References

- Walter, H. K., Harnickell, E., Lieth, F. H. H., & Rehder, H. (1967).
  *Klimadiagramm-weltatlas*. Jena: Fischer, 1967.

- Guijarro J. A. (2023). *climatol: Climate Tools (Series Homogenization
  and Derived Products)*. R package version 4.0.0,
  <https://climatol.eu>.

## See also

Climatograms:
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)

## Examples

``` r
# \donttest{
climatogram_period("9434", start = 2015, end = 2020, labels = "en")
#> ! HTTP `429`:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying.
#> Waiting 4s for retry backoff ■■■■■■■■■                       
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■             
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 7s for retry backoff ■■■■■                           
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■■■■■■■             
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 15s for retry backoff ■■■                             
#> Waiting 15s for retry backoff ■■■■■■■                         
#> Waiting 15s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 15s for retry backoff ■■■■■■■■■■■■■■■■■■■■            
#> Waiting 15s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■      
#> Waiting 15s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> 

# }
```
