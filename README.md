# climaemet (R Climate AEMET Tools)

# <img src='man/figures/logo.png' align="right" height="200" />

## Author
Manuel Pizarro (http://www.ipe.csic.es/)

## Description

The goal of "climaemet" is to serve as an interface to download the climatic data of the Spanish Meteorological Agency (AEMET) directly from R using their API (https://opendata.aemet.es/) and create scientific graphs.

## AEMET Open Data

AEMET OpenData is a REST API developed by AEMET that allows the dissemination and reuse of the Agency's meteorological and climatological information. To see more details visit: https://opendata.aemet.es/centrodedescargas/inicio

## License for the original data

Information prepared by the Spanish Meteorological Agency (© AEMET). You can read about it here (in spanish): http://www.aemet.es/es/nota_legal

A summary for the usage of the data could be interpreted as:

People can use freely this data. You should mention AEMET as the collector of the original data in every situation except if you are using this data privately and individually. AEMET makes no warranty as to the accuracy or completeness of the data. All data are provided on an "as is" basis. AEMET is not responsible for any damage or loss derived from the interpretation or use of this data.

## Installation

You can install the released version of climaemet from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("climaemet")
```

## Requirements

To be able to download data from AEMET you will need a free API key which you can get at https://opendata.aemet.es/centrodedescargas/obtencionAPIKey

## Examples

These are basic examples to obtain data from the AEMET Open Data API:

``` r
library(climaemet)

## Get api key from AEMET
browseURL("https://opendata.aemet.es/centrodedescargas/obtencionAPIKey")

## Get AEMET stations
stations <- aemet_stations(apikey)
View(stations)
station <- "9434" # Zaragoza Aeropuerto

## Get last observation values for a station
data_observation <- aemet_last_obs(station, apikey)

## Get normal climatology values for a station
data_normal <- aemet_normal_clim(station, apikey)

## Get daily climatology values for a station
data_daily <- aemet_daily_clim(station, apikey, "2000-01-01", "2000-12-31")

## Get monthly/annual climatology values for a station
data_monthly <- aemet_monthly_clim(station, apikey, "2000")

## Get recorded extreme values of temperature for a station
data_extremes <- aemet_extremes_clim(station, apikey, "T")

## Get normal climatology values for all stations
data_normal_clim_all <- aemet_normal_clim_all(apikey)

## Get monthly climatology values for a period of years for a station
data_monthly_period_station <- aemet_monthly_period(station, apikey, start = 2018, end = 2019)

## Get monthly climatology values for a period of years for all stations
data_monthly_period_all <- aemet_monthly_period_all(apikey, start = 2020, end = 2020)

# Get daily climatology values for a period of years for a station
aemet_daily_period(station, apikey, 2000, 2010)

# Get daily climatology values for a period of years for all stations
aemet_daily_period_all(apikey, 2000, 2010)

# Plot a climate stripes graph for a period of years for a station
ggstripes_station(station, apikey, start = 1950, end = 2020)

# Plot a climate stripes background image for a period of years for a station
ggstripes_station(station, apikey, with_labels = "no")

# Save plot
ggsave(plot = last_plot(), filename ="climate_stripes.jpeg", "jpeg", scale = 1, width = 420, height = 297, units = "mm", dpi = 300)
```

## Code of Conduct
Please note that the usethis project is released with a Contributor Code of Conduct. By contributing to this project, you agree to abide by its terms.

## Links
Download from CRAN at
https://cloud.r-project.org/package=climaemet

Browse source code at
https://github.com/mpizarrotig/climaemet/

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/climaemet)](https://CRAN.R-project.org/package=climaemet)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
<!-- badges: end -->
