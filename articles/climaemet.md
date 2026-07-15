# Get started with climaemet

**climaemet** provides access to meteorological observations, forecasts,
alerts and climatology data from the Spanish Meteorological Agency
(AEMET). It is part of [rOpenSpain](https://ropenspain.es/), a community
that develops **R** packages for working with Spanish public data.

## API key

### Get an API key

To download data from AEMET, obtain a free API key from the [AEMET
OpenData registration
page](https://opendata.aemet.es/centrodedescargas/altaUsuario).

Once you have your API key, you can use any of the following methods:

#### Set the API key with `aemet_api_key()`

This is the recommended option. Run:

``` r

aemet_api_key("YOUR_API_KEY", install = TRUE)
```

Using `install = TRUE` stores the API key on your local computer so it
is available in future **R** sessions.

#### Use an environment variable

Alternatively, set the API key as an environment variable for the
current session:

``` r

Sys.setenv(AEMET_API_KEY = "YOUR_API_KEY")
```

You need to run this command again after restarting **R**.

#### Modify your `.Renviron` file

You can also store the API key permanently in `.Renviron`. Open the file
with:

``` r

usethis::edit_r_environ()
```

Then add the following line:

    AEMET_API_KEY=YOUR_API_KEY

## Data formats

### Tabular results

**climaemet** returns tabular results as [**tibble**
objects](https://tibble.tidyverse.org/). The package also infers column
types when possible. For example, date and time columns are parsed as
date-time objects and numeric columns are parsed as doubles.

The following call returns a tibble:

``` r

# Inspect a tibble.

aemet_last_obs("9434")
#> # A tibble: 12 × 25
#>    idema   lon fint                 prec   alt  vmax    vv    dv   lat  dmax
#>    <chr> <dbl> <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 9434  -1.00 2026-07-15 03:00:00     0   249   2.8   1.2    85  41.7    93
#>  2 9434  -1.00 2026-07-15 04:00:00     0   249   2.4   1.2    95  41.7    75
#>  3 9434  -1.00 2026-07-15 05:00:00     0   249   2.4   1.4   284  41.7   268
#>  4 9434  -1.00 2026-07-15 06:00:00     0   249   2.2   0.8    46  41.7   250
#>  5 9434  -1.00 2026-07-15 07:00:00     0   249   2.7   1.5    79  41.7    90
#>  6 9434  -1.00 2026-07-15 08:00:00     0   249   2.7   0.9    28  41.7   118
#>  7 9434  -1.00 2026-07-15 09:00:00     0   249   3     1.2   124  41.7    78
#>  8 9434  -1.00 2026-07-15 10:00:00     0   249   2.9   1.1    59  41.7   340
#>  9 9434  -1.00 2026-07-15 11:00:00     0   249   7.9   4.5   304  41.7   313
#> 10 9434  -1.00 2026-07-15 12:00:00     0   249   8.6   3.2   320  41.7   288
#> 11 9434  -1.00 2026-07-15 13:00:00     0   249   9.8   5.2   255  41.7   255
#> 12 9434  -1.00 2026-07-15 14:00:00     0   249   7.4   3.4   111  41.7   245
#> # ℹ 15 more variables: ubi <chr>, pres <dbl>, hr <dbl>, stdvv <dbl>, ts <dbl>,
#> #   pres_nmar <dbl>, tamin <dbl>, ta <dbl>, tamax <dbl>, tpr <dbl>,
#> #   stddv <dbl>, inso <dbl>, tss5cm <dbl>, pacutp <dbl>, tss20cm <dbl>
```

### Spatial objects with **sf**

Data-access functions that support `return_sf = TRUE` can return spatial
**sf** objects. These objects use the EPSG:4326 coordinate reference
system (CRS), corresponding to the World Geodetic System 1984 (WGS 84),
with unprojected longitude and latitude coordinates:

``` r

# You need to install sf if it is not already installed.
# Run install.packages("sf") to install it.

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

![Example: temperature in Spain](./spatial-1.png)

Example: temperature in Spain

## Additional features

Other package features include:

- Data functions accept vector inputs where the AEMET OpenData API
  supports them.
- [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  retrieves metadata from arbitrary AEMET OpenData API endpoints.
- [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)
  creates Walter-Lieth climate diagrams and is the default plotting
  method used by
  [`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md)
  and
  [`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md).
  [![Experimental](https://ropenspain.github.io/climaemet/reference/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental).
  Set `ggplot2 = FALSE` to use
  [`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html)
  instead.
- Plotting functions accept additional options through `...`.
- The example datasets `climaemet_9434_climatogram`,
  `climaemet_9434_temp` and `climaemet_9434_wind` support the plotting
  examples.
