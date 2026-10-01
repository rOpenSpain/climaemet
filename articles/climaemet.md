# Get started with climaemet

**climaemet** provides access to meteorological observations, forecasts,
alerts and climatology data from the Spanish Meteorological Agency
(AEMET). It is part of [rOpenSpain](https://ropenspain.es/), a community
that develops **R** packages for working with Spanish public data.

## API key

### Get an API key

To download data from AEMET, obtain a free API key from the [**AEMET
OpenData** registration
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
#>    idema   lon fint                 prec   alt  vmax    vv    dv   lat  dmax ubi    
#>    <chr> <dbl> <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <chr>  
#>  1 9434  -1.00 2026-10-01 08:00:00     0   249  11.2   8.7   306  41.7   305 ZARAGO…
#>  2 9434  -1.00 2026-10-01 09:00:00     0   249  12.8   6.6   314  41.7   308 ZARAGO…
#>  3 9434  -1.00 2026-10-01 10:00:00     0   249  11.6   8.6   309  41.7   308 ZARAGO…
#>  4 9434  -1.00 2026-10-01 11:00:00     0   249  11.3   7.1   317  41.7   318 ZARAGO…
#>  5 9434  -1.00 2026-10-01 12:00:00     0   249  10.9   8.7   307  41.7   300 ZARAGO…
#>  6 9434  -1.00 2026-10-01 13:00:00     0   249  11.2   6.7   312  41.7   300 ZARAGO…
#>  7 9434  -1.00 2026-10-01 14:00:00     0   249  10.1   5.9   319  41.7   305 ZARAGO…
#>  8 9434  -1.00 2026-10-01 15:00:00     0   249  10.5   6.4   313  41.7   315 ZARAGO…
#>  9 9434  -1.00 2026-10-01 16:00:00     0   249   8.4   6     315  41.7   300 ZARAGO…
#> 10 9434  -1.00 2026-10-01 17:00:00     0   249   9.7   6.2   313  41.7   305 ZARAGO…
#> 11 9434  -1.00 2026-10-01 18:00:00     0   249   8.5   6.1   306  41.7   310 ZARAGO…
#> 12 9434  -1.00 2026-10-01 19:00:00     0   249  10.4   5.9   310  41.7   308 ZARAGO…
#> # ℹ 14 more variables: pres <dbl>, hr <dbl>, stdvv <dbl>, ts <dbl>,
#> #   pres_nmar <dbl>, tamin <dbl>, ta <dbl>, tamax <dbl>, tpr <dbl>, stddv <dbl>,
#> #   inso <dbl>, tss5cm <dbl>, pacutp <dbl>, tss20cm <dbl>
```

### Spatial objects with sf

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
    color = "Mean temp.\n(°C)",
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

![Point map of AEMET weather stations in Spain on 8 January 2021.
Longitude and latitude locate each station, with blue indicating lower
mean temperatures and red indicating higher temperatures, in degrees
Celsius. Inland stations are generally colder than southern coastal
stations and those in the Canary Islands. ](./spatial-1.png)

Example: temperature in Spain

## Additional features

Other package features include:

- Data functions accept vector inputs where the **AEMET OpenData API**
  supports them.
- [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
  retrieves metadata from arbitrary **AEMET OpenData API** endpoints.
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
