# climaemet

The goal of **climaemet** is to provide an interface for downloading
climatic data from the Spanish Meteorological Agency (AEMET) directly in
R and creating scientific visualizations (climate charts, trend analysis
of climate time series, temperature and precipitation anomaly maps,
“warming stripes”, climatograms, etc.).

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

A summary of data usage is:

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
install.packages(
  "climaemet",
  repos = c(
    "https://ropenspain.r-universe.dev",
    "https://cloud.r-project.org"
  )
)
```

Alternatively, you can install the developing version of **climaemet**
with:

``` r
# install.packages("pak")
pak::pak("ropenspain/climaemet")
```

## API key

To download data from AEMET, you need a free API key, which you can get
[here](https://opendata.aemet.es/centrodedescargas/obtencionAPIKey).

``` r
library(climaemet)

## Get api key from AEMET
browseURL("https://opendata.aemet.es/centrodedescargas/obtencionAPIKey")

## Use this function to register your API Key temporarily or permanently
aemet_api_key("MY API KEY")
```

## Changes on v1.0.0!

Now the `apikey` argument in the functions has been deprecated. You may
need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).
Note that you also need to remove the `apikey` argument from old code.

### Now **climaemet** is tidy…

From `v1.0.0` onward, **climaemet** provides its results in [tibble
format](https://tibble.tidyverse.org/). Also, the functions try to guess
the correct format of the fields (i.e. something as a Date/Hour now is
an hour, numbers are parsed as double, etc.).

``` r
library(climaemet)

# See a tibble in action

aemet_last_obs("9434")
#> # A tibble: 12 × 25
#>    idema   lon fint                 prec   alt  vmax    vv    dv   lat  dmax
#>    <chr> <dbl> <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 9434  -1.00 2026-03-21 23:00:00     0   249   1.6   0.7   263  41.7   238
#>  2 9434  -1.00 2026-03-22 00:00:00     0   249   1.8   0.3   183  41.7   263
#>  3 9434  -1.00 2026-03-22 01:00:00     0   249   1.5   0.8   149  41.7    18
#>  4 9434  -1.00 2026-03-22 02:00:00     0   249   1.7   0.5   282  41.7   175
#>  5 9434  -1.00 2026-03-22 03:00:00     0   249   2.5   1.5   287  41.7   260
#>  6 9434  -1.00 2026-03-22 04:00:00     0   249   2     1.6   218  41.7   208
#>  7 9434  -1.00 2026-03-22 05:00:00     0   249   1.8   0.9    14  41.7    20
#>  8 9434  -1.00 2026-03-22 06:00:00     0   249   2.3   0.9   226  41.7   280
#>  9 9434  -1.00 2026-03-22 07:00:00     0   249   1.7   0.5     7  41.7    13
#> 10 9434  -1.00 2026-03-22 08:00:00     0   249   1.5   0.4   182  41.7    53
#> 11 9434  -1.00 2026-03-22 09:00:00     0   249   4.5   3.2   316  41.7   323
#> 12 9434  -1.00 2026-03-22 10:00:00     0   249   8.8   5.8   292  41.7   283
#> # ℹ 15 more variables: ubi <chr>, pres <dbl>, hr <dbl>, stdvv <dbl>, ts <dbl>,
#> #   pres_nmar <dbl>, tamin <dbl>, ta <dbl>, tamax <dbl>, tpr <dbl>,
#> #   stddv <dbl>, inso <dbl>, tss5cm <dbl>, pacutp <dbl>, tss20cm <dbl>
```

### … and spatial!

Another major change in `v1.0.0` is the ability to return information in
spatial `sf` format using `return_sf = TRUE`. The coordinate reference
system (CRS) used is **EPSG 4326**, which corresponds to the **World
Geodetic System (WGS)** and returns coordinates in latitude/longitude
(unprojected coordinates):

``` r
# You would need to install `sf` if not installed yet
# run install.packages("sf") for installation
library(ggplot2)
library(dplyr)

all_stations <- aemet_daily_clim(
  start = "2021-01-08",
  end = "2021-01-08",
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

![Example of map created with climaemet and
sf](reference/figures/README-spatial-1.png)

## Plots

We can also draw a “warming stripes” graph with the downloaded data from
a weather station. These functions return **ggplot2** plots:

``` r
# Plot a climate stripes graph for a period of years for a station

library(ggplot2)

# Example data
temp_data <- climaemet::climaemet_9434_temp

ggstripes(temp_data, plot_title = "Zaragoza Airport") +
  labs(subtitle = "(1950-2020)")
```

![Example of stripe plot created with
climaemet](reference/figures/README-climatestripes-1.png)

Furthermore, we can draw the well-known Walter & Lieth climatic diagram
for a weather station and over a specified period of time:

``` r
# Plot of a Walter & Lieth climatic diagram for a station

# Example data
wl_data <- climaemet::climaemet_9434_climatogram

ggclimat_walter_lieth(
  wl_data,
  alt = "249",
  per = "1981-2010",
  est = "Zaragoza Airport"
)
```

![Plot of a Walter & Lieth climatic diagram for a
station](reference/figures/README-climatogram-1.png)

Additionally, we may be interested in drawing the wind speed and
direction over a period of time for the data downloaded from a weather
station.

``` r
# Plot a windrose showing the wind speed and direction for a station

# Example data
wind_data <- climaemet::climaemet_9434_wind

speed <- wind_data$velmedia
direction <- wind_data$dir

ggwindrose(
  speed = speed,
  direction = direction,
  speed_cuts = seq(0, 16, 4),
  legend_title = "Wind speed (m/s)",
  calm_wind = 0,
  n_col = 1,
  plot_title = "Zaragoza Airport"
) +
  labs(subtitle = "2000-2020", caption = "Source: AEMET")
```

![Plot of a windrose showing the wind speed and
direction](reference/figures/README-windrose-1.png)

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.

## Citation

Using **climaemet** for a paper you are writing?. Consider citing it:

Pizarro M, Hernangómez D, Fernández-Avilés G (2021). *climaemet: Climate
AEMET Tools*.
[doi:10.32614/CRAN.package.climaemet](https://doi.org/10.32614/CRAN.package.climaemet).

A BibTeX entry for LaTeX users is:

``` R
@Manual{R-climaemet,
  title = {{climaemet}: Climate {AEMET} Tools},
  author = {Manuel Pizarro and Diego Hernangómez and Gema Fernández-Avilés},
  abstract = {The goal of climaemet is to serve as an interface to download the climatic data of the Spanish Meteorological Agency (AEMET) directly from R using their API (https://opendata.aemet.es/) and create scientific graphs (climate charts, trend analysis of climate time series, temperature and precipitation anomalies maps, “warming stripes” graphics, climatograms, etc.).},
  year = {2021},
  month = {8},
  doi = {10.32614/CRAN.package.climaemet},
  keywords = {Climate, Rcran,  Tools, Graphics, Interpolation, Maps},
}
```

## Links

- Download from CRAN at <https://cran.r-project.org/package=climaemet>
- Browse source code at <https://github.com/ropenspain/climaemet>
