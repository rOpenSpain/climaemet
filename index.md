# climaemet

The goal of **climaemet** is to provide an interface for downloading
climatic data from the Spanish Meteorological Agency (AEMET) directly in
R and creating scientific visualizations (climate charts, trend analysis
of climate time series, temperature and precipitation anomaly maps,
“warming stripes”, climatograms, etc.).

Browse the manual and vignettes at
<https://ropenspain.github.io/climaemet/>.

## AEMET Open Data

AEMET OpenData is a REST API developed by AEMET for disseminating and
reusing the agency’s meteorological and climatological information. For
more details, visit
<https://opendata.aemet.es/centrodedescargas/inicio>.

## License for the original data

Information prepared by the Spanish Meteorological Agency (© AEMET). You
can read about it [here](https://www.aemet.es/en/nota_legal).

A summary of data usage is:

> People can use these data freely. You should mention AEMET as the
> collector of the original data in every situation except when you are
> using these data privately and individually. AEMET makes no warranty
> as to the accuracy or completeness of the data. All data are provided
> on an “as is” basis. AEMET is not responsible for any damage or loss
> derived from the interpretation or use of these data.

## Installation

You can install the released version of **climaemet** from
[CRAN](https://CRAN.R-project.org) with:

``` r

install.packages("climaemet")
```

You can install the development version of **climaemet** using the
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

Alternatively, you can install the development version of **climaemet**
with:

``` r

# install.packages("pak")
pak::pak("ropenspain/climaemet")
```

## API key

To download data from AEMET, you need a free API key, which you can get
[here](https://opendata.aemet.es/centrodedescargas/altaUsuario).

``` r

library(climaemet)

## Get API key from AEMET.
browseURL("https://opendata.aemet.es/centrodedescargas/altaUsuario")

## Use this function to register your API key temporarily or permanently.
aemet_api_key("MY API KEY")
```

## Changes in v1.0.0

The `apikey` argument in the functions is now deprecated. You may need
to set your API key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).
Note that you also need to remove the `apikey` argument from old code.

### Now **climaemet** is tidy…

From `v1.0.0` onward, **climaemet** provides its results in [**tibble**
format](https://tibble.tidyverse.org/). The functions also try to infer
the correct format of fields. For example, date and hour fields are
parsed as date-time objects and numeric fields are parsed as doubles.

``` r

library(climaemet)

# See a tibble in action

aemet_last_obs("9434")
#> # A tibble: 12 × 25
#>    idema   lon fint                 prec   alt  vmax    vv    dv   lat  dmax
#>    <chr> <dbl> <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 9434  -1.00 2026-05-18 07:00:00     0   249   5.8   4.1   301  41.7   290
#>  2 9434  -1.00 2026-05-18 08:00:00     0   249   7     3.3   310  41.7   245
#>  3 9434  -1.00 2026-05-18 09:00:00     0   249   5.2   2.6   321  41.7   313
#>  4 9434  -1.00 2026-05-18 10:00:00     0   249   3.9   0.9   174  41.7   313
#>  5 9434  -1.00 2026-05-18 11:00:00     0   249   2.8   1.2    32  41.7   285
#>  6 9434  -1.00 2026-05-18 12:00:00     0   249   3.7   1.9    97  41.7    83
#>  7 9434  -1.00 2026-05-18 13:00:00     0   249   3.8   1.3    31  41.7    65
#>  8 9434  -1.00 2026-05-18 14:00:00     0   249   4.8   2.1    80  41.7    63
#>  9 9434  -1.00 2026-05-18 15:00:00     0   249   4.3   1.7   337  41.7    70
#> 10 9434  -1.00 2026-05-18 16:00:00     0   249   5.4   2.1   328  41.7   298
#> 11 9434  -1.00 2026-05-18 17:00:00     0   249   6.5   4.6   324  41.7   330
#> 12 9434  -1.00 2026-05-18 18:00:00     0   249   6.8   3.3   326  41.7   310
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

# You need to install `sf` if it is not already installed.
# Run install.packages("sf") for installation.
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

You can also draw a “warming stripes” graph with the downloaded data
from a weather station. These functions return **ggplot2** plots:

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

You can also draw the well-known Walter & Lieth climatic diagram for a
weather station and over a specified period of time:

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

Additionally, you can plot wind speed and direction over time for
weather station data.

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

Using **climaemet** for a paper you are writing? Consider citing it:

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
