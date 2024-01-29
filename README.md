
<!-- README.md is generated from README.Rmd. Please edit that file -->

# climaemet <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![rOS-badge](https://ropenspain.github.io/rostemplate/reference/figures/ropenspain-badge.svg)](https://ropenspain.es/)
[![CRAN
status](https://www.r-pkg.org/badges/version/climaemet)](https://CRAN.R-project.org/package=climaemet)
[![CRAN_time_from_release](https://www.r-pkg.org/badges/ago/climaemet)](https://cran.r-project.org/package=climaemet)
[![CRAN_latest_release_date](https://www.r-pkg.org/badges/last-release/climaemet)](https://cran.r-project.org/package=climaemet)
[![CRAN
results](https://badges.cranchecks.info/worst/climaemet.svg)](https://cran.r-project.org/web/checks/check_results_climaemet.html)
[![r-universe](https://ropenspain.r-universe.dev/badges/climaemet)](https://ropenspain.r-universe.dev/climaemet)
[![R-CMD-check](https://github.com/rOpenSpain/climaemet/actions/workflows/roscron-check-full.yaml/badge.svg)](https://github.com/rOpenSpain/climaemet/actions/workflows/roscron-check-full.yaml)
[![DOI](https://img.shields.io/badge/DOI-10.5281/zenodo.5205573-blue)](https://doi.org/10.5281/zenodo.5205573)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/climaemet)](https://cran.r-project.org/package=climaemet)
[![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

<!-- badges: end -->

The goal of **climaemet** is to serve as an interface to download the
climatic data of the Spanish Meteorological Agency (AEMET) directly from
R using their [API](https://opendata.aemet.es/) and create scientific
graphs (climate charts, trend analysis of climate time series,
temperature and precipitation anomalies maps, “warming stripes”
graphics, climatograms, etc.).

Browse manual and vignettes at
<https://ropenspain.github.io/climaemet/>.

## AEMET Open Data

AEMET OpenData is a REST API developed by AEMET that allows the
dissemination and reuse of the Agency’s meteorological and
climatological information. To see more details visit:
<https://opendata.aemet.es/centrodedescargas/inicio>

## License for the original data

Information prepared by the Spanish Meteorological Agency (© AEMET). You
can read about it [here](https://www.aemet.es/en/nota_legal).

A summary for the usage of the data could be interpreted as:

> People can use freely this data. You should mention AEMET as the
> collector of the original data in every situation except if you are
> using this data privately and individually. AEMET makes no warranty as
> to the accuracy or completeness of the data. All data are provided on
> an “as is” basis. AEMET is not responsible for any damage or loss
> derived from the interpretation or use of this data.

## Installation

You can install the released version of **climaemet** from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("climaemet")
```

You can install the developing version of **climaemet** using the
[r-universe](https://ropenspain.r-universe.dev/climaemet):

``` r
# Install climaemet in R:
install.packages("climaemet",
  repos = c("https://ropenspain.r-universe.dev", "https://cloud.r-project.org")
)
```

Alternatively, you can install the developing version of **climaemet**
with:

``` r
library(remotes)
install_github("ropenspain/climaemet")
```

## API key

To be able to download data from AEMET you will need a free API key
which you can get
[here](https://opendata.aemet.es/centrodedescargas/obtencionAPIKey).

``` r
library(climaemet)

## Get api key from AEMET
browseURL("https://opendata.aemet.es/centrodedescargas/obtencionAPIKey")

## Use this function to register your API Key temporarly or permanently
aemet_api_key("MY API KEY")
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

``` r
library(climaemet)

# See a tibble in action

aemet_last_obs("9434")
#> # A tibble: 23 × 25
#>    idema   lon fint                 prec   alt  vmax    vv    dv   lat  dmax
#>    <chr> <dbl> <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 9434  -1.00 2024-01-28 13:00:00     0   249   5     3.1   100  41.7    85
#>  2 9434  -1.00 2024-01-28 14:00:00     0   249   4.8   3.3   120  41.7   133
#>  3 9434  -1.00 2024-01-28 15:00:00     0   249   5.4   3.5   116  41.7   133
#>  4 9434  -1.00 2024-01-28 16:00:00     0   249   4.9   2.7   112  41.7   120
#>  5 9434  -1.00 2024-01-28 17:00:00     0   249   3.4   1.5   105  41.7    95
#>  6 9434  -1.00 2024-01-28 18:00:00     0   249   3.2   1.6   150  41.7   148
#>  7 9434  -1.00 2024-01-28 19:00:00     0   249   4     2.3   139  41.7   140
#>  8 9434  -1.00 2024-01-28 20:00:00     0   249   3.8   2.8   122  41.7   133
#>  9 9434  -1.00 2024-01-28 21:00:00     0   249   3.9   2.2   132  41.7   138
#> 10 9434  -1.00 2024-01-28 22:00:00     0   249   3.4   2.3   149  41.7   153
#> # ℹ 13 more rows
#> # ℹ 15 more variables: ubi <chr>, pres <dbl>, hr <dbl>, stdvv <dbl>, ts <dbl>,
#> #   pres_nmar <dbl>, tamin <dbl>, ta <dbl>, tamax <dbl>, tpr <dbl>,
#> #   stddv <dbl>, inso <dbl>, tss5cm <dbl>, pacutp <dbl>, tss20cm <dbl>
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

| idema |       lon | fint                | prec | alt | vmax |  vv |  dv |      lat | dmax | ubi                 |  pres |  hr | stdvv |   ts | pres_nmar | tamin |  ta | tamax | tpr | stddv | inso | tss5cm | pacutp | tss20cm |
|:------|----------:|:--------------------|-----:|----:|-----:|----:|----:|---------:|-----:|:--------------------|------:|----:|------:|-----:|----------:|------:|----:|------:|----:|------:|-----:|-------:|-------:|--------:|
| 9434  | -1.004167 | 2024-01-28 13:00:00 |    0 | 249 |  5.0 | 3.1 | 100 | 41.66056 |   85 | ZARAGOZA AEROPUERTO | 999.0 |  97 |   0.6 |  9.7 |    1029.9 |   6.1 | 7.9 |   7.9 | 7.4 |    13 |  7.0 |    8.0 |      0 |     7.5 |
| 9434  | -1.004167 | 2024-01-28 14:00:00 |    0 | 249 |  4.8 | 3.3 | 120 | 41.66056 |  133 | ZARAGOZA AEROPUERTO | 998.6 |  90 |   0.5 | 10.9 |    1029.4 |   7.9 | 9.3 |   9.3 | 7.7 |    12 | 60.0 |    9.1 |      0 |     7.6 |
| 9434  | -1.004167 | 2024-01-28 15:00:00 |    0 | 249 |  5.4 | 3.5 | 116 | 41.66056 |  133 | ZARAGOZA AEROPUERTO | 998.1 |  89 |   0.5 | 11.3 |    1028.8 |   9.2 | 9.8 |   9.9 | 8.1 |    14 | 60.0 |    9.6 |      0 |     7.8 |
| 9434  | -1.004167 | 2024-01-28 16:00:00 |    0 | 249 |  4.9 | 2.7 | 112 | 41.66056 |  120 | ZARAGOZA AEROPUERTO | 998.2 |  90 |   0.4 | 10.7 |    1028.9 |   9.7 | 9.9 |  10.0 | 8.4 |    13 | 60.0 |    9.8 |      0 |     8.1 |
| 9434  | -1.004167 | 2024-01-28 17:00:00 |    0 | 249 |  3.4 | 1.5 | 105 | 41.66056 |   95 | ZARAGOZA AEROPUERTO | 998.5 |  95 |   0.5 |  8.2 |    1029.3 |   8.4 | 8.4 |   9.9 | 7.7 |    25 | 31.9 |    9.5 |      0 |     8.4 |
| 9434  | -1.004167 | 2024-01-28 18:00:00 |    0 | 249 |  3.2 | 1.6 | 150 | 41.66056 |  148 | ZARAGOZA AEROPUERTO | 998.8 |  99 |   0.4 |  7.5 |    1029.7 |   7.6 | 7.6 |   8.4 | 7.4 |    14 |  0.0 |    9.1 |      0 |     8.6 |

``` r

## Get daily/annual climatology values for a station
data_daily <- aemet_daily_clim(station, start = "2022-01-01", end = "2022-12-31")

knitr::kable(head(data_daily))
```

| fecha      | indicativo | nombre               | provincia | altitud | tmed | prec | tmin | horatmin | tmax | horatmax | dir | velmedia | racha | horaracha | sol | presMax | horaPresMax | presMin | horaPresMin |
|:-----------|:-----------|:---------------------|:----------|--------:|-----:|:-----|-----:|:---------|-----:|:---------|:----|---------:|------:|:----------|----:|--------:|:------------|--------:|:------------|
| 2022-01-01 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  4.5 | 0,0  |  3.2 | 07:50    |  5.8 | 15:00    | 24  |      1.7 |   5.6 | 17:10     | 0.0 |  1000.6 | 10          |   997.5 | 15          |
| 2022-01-02 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  5.6 | 0,0  |  2.8 | 08:00    |  8.3 | 17:50    | 24  |      2.2 |   6.7 | 19:20     | 1.7 |  1000.2 | 10          |   997.1 | 16          |
| 2022-01-03 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  7.8 | 0,0  |  2.5 | 06:50    | 13.0 | 15:10    | 10  |      1.1 |   5.6 | 21:40     | 5.8 |   997.6 | 00          |   988.4 | 24          |
| 2022-01-04 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 | 11.2 | 7,0  |  5.3 | 07:30    | 17.2 | 14:20    | 32  |      2.8 |  16.4 | 19:00     | 3.5 |   988.4 | 00          |   976.6 | 17          |
| 2022-01-05 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  7.0 | 0,0  |  4.2 | 23:59    |  9.9 | 14:20    | 31  |      9.2 |  18.6 | 05:10     | 4.9 |   987.9 | 10          |   982.1 | 00          |
| 2022-01-06 | 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  |     249 |  5.6 | 0,0  |  2.9 | 06:20    |  8.2 | 15:20    | 30  |      7.5 |  16.4 | 03:20     | 8.9 |   991.4 | 24          |   986.4 | 00          |

``` r


## Get monthly/annual climatology values for a station
data_monthly <- aemet_monthly_clim(station, year = 2022)
knitr::kable(head(data_monthly))
```

| fecha   | indicativo | p_max        | n_cub |  hr | n_gra | n_fog | inso | q_max          | nw_55 |  q_mar | q_med | tm_min | ta_max       | ts_min | nt_30 | nv_0050 | n_des | w_racha         | np_100 | n_nub | p_sol | nw_91 | np_001 | ta_min       | w_rec |   e | np_300 | nv_1000 | p_mes | n_llu | n_tor | w_med | nt_00 | ti_max | n_nie | tm_mes | tm_max | nv_0100 | q_min         | np_010 | evap |
|:--------|:-----------|:-------------|------:|----:|------:|------:|-----:|:---------------|------:|-------:|------:|-------:|:-------------|-------:|------:|--------:|------:|:----------------|-------:|------:|------:|------:|-------:|:-------------|------:|----:|-------:|--------:|------:|------:|------:|------:|------:|-------:|------:|-------:|-------:|--------:|:--------------|-------:|-----:|
| 2022-10 | 9434       | 1.4(16)      |     9 |  63 |     0 |     1 |  5.9 | 998.8(06)      |     1 | 1019.3 | 989.4 |   14.9 | 29.6(16)     |   18.4 |     0 |       0 |     6 | 26/18.6(19)     |      0 |    16 |    53 |     0 |      7 | 10.5(01)     |   245 | 147 |      0 |       0 |   6.2 |    11 |     1 |    10 |     0 |   20.8 |     0 |   20.3 |   25.6 |       0 | 981.8(15)     |      4 |   NA |
| 2022-11 | 9434       | 6.2(03)      |     7 |  71 |     1 |     3 |  4.6 | 1000.0(26)     |     7 | 1018.5 | 987.8 |    8.2 | 24.1(01)     |   12.9 |     0 |       0 |     3 | 35/23.9(21)     |      0 |    20 |    46 |     0 |     14 | 2.8(27)      |   319 | 107 |      0 |       2 |  29.8 |    15 |     0 |    14 |     0 |   11.5 |     0 |   12.8 |   17.2 |       0 | 973.4(17)     |      6 | 1165 |
| 2022-12 | 9434       | 19.0(13)     |    14 |  82 |     0 |    14 |  4.0 | 1001.5(27)     |     2 | 1016.5 | 985.5 |    5.4 | 18.9(30)     |   11.6 |     0 |       0 |     0 | 29/17.8(10)     |      1 |    16 |    44 |     0 |      8 | 1.5(03)      |   235 |  96 |      0 |       8 |  35.6 |    12 |     0 |    10 |     0 |    5.1 |     0 |    9.2 |   13.0 |       0 | 967.1(15)     |      5 |  673 |
| 2022-13 | 9434       | 25.4(24/ago) |    76 |  57 |     3 |    23 |  8.1 | 1005.7(29/ene) |    76 | 1017.8 | 987.7 |   12.0 | 41.9(17/jul) |   24.8 |   107 |       0 |    94 | 30/30.8(24/ago) |      3 |   194 |    65 |     1 |     72 | -3.2(23/ene) |   360 | 114 |      0 |      14 | 214.2 |    92 |    17 |    15 |    16 |    5.1 |     0 |   17.6 |   23.2 |       0 | 965.4(23/abr) |     44 |   NA |
| 2022-1  | 9434       | 7.0(04)      |     4 |  68 |     0 |     3 |  7.6 | 1005.7(29)     |     7 | 1028.5 | 996.7 |    1.0 | 17.2(04)     |   11.2 |     0 |       0 |    21 | 31/24.2(31)     |      0 |     6 |    79 |     0 |      2 | -3.2(23)     |   353 |  65 |      0 |       3 |   7.4 |     4 |     0 |    15 |    16 |    5.8 |     0 |    6.3 |   11.6 |       0 | 976.6(04)     |      1 | 1021 |
| 2022-2  | 9434       | 0.4(13)      |     2 |  57 |     0 |     2 |  7.8 | 1002.2(08)     |     9 | 1025.4 | 994.3 |    5.0 | 20.5(02)     |    9.3 |     0 |       0 |     7 | 30/23.9(01)     |      0 |    19 |    74 |     0 |      2 | 0.3(10)      |   408 |  73 |      0 |       0 |   0.8 |     4 |     0 |    17 |     0 |   12.4 |     0 |   10.4 |   15.8 |       0 | 982.3(14)     |      0 | 1632 |

``` r


## Get recorded extreme values of temperature for a station
data_extremes <- aemet_extremes_clim(station, parameter = "T")
knitr::kable(head(data_extremes))
```

| indicativo | nombre               | ubicacion | codigo | temMin | diaMin | anioMin | mesMin | temMax | diaMax | anioMax | mesMax | temMedBaja | anioMedBaja | mesMedBaja | temMedAlta | anioMedAlta | mesMedAlta | temMedMin | anioMedMin | mesMedMin | temMedMax | anioMedMax | mesMedMax |
|:-----------|:---------------------|:----------|:-------|-------:|-------:|--------:|-------:|-------:|-------:|--------:|-------:|-----------:|------------:|-----------:|-----------:|------------:|-----------:|----------:|-----------:|----------:|----------:|-----------:|----------:|
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |   -104 |      4 |    1971 |      2 |    206 |      8 |    2016 |      7 |         29 |        1953 |          2 |         97 |        2016 |          8 |       -12 |       1957 |         2 |       135 |       2016 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |   -114 |      5 |    1963 |      2 |    255 |     27 |    2019 |      7 |         15 |        1956 |          2 |        121 |        1990 |          8 |       -30 |       1956 |         2 |       180 |       1990 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |    -63 |      9 |    1964 |      2 |    287 |     13 |    2023 |      7 |         71 |        1971 |          2 |        147 |        2023 |          8 |        19 |       1973 |         2 |       211 |       2023 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |    -24 |      3 |    1967 |      2 |    324 |      9 |    2011 |      7 |        104 |        1986 |          2 |        174 |        2014 |          8 |        54 |       1970 |         2 |       240 |       2023 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |      5 |      4 |    1967 |      2 |    365 |     29 |    2001 |      7 |        132 |        1984 |          2 |        216 |        2022 |          8 |        85 |       1984 |         2 |       282 |       2022 |         7 |
| 9434       | ZARAGOZA, AEROPUERTO | ZARAGOZA  | 023000 |     52 |     11 |    1971 |      2 |    432 |     29 |    2019 |      7 |        182 |        1953 |          2 |        267 |        2022 |          8 |       126 |       1969 |         2 |       339 |       2022 |         7 |

We can also draw a “warming stripes” graph with the downloaded data from
a weather station. These functions returns `ggplot2` plots:

``` r
# Plot a climate stripes graph for a period of years for a station

library(ggplot2)

climatestripes_station("9434", start = 1980, end = 2020) +
  theme(plot.title = element_text(size = 10))
```

Furthermore, we can draw the well-known Walter & Lieth climatic diagram
for a weather station and over a specified period of time:

``` r
# Plot of a Walter & Lieth climatic diagram (normal climatology values) for a station
climatogram_normal("9434", labels = "en")
```

Additionally, we may be interested in drawing the wind speed and
direction over a period of time for the data downloaded from a weather
station.:

``` r
# Plot a windrose showing the wind speed and direction for a station over a days period.
windrose_days("9434",
  start = "2010-01-01", end = "2020-12-31",
  n_speeds = 5, speed_cuts = c(2.5, 5, 7.5, 10, 12.5, 15)
) +
  theme(plot.title = element_text(size = 10))
```

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

all_stations <- aemet_daily_clim(
  start = "2021-01-08", end = "2021-01-08",
  return_sf = TRUE
)


ggplot(all_stations) +
  geom_sf(aes(colour = tmed), shape = 19, size = 2, alpha = 0.95) +
  labs(
    title = "Average temperature in Spain",
    subtitle = "8 Jan 2021",
    color = "Max temp.\n(celsius)",
    caption = "Source: AEMET"
  ) +
  scale_colour_gradientn(
    colours = hcl.colors(10, "RdBu", rev = TRUE),
    breaks = c(-10, -5, 0, 5, 10, 15, 20),
    guide = "legend"
  ) +
  theme_bw() +
  theme(
    panel.border = element_blank(),
    plot.title = element_text(face = "bold"),
    plot.subtitle = element_text(face = "italic")
  )
```

<img src="man/figures/README-spatial-1.png" width="100%" />

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.

## Citation

Using **climaemet** for a paper you are writing?. Consider citing it:

<p>
Pizarro M, Hernangómez D, Fernández-Avilés G (2021). <em>climaemet:
Climate AEMET Tools</em>.
<a href="https://doi.org/10.5281/zenodo.5205573">doi:10.5281/zenodo.5205573</a>,
<a href="https://hdl.handle.net/10261/250390">https://hdl.handle.net/10261/250390</a>.
</p>

A BibTeX entry for LaTeX users is:

    @Manual{R-climaemet,
      title = {{climaemet}: Climate {AEMET} Tools},
      author = {Manuel Pizarro and Diego Hernangómez and Gema Fernández-Avilés},
      abstract = {The goal of climaemet is to serve as an interface to download the climatic data of the Spanish Meteorological Agency (AEMET) directly from R using their API (https://opendata.aemet.es/) and create scientific graphs (climate charts, trend analysis of climate time series, temperature and precipitation anomalies maps, “warming stripes” graphics, climatograms, etc.).},
      year = {2021},
      month = {8},
      url = {https://hdl.handle.net/10261/250390},
      doi = {10.5281/zenodo.5205573},
      keywords = {Climate, Rcran,  Tools, Graphics, Interpolation, Maps},
    }

## Links

Download from CRAN at <https://cran.r-project.org/package=climaemet>

Browse source code at <https://github.com/ropenspain/climaemet>
