# AEMET stations

Retrieves the weather stations available from the AEMET OpenData API.

## Usage

``` r
aemet_stations(verbose = FALSE, return_sf = FALSE)
```

## Arguments

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- return_sf:

  A logical value. If `TRUE`, the function returns an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object. If `FALSE` (the default), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object.

## Note

Code modified from project <https://github.com/SevillaR/aemet>.

## Caching

The first result retrieved in each session is temporarily cached in
[`tempdir()`](https://rdrr.io/r/base/tempfile.html) to avoid unnecessary
requests.

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

AEMET locations:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)

## Examples

``` r
library(dplyr)
stations <- aemet_stations()
stations
#> # A tibble: 920 × 7
#>    indicativo indsinop nombre                 provincia altitud longitud latitud
#>    <chr>      <chr>    <chr>                  <chr>       <dbl>    <dbl>   <dbl>
#>  1 B013X      "08304"  ESCORCA, LLUC          ILLES BA…     490     2.89    39.8
#>  2 B051A      "08316"  SÓLLER, PUERTO         BALEARES        5     2.69    39.8
#>  3 B087X      ""       BANYALBUFAR            ILLES BA…      60     2.51    39.7
#>  4 B103B      ""       ANDRATX - SANT ELM     BALEARES       52     2.37    39.6
#>  5 B158X      ""       CALVIÀ, ES CAPDELLÀ    BALEARES       50     2.47    39.6
#>  6 B228       "08301"  PALMA, PUERTO          BALEARES        3     2.63    39.6
#>  7 B236C      ""       PALMA, UNIVERSITAT     ILLES BA…      95     2.64    39.6
#>  8 B248       "08303"  SIERRA DE ALFABIA, BU… ILLES BA…    1030     2.71    39.7
#>  9 B275E      "08302"  SON BONET, AEROPUERTO  BALEARES       47     2.71    39.6
#> 10 B278       "08306"  PALMA DE MALLORCA, AE… BALEARES        5     2.74    39.6
#> # ℹ 910 more rows

# Cached during this R session.
stations2 <- aemet_stations(verbose = TRUE)
#> ℹ Loading "stations" from temporary cache file /tmp/Rtmp9MJaDk/aemet_stations.rds, saved at 2026-07-17 00:16:25 UTC.

identical(stations, stations2)
#> [1] TRUE
```
