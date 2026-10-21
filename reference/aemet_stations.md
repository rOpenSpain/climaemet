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
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
an [`sf`](https://r-spatial.github.io/sf/reference/sf.html) object.

## Note

Code adapted from the project at <https://github.com/SevillaR/aemet>.

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

- [`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md)
  retrieves latest station observations.

- [`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
  [`aemet_monthly_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
  [`aemet_normal_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)
  and
  [`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md)
  retrieve station climatology.

AEMET locations:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md)

## Examples

``` r
library(dplyr)
stations <- aemet_stations()
#> ✖ Tu apiKey ha superado el plazo establecido hasta el 15/10/2026 para su renovación. Debes renovar la credencial antes de continuar utilizando el servicio.
#> Error in aemet_api_call(apidest, verbose, apikey = apikey): HTTP 401 Unauthorized.
stations
#> Error: object 'stations' not found

# Cached during this R session.
stations2 <- aemet_stations(verbose = TRUE)
#> 
#> ── climaemet: AEMET OpenData API call ──────────────────────────────────────────
#> ℹ Using API key "XXXX...3gA4".
#> ℹ Requesting <https://opendata.aemet.es/opendata/api/valores/climatologicos/inventarioestaciones/todasestaciones>.
#> ✖ Tu apiKey ha superado el plazo establecido hasta el 15/10/2026 para su renovación. Debes renovar la credencial antes de continuar utilizando el servicio.
#> Error in aemet_api_call(apidest, verbose, apikey = apikey): HTTP 401 Unauthorized.
#> 

identical(stations, stations2)
#> Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'identical': object 'stations' not found
```
