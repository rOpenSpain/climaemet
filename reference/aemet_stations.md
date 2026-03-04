# AEMET stations

Get AEMET stations.

## Usage

``` r
aemet_stations(verbose = FALSE, return_sf = FALSE)
```

## Arguments

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

- return_sf:

  Logical `TRUE` or `FALSE`. Should the function return an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object? If `FALSE` (the default value) it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  Note that you need to have the
  [sf](https://CRAN.R-project.org/package=sf) package installed.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## Details

The first result of the API call on each session is (temporarily) cached
in the assigned [`tempdir()`](https://rdrr.io/r/base/tempfile.html) for
avoiding unneeded API calls.

## Note

Code modified from project <https://github.com/SevillaR/aemet>.

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

Other aemet_api_data:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md),
[`aemet_monthly`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)

## Examples

``` r
library(tibble)
stations <- aemet_stations()
stations
#> # A tibble: 947 × 7
#>    indicativo indsinop nombre                 provincia altitud longitud latitud
#>    <chr>      <chr>    <chr>                  <chr>       <dbl>    <dbl>   <dbl>
#>  1 B860X      ""       CIUTADELLA             ILLES BA…      20     3.85    40.0
#>  2 B248       "08303"  SIERRA DE ALFABIA, BU… ILLES BA…    1030     2.71    39.7
#>  3 B275E      "08302"  SON BONET, AEROPUERTO  BALEARES       47     2.71    39.6
#>  4 B087X      ""       BANYALBUFAR            ILLES BA…      60     2.51    39.7
#>  5 B870C      ""       CIUTADELLA, CALA GALD… BALEARES       43     3.96    39.9
#>  6 C126A      ""       EL PASO                STA. CRU…     844   -17.9     28.7
#>  7 B925       ""       SANT ANTONI DE PORTMA… BALEARES       32     1.32    39.0
#>  8 C423R      ""       CITFAGRO_90_PICACHO    STA. CRU…    1654   -16.5     28.2
#>  9 C456R      ""       CITFAGRO_69_SUERTE     STA. CRU…     551   -16.5     28.4
#> 10 B662X      ""       BINISSALEM             ILLES BA…     105     2.87    39.7
#> # ℹ 937 more rows

# Cached during this R session
stations2 <- aemet_stations(verbose = TRUE)
#> ℹ Loading stations from temporal cached file saved at 2026-03-04 12:44:02 UTC

identical(stations, stations2)
#> [1] TRUE
```
