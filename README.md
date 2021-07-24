
<!-- README.md is generated from README.Rmd. Please edit that file -->

# climaemet <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->

[![rOS-badge](https://ropenspain.github.io/rostemplate/reference/figures/ropenspain-badge.svg)](https://ropenspain.es/)
[![CRAN
status](https://www.r-pkg.org/badges/version/climaemet?)](https://CRAN.R-project.org/package=climaemet)
[![CRAN\_time\_from\_release](https://www.r-pkg.org/badges/ago/climaemet)](https://cran.r-project.org/package=climaemet)
[![CRAN\_latest\_release\_date](https://www.r-pkg.org/badges/last-release/climaemet)](https://cran.r-project.org/package=climaemet)
[![r-universe](https://ropenspain.r-universe.dev/badges/climaemet)](https://ropenspain.r-universe.dev/)
[![R-CMD-check](https://github.com/rOpenSpain/climaemet/actions/workflows/roscron-check-standard.yaml/badge.svg)](https://github.com/rOpenSpain/climaemet/actions/workflows/roscron-check-standard.yaml)
[![Rdoc](https://www.rdocumentation.org/badges/version/climaemet)](https://www.rdocumentation.org/packages/climaemet)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/climaemet)](https://cran.r-project.org/package=climaemet)
[![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

<!-- badges: end -->

## Description

The goal of **climaemet** is to serve as an interface to download the
climatic data of the Spanish Meteorological Agency (AEMET) directly from
R using their API (<https://opendata.aemet.es/>) and create scientific
graphs (climate charts, trend analysis of climate time series,
temperature and precipitation anomalies maps, “warming stripes”
graphics, climatograms, etc.).

Browse manual at <https://ropenspain.github.io/climaemet/>

## AEMET Open Data

AEMET OpenData is a REST API developed by AEMET that allows the
dissemination and reuse of the Agency’s meteorological and
climatological information. To see more details visit:
<https://opendata.aemet.es/centrodedescargas/inicio>

## License for the original data

Information prepared by the Spanish Meteorological Agency (© AEMET). You
can read about it here (in spanish): <http://www.aemet.es/es/nota_legal>

A summary for the usage of the data could be interpreted as:

People can use freely this data. You should mention AEMET as the
collector of the original data in every situation except if you are
using this data privately and individually. AEMET makes no warranty as
to the accuracy or completeness of the data. All data are provided on an
“as is” basis. AEMET is not responsible for any damage or loss derived
from the interpretation or use of this data.

## Installation

You can install the released version of **climaemet** from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("climaemet")
```

You can install the developing version of **climaemet** with:

``` r
library(remotes)
install_github("ropenspain/climaemet")
```

Alternatively, you can install the developing version of **climaemet**
using the [r-universe](https://ropenspain.r-universe.dev/ui#builds):

``` r
# Enable this universe
options(repos = c(
    ropenspain = 'https://ropenspain.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'))
    
install.packages('climaemet')
```

## API key

To be able to download data from AEMET you will need a free API key
which you can get at
<https://opendata.aemet.es/centrodedescargas/obtencionAPIKey>

``` r
library(climaemet)

## Get api key from AEMET
browseURL("https://opendata.aemet.es/centrodedescargas/obtencionAPIKey")

## Use this function to register your API Key temporarly or permanently
aemet_api_key("<MY API KEY>")
```

### Changes on v1.0.0!

Now the `apikey` parameter on the functions have been deprecated. You
may need to set your API Key globally using `aemet_api_key()`. Note that
you would need also to remove the `apikey` parameter on your old codes.

## Now **climaemet** is tidy…

From `v1.0.0` onward, **climaemet** provides its results in [tibble
format](https://tibble.tidyverse.org/). Also, the functions try to guess
the correct format of the fields (i.e. something as a Date/Hour now is
an hour, numbers are parsed as double, etc.).

You may see the following message on load:

``` r
library(climaemet)
#> 
#> Welcome to climaemet (1.0.0)
#> Note that since climaemet (>=1.0.0) the results are provided on tibble format. Run `climaemet_news()` to see the changelog.
#> If you experience any problem open an issue on https://github.com/rOpenSpain/climaemet/issues
#> 
#> 
#> AEMET_API_KEY variable detected on this session.
```

See how a tibble is displayed:

``` r
# See a tibble in action

aemet_last_obs("9434")
#> # A tibble: 24 x 25
#>    idema   lon fint                 prec   alt  vmax    vv    dv   lat  dmax
#>    <chr> <dbl> <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 9434  -1.00 2021-07-22 06:00:00     0   249   4.7   3.2   111  41.7   130
#>  2 9434  -1.00 2021-07-22 07:00:00     0   249   5.5   3.5   110  41.7   110
#>  3 9434  -1.00 2021-07-22 08:00:00     0   249   5.1   3.1    96  41.7   115
#>  4 9434  -1.00 2021-07-22 09:00:00     0   249   4.9   3.1    97  41.7   103
#>  5 9434  -1.00 2021-07-22 10:00:00     0   249   5.7   3.6   123  41.7   115
#>  6 9434  -1.00 2021-07-22 11:00:00     0   249   5.6   3.8   104  41.7    95
#>  7 9434  -1.00 2021-07-22 12:00:00     0   249   6.4   4.2   100  41.7    88
#>  8 9434  -1.00 2021-07-22 13:00:00     0   249   7.4   4.6   100  41.7   130
#>  9 9434  -1.00 2021-07-22 14:00:00     0   249   7.7   3.7   105  41.7    88
#> 10 9434  -1.00 2021-07-22 15:00:00     0   249   6     3     111  41.7   120
#> # ... with 14 more rows, and 15 more variables: ubi <chr>, pres <dbl>,
#> #   hr <dbl>, stdvv <dbl>, ts <dbl>, pres_nmar <dbl>, tamin <dbl>, ta <dbl>,
#> #   tamax <dbl>, tpr <dbl>, stddv <dbl>, inso <dbl>, tss5cm <dbl>,
#> #   pacutp <dbl>, tss20cm <dbl>
```

### Examples

The package provides several functions to access the data of the API.
Here you can find some examples:

``` r
## Get AEMET stations
stations <- aemet_stations() # Need to have the API Key registered

knitr::kable(head(stations))
```

| indicativo | indsinop | nombre               | provincia | altitud | longitud |  latitud |
|:-----------|:---------|:---------------------|:----------|--------:|---------:|---------:|
| 0252D      | 08186    | ARENYS DE MAR        | BARCELONA |      74 | 2.540000 | 41.58750 |
| 0076       | 08181    | BARCELONA AEROPUERTO | BARCELONA |       4 | 2.070000 | 41.29278 |
| 0200E      |          | BARCELONA, FABRA     | BARCELONA |     408 | 2.124167 | 41.41833 |
| 0201D      | 08180    | BARCELONA            | BARCELONA |       6 | 2.200000 | 41.39056 |
| 0149X      | 08174    | MANRESA              | BARCELONA |     291 | 1.840278 | 41.72000 |
| 0229I      | 08192    | SABADELL AEROPUERTO  | BARCELONA |     146 | 2.103056 | 41.52361 |

``` r
station <- "9434" # Zaragoza Aeropuerto

## Get last observation values for a station
data_observation <- aemet_last_obs(station)

knitr::kable(head(data_observation))
```

| idema |       lon | fint                | prec | alt | vmax |  vv |  dv |      lat | dmax | ubi                 |  pres |  hr | stdvv |   ts | pres\_nmar | tamin |   ta | tamax |  tpr | stddv | inso | tss5cm | pacutp | tss20cm |
|:------|----------:|:--------------------|-----:|----:|-----:|----:|----:|---------:|-----:|:--------------------|------:|----:|------:|-----:|-----------:|------:|-----:|------:|-----:|------:|-----:|-------:|-------:|--------:|
| 9434  | -1.004167 | 2021-07-22 06:00:00 |    0 | 249 |  4.7 | 3.2 | 111 | 41.66056 |  130 | ZARAGOZA AEROPUERTO | 987.9 |  63 |   0.5 | 24.7 |     1016.6 |  23.7 | 24.2 |  24.2 | 16.7 |    11 | 24.0 |   30.3 |      0 |    32.8 |
| 9434  | -1.004167 | 2021-07-22 07:00:00 |    0 | 249 |  5.5 | 3.5 | 110 | 41.66056 |  110 | ZARAGOZA AEROPUERTO | 988.3 |  58 |   0.5 | 27.7 |     1016.9 |  24.2 | 25.7 |  25.7 | 16.8 |    11 | 59.8 |   30.4 |      0 |    32.5 |
| 9434  | -1.004167 | 2021-07-22 08:00:00 |    0 | 249 |  5.1 | 3.1 |  96 | 41.66056 |  115 | ZARAGOZA AEROPUERTO | 988.4 |  54 |   0.6 | 30.1 |     1016.8 |  25.7 | 27.3 |  27.3 | 17.1 |    11 | 60.0 |   31.1 |      0 |    32.3 |
| 9434  | -1.004167 | 2021-07-22 09:00:00 |    0 | 249 |  4.9 | 3.1 |  97 | 41.66056 |  103 | ZARAGOZA AEROPUERTO | 988.1 |  48 |   0.7 | 32.4 |     1016.3 |  27.3 | 28.9 |  28.9 | 16.8 |    11 | 60.0 |   32.4 |      0 |    32.1 |
| 9434  | -1.004167 | 2021-07-22 10:00:00 |    0 | 249 |  5.7 | 3.6 | 123 | 41.66056 |  115 | ZARAGOZA AEROPUERTO | 987.7 |  40 |   0.9 | 35.0 |     1015.7 |  28.9 | 31.2 |  31.2 | 16.0 |    13 | 60.0 |   34.0 |      0 |    32.0 |
| 9434  | -1.004167 | 2021-07-22 11:00:00 |    0 | 249 |  5.6 | 3.8 | 104 | 41.66056 |   95 | ZARAGOZA AEROPUERTO | 987.0 |  33 |   0.7 | 36.9 |     1014.8 |  31.2 | 33.6 |  33.6 | 15.1 |    14 | 60.0 |   35.5 |      0 |    32.1 |

``` r
## Get daily/annual climatology values for a station
data_daily <-
  aemet_daily_clim(station, start = "2020-01-01", end = "2020-12-31")

knitr::kable(head(data_daily))
```

| fecha      | indicativo | nombre               | provincia | altitud | tmed | prec | tmin | horatmin | tmax | horatmax | dir | velmedia | racha | horaracha | sol | presMax | horaPresMax | presMin | horaPresMin |
|:-----------|:-----------|:---------------------|:----------|--------:|-----:|:-----|-----:|:---------|-----:|:---------|:----|---------:|------:|:----------|----:|--------:|:------------|--------:|:------------|
| 2020-01-01 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  1.0 | 0,0  |  0.3 | 06:10    |  1.8 | 14:50    | 28  |      1.7 |   5.6 | 04:40     | 0.0 |  1004.6 | 10          |  1001.9 | 15          |
| 2020-01-02 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  0.6 | 0,0  | -0.3 | 08:10    |  1.6 | 18:40    | 29  |      1.1 |   3.6 | 00:40     | 0.0 |  1003.4 | 10          |  1000.7 | 16          |
| 2020-01-03 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  4.2 | 0,0  | -0.1 | 07:10    |  8.5 | 19:10    | 30  |      4.4 |   8.3 | 21:40     | 2.4 |  1003.6 | 10          |  1000.7 | Varias      |
| 2020-01-04 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  8.6 | 0,0  |  3.6 | 06:40    | 13.6 | 14:50    | 33  |      5.0 |  12.5 | 12:30     | 8.2 |  1003.9 | 10          |  1001.2 | 15          |
| 2020-01-05 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  8.2 | 0,0  |  3.0 | 23:00    | 13.3 | 15:20    | 30  |      3.6 |  10.3 | 05:30     | 8.9 |  1001.9 | 00          |   996.9 | Varias      |
| 2020-01-06 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  2.3 | 0,0  |  1.4 | 23:59    |  3.2 | 00:00    | 29  |      3.1 |   7.2 | 20:20     | 0.0 |  1001.7 | 22          |   998.6 | 04          |

``` r

## Get monthly/annual climatology values for a station
data_monthly <- aemet_monthly_clim(station, year = 2000)
knitr::kable(head(data_monthly))
```

| fecha  | indicativo | p\_max   | n\_cub |  hr | n\_gra | n\_fog | inso | q\_max     | nw\_55 | q\_mar | q\_med | tm\_min | ta\_max  | ts\_min | nt\_30 | nv\_0050 | n\_des | w\_racha    | np\_100 | n\_nub | p\_sol | nw\_91 | ts\_20 | np\_001 | ta\_min  |   e | np\_300 | nv\_1000 | evap | p\_mes | n\_llu | n\_tor | ts\_10 | w\_med | nt\_00 | ti\_max | n\_nie | tm\_mes | tm\_max | nv\_0100 | ts\_50 | q\_min    | np\_010 |
|:-------|:-----------|:---------|-------:|----:|-------:|-------:|-----:|:-----------|-------:|-------:|-------:|--------:|:---------|--------:|-------:|---------:|-------:|:------------|--------:|-------:|-------:|-------:|-------:|--------:|:---------|----:|--------:|---------:|-----:|-------:|-------:|-------:|-------:|-------:|-------:|--------:|-------:|--------:|--------:|---------:|-------:|:----------|--------:|
| 2000-1 | 9434       | 8.0(15)  |      8 |  77 |      0 |      6 |  5.4 | 1003.5(11) |      5 | 1026.0 |  994.1 |    -0.1 | 16.3(31) |     6.2 |      0 |        0 |     12 | 32/22.2(22) |       0 |     11 |     56 |      0 |    4.9 |       3 | -5.8(12) |  65 |       0 |        5 |  861 |   14.9 |      3 |      0 |    5.0 |     15 |     16 |     1.0 |      0 |     4.3 |     8.7 |        0 |    5.6 | 979.7(14) |       2 |
| 2000-2 | 9434       | 0.0(–)   |      0 |  60 |      0 |      0 |  7.7 | 1004.9(04) |      9 | 1027.1 |  996.0 |     4.8 | 20.8(27) |    10.7 |      0 |        0 |      8 | 33/21.4(17) |       0 |     21 |     72 |      0 |   11.8 |       0 | -1.5(06) |  79 |       0 |        0 | 1638 |    0.0 |      0 |      0 |   12.7 |     16 |      4 |    13.4 |      0 |    10.8 |    16.9 |        0 |   10.6 | 988.6(17) |       0 |
| 2000-3 | 9434       | 5.4(22)  |      4 |  58 |      0 |      0 |  7.8 | 1001.0(09) |      8 | 1020.3 |  989.5 |     6.0 | 24.0(11) |    11.0 |      0 |        0 |      8 | 32/20.0(15) |       0 |     19 |     65 |      0 |   14.9 |       7 | -0.8(03) |  83 |       0 |        0 | 2062 |   11.1 |      7 |      0 |   15.7 |     18 |      1 |    12.1 |      0 |    12.0 |    17.9 |        0 |   13.6 | 976.5(28) |       4 |
| 2000-4 | 9434       | 22.2(26) |      8 |  61 |      0 |      0 |  6.2 | 991.5(07)  |      7 | 1008.0 |  977.8 |     8.4 | 27.2(25) |    14.9 |      0 |        0 |      1 | 10/20.0(02) |       1 |     21 |     46 |      0 |   16.7 |      10 | 1.7(06)  |  99 |       0 |        0 | 1730 |   49.1 |     14 |      1 |   17.5 |     17 |      0 |    11.7 |      0 |    13.7 |    18.9 |        0 |   15.2 | 959.5(02) |       6 |
| 2000-5 | 9434       | 23.4(05) |      6 |  61 |      2 |      2 |  8.7 | 991.4(30)  |     NA | 1014.4 |  984.7 |    13.2 | 33.0(30) |    18.8 |      5 |        0 |      1 | NA          |       3 |     24 |     59 |     NA |   23.5 |      13 | 9.2(01)  | 143 |       0 |        1 | 2116 |   67.5 |     11 |      8 |   24.8 |     13 |      0 |    21.5 |      0 |    19.5 |    25.7 |        0 |   20.8 | 977.5(06) |       8 |
| 2000-6 | 9434       | 12.2(09) |      2 |  57 |      0 |      0 | 11.3 | 995.0(14)  |     NA | 1017.1 |  987.6 |    16.0 | 37.5(27) |    20.3 |     19 |        0 |     18 | NA          |       1 |     10 |     75 |     NA |   27.7 |       6 | 11.0(08) | 164 |       0 |        0 | 2955 |   34.9 |      8 |      4 |   29.2 |     21 |      0 |    16.5 |      0 |    23.0 |    29.8 |        0 |   26.1 | 977.9(09) |       5 |

``` r

## Get recorded extreme values of temperature for a station
data_extremes <- aemet_extremes_clim(station, parameter = "T")
knitr::kable(head(data_extremes))
```

| indicativo | nombre               | ubicacion | codigo | temMin | diaMin | anioMin | mesMin | temMax | diaMax | anioMax | mesMax | temMedBaja | anioMedBaja | mesMedBaja | temMedAlta | anioMedAlta | mesMedAlta | temMedMin | anioMedMin | mesMedMin | temMedMax | anioMedMax | mesMedMax |
|:-----------|:---------------------|:----------|:-------|-------:|-------:|--------:|-------:|-------:|-------:|--------:|-------:|-----------:|------------:|-----------:|-----------:|------------:|-----------:|----------:|-----------:|----------:|----------:|-----------:|----------:|
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |   -104 |      4 |    1971 |      2 |    206 |      8 |    2016 |      7 |         29 |        1953 |          2 |         97 |        2016 |          7 |       -12 |       1957 |         2 |       135 |       2016 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |   -114 |      5 |    1963 |      2 |    255 |     27 |    2019 |      7 |         15 |        1956 |          2 |        121 |        1990 |          7 |       -30 |       1956 |         2 |       180 |       1990 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |    -63 |      9 |    1964 |      2 |    283 |     19 |    1957 |      7 |         71 |        1971 |          2 |        146 |        2001 |          7 |        19 |       1973 |         2 |       207 |       1997 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |    -24 |      3 |    1967 |      2 |    324 |      9 |    2011 |      7 |        104 |        1986 |          2 |        174 |        2014 |          7 |        54 |       1970 |         2 |       237 |       2014 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |      5 |      4 |    1967 |      2 |    365 |     29 |    2001 |      7 |        132 |        1984 |          2 |        208 |        2017 |          7 |        85 |       1984 |         2 |       278 |       2017 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |     52 |     11 |    1971 |      2 |    432 |     29 |    2019 |      7 |        182 |        1953 |          2 |        266 |        2003 |          7 |       126 |       1969 |         2 |       338 |       2003 |         7 |

We can also draw a “warming stripes” graph with the downloaded data from
a weather station. These functions returns `ggplot2` plots:

``` r
# Plot a climate stripes graph for a period of years for a station

library(ggplot2)

climatestripes_station("9434", start = 1980, end = 2020) +
  theme(plot.title = element_text(size = 10))
```

<img src="man/figures/README-climatestripes-1.png" width="100%" />

Furthermore, we can draw the well-known Walter & Lieth climatic diagram
for a weather station and over a specified period of time:

``` r
# Plot of a Walter & Lieth climatic diagram (normal climatology values) for a station
climatogram_normal("9434", labels = "en")
```

<img src="man/figures/README-climatogram-1.png" width="100%" />

Additionally, we may be interested in drawing the wind speed and
direction over a period of time for the data downloaded from a weather
station.:

``` r
# Plot a windrose showing the wind speed and direction for a station over a days period.
windrose_days(
  "9434",
  start = "2010-01-01",
  end = "2020-12-31",
  n_speeds = 5,
  speed_cuts = c(2.5, 5, 7.5, 10, 12.5, 15)
) +
  theme(plot.title = element_text(size = 10))
```

<img src="man/figures/README-windrose-1.png" width="100%" />

## … and spatial!

Another major change in `v1.0.0` is the ability of return information on
spatial `sf` format, using `return_sf = TRUE`. The coordinate reference
system (CRS) used is **EPSG 4326**, that correspond to the **World
Geodetic System (WGS)** and return coordinates in latitude/longitude
(unprojected coordinates):

``` r
# You would need to install `sf` if not installed yet
# run install.packages("sf") for installation

library(ggplot2)
library(dplyr)
all_stations <- aemet_last_obs(return_sf = TRUE)
# Last hour
all_last <-
  all_stations %>% filter(fint == all_stations[["fint"]][1])

ggplot(all_last) +
  geom_sf(aes(col = ta, stroke = 0, geometry = geometry),
    shape = 19,
    size = 2
  ) +
  labs(col = "Max temp.") +
  scale_colour_gradientn(colours = hcl.colors(5, "RdBu", rev = TRUE)) +
  theme_bw() +
  theme(panel.border = element_blank())
```

<img src="man/figures/README-spatial-1.png" width="100%" />

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.

## Citation

Using **climaemet** for a paper you are writing?. Consider citing it:

``` r
citation("climaemet")
#> 
#> To cite climaemet in publications use:
#> 
#>   Pizarro, M. & Hernangómez, D. (2021). climaemet (R Climate AEMET
#>   Tools). https://CRAN.R-project.org/package=climaemet.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {climaemet (R Climate AEMET Tools)},
#>     author = {Manuel Pizarro and Diego Hernangómez},
#>     year = {2021},
#>     email = {m.pizarro@csic.es},
#>     url = {https://CRAN.R-project.org/package=climaemet},
#>   }
```

## Links

Download from CRAN at <https://cran.r-project.org/package=climaemet>

Browse source code at <https://github.com/ropenspain/climaemet>
