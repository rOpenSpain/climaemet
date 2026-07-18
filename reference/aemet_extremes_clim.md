# Extreme values for a station

Retrieves recorded extreme values for one or more stations.

## Usage

``` r
aemet_extremes_clim(
  station = NULL,
  parameter = "T",
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)
```

## Arguments

- station:

  A character vector of station identifiers. See
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md).

- parameter:

  A character string specifying the parameter to retrieve: temperature
  (`"T"`), precipitation (`"P"`) or wind (`"V"`).

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- return_sf:

  A logical value. If `TRUE`, the function returns an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object. If `FALSE` (the default), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tibble.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  A logical value. If `TRUE`, displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  unless `verbose = TRUE`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) or a
[sf](https://CRAN.R-project.org/package=sf) object. If the function
encounters a parsing error, it returns a list.

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://rdrr.io/pkg/httr2/man/req_timeout.html)
for details.

## See also

[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)
for station identifiers.

Climatology:
[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
[`aemet_monthly_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)

## Examples

``` r
obs <- aemet_extremes_clim(c("9434", "3195"))
dplyr::glimpse(obs)
#> Rows: 26
#> Columns: 24
#> $ indicativo  <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "9…
#> $ nombre      <chr> "ZARAGOZA, AEROPUERTO", "ZARAGOZA, AEROPUERTO", "ZARAGOZA,…
#> $ ubicacion   <chr> "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA", "ZARAGOZA"…
#> $ codigo      <chr> "023000", "023000", "023000", "023000", "023000", "023000"…
#> $ temMin      <dbl> -104, -114, -63, -24, 5, 52, 80, 84, 48, 6, -56, -95, -114…
#> $ diaMin      <dbl> 4, 5, 9, 3, 4, 11, 18, 17, 30, 25, 22, 25, 5, 16, 12, 1, 1…
#> $ anioMin     <dbl> 1971, 1963, 1964, 1967, 1967, 1971, 1965, 1968, 1974, 1974…
#> $ mesMin      <dbl> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1…
#> $ temMax      <dbl> 206, 255, 287, 324, 375, 432, 445, 428, 392, 339, 284, 220…
#> $ diaMax      <dbl> 8, 27, 13, 9, 30, 29, 7, 26, 16, 1, 9, 8, 7, 27, 28, 30, 2…
#> $ anioMax     <dbl> 2016, 2019, 2023, 2011, 2025, 2019, 2015, 2010, 1964, 2023…
#> $ mesMax      <dbl> 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8…
#> $ temMedBaja  <dbl> 29, 15, 71, 104, 132, 182, 213, 216, 169, 117, 73, 32, 15,…
#> $ anioMedBaja <dbl> 1953, 1956, 1971, 1986, 1984, 1953, 1977, 1977, 1972, 1974…
#> $ mesMedBaja  <dbl> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2…
#> $ temMedAlta  <dbl> 97, 121, 147, 184, 216, 276, 282, 282, 241, 203, 138, 101,…
#> $ anioMedAlta <dbl> 2016, 1990, 2023, 2026, 2022, 2025, 2015, 2022, 1987, 2022…
#> $ mesMedAlta  <dbl> 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7, 7, 7…
#> $ temMedMin   <dbl> -12, -30, 19, 54, 85, 126, 150, 151, 110, 72, 27, -21, -30…
#> $ anioMedMin  <dbl> 1957, 1956, 1973, 1970, 1984, 1969, 1954, 1954, 1965, 1974…
#> $ mesMedMin   <dbl> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2…
#> $ temMedMax   <dbl> 135, 180, 211, 251, 282, 350, 358, 355, 307, 256, 187, 137…
#> $ anioMedMax  <dbl> 2016, 1990, 2023, 2026, 2022, 2025, 2015, 2003, 1987, 2023…
#> $ mesMedMax   <dbl> 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7…
```
