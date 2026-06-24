# AEMET stations

Retrieves the weather stations available from the AEMET API.

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
  [tibble](https://tibble.tidyverse.org/reference/tibble.html). The
  [sf](https://CRAN.R-project.org/package=sf) package must be installed.

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

## Examples

``` r
library(dplyr)
stations <- aemet_stations()
#> Error in httr2::req_perform(req1): Failed to perform HTTP request.
#> Caused by error in `curl::curl_fetch_memory()`:
#> ! Timeout was reached [opendata.aemet.es]:
#> Connection timed out after 60002 milliseconds
stations
#> Error: object 'stations' not found

# Cached during this R session.
stations2 <- aemet_stations(verbose = TRUE)
#> 
#> ── climaemet: API call ─────────────────────────────────────────────────────────
#> ℹ Using API key "XXXX...eijBsae3gA4".
#> ℹ Requesting <https://opendata.aemet.es/opendata/api/valores/climatologicos/inventarioestaciones/todasestaciones>.
#> ✔ HTTP `200`: exito
#> ℹ Remaining request count: "149".
#> 
#> ── Requesting data ──
#> 
#> ℹ Requesting <https://opendata.aemet.es/opendata/sh/e00ed1f6>.
#> ✔ HTTP `200`: Se han encontrado 920 estaciones
#> ℹ Remaining request count: "148".
#> 

identical(stations, stations2)
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'identical': object 'stations' not found
```
