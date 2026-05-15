# Get started with climaemet 1.0.0

Since the last release, this package has been integrated into
[rOpenSpain](https://ropenspain.es/), a community of **R** enthusiasts
whose ultimate goal is to create high-quality **R** packages for data
mining public Spanish open data sources.

As of version **1.0.0**, the package includes improvements and breaking
changes for smoother interaction with the AEMET API service.

## API key

### Get your API key

To download data from AEMET, you need a free API key, which you can get
at <https://opendata.aemet.es/centrodedescargas/altaUsuario>.

Once you have your API key, you can use any of the following methods:

#### a. Set API key with `aemet_api_key()`

This is the recommended option. Just type:

``` r

aemet_api_key("YOUR_API_KEY", install = TRUE)
```

Using `install = TRUE` ensures that the API key is stored on your local
computer and reloaded every time you load the package. From now on, you
can forget about API keys!

#### b. Use an environment variable

This is a temporary alternative. You can set your API key as an
environment variable:

``` r

Sys.setenv(AEMET_API_KEY = "YOUR_API_KEY")
```

Note that this is only valid for the current session. You need to run
this command each time you restart your R session.

#### c. Modify your `.Renviron` file

This stores your API key permanently on your machine. You can start
editing your `.Renviron` file by running this command:

``` r

usethis::edit_r_environ()
```

Now you can add the following line to your `.Renviron` file:

    AEMET_API_KEY=YOUR_API_KEY

## New features

### `tibble` format

From **v1.0.0** onward, **climaemet** returns its results in [**tibble**
format](https://tibble.tidyverse.org/). The functions also try to parse
fields into their correct types. For example, date and hour fields are
parsed as date-time objects and numeric fields as double values.

See how a tibble is displayed:

``` r

# See a tibble in action

aemet_last_obs("9434")
#> # A tibble: 13 × 25
#>    idema   lon fint                 prec   alt  vmax    vv    dv   lat  dmax ubi       pres    hr
#>    <chr> <dbl> <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <chr>    <dbl> <dbl>
#>  1 9434  -1.00 2026-05-14 18:00:00     0   249   8.6   4.3   344  41.7   340 ZARAGOZ…  978.    49
#>  2 9434  -1.00 2026-05-14 19:00:00     0   249   8.7   4.3   334  41.7   345 ZARAGOZ…  978.    53
#>  3 9434  -1.00 2026-05-14 20:00:00     0   249  10.9   6.4   325  41.7   315 ZARAGOZ…  978.    51
#>  4 9434  -1.00 2026-05-14 21:00:00     0   249  10.5   6.2   326  41.7   355 ZARAGOZ…  979.    65
#>  5 9434  -1.00 2026-05-14 22:00:00     0   249   9.5   5.2   300  41.7   313 ZARAGOZ…  979.    70
#>  6 9434  -1.00 2026-05-14 23:00:00     0   249   6.7   4.2   302  41.7   308 ZARAGOZ…  978.    71
#>  7 9434  -1.00 2026-05-15 00:00:00     0   249   6.3   2.7   257  41.7   290 ZARAGOZ…  978.    73
#>  8 9434  -1.00 2026-05-15 01:00:00     0   249   3.6   1.7   234  41.7   260 ZARAGOZ…  977.    78
#>  9 9434  -1.00 2026-05-15 02:00:00     0   249   3.8   2.8   297  41.7   295 ZARAGOZ…  976.    75
#> 10 9434  -1.00 2026-05-15 03:00:00     0   249   6.5   4.7   306  41.7   310 ZARAGOZ…  976.    69
#> 11 9434  -1.00 2026-05-15 04:00:00     0   249  10.4   6.3   316  41.7   305 ZARAGOZ…  976.    68
#> 12 9434  -1.00 2026-05-15 05:00:00     0   249   8.6   5.9   318  41.7   310 ZARAGOZ…  976.    71
#> 13 9434  -1.00 2026-05-15 06:00:00     0   249  11.5   6.5   316  41.7   308 ZARAGOZ…  977.    72
#> # ℹ 12 more variables: stdvv <dbl>, ts <dbl>, pres_nmar <dbl>, tamin <dbl>, ta <dbl>,
#> #   tamax <dbl>, tpr <dbl>, stddv <dbl>, inso <dbl>, tss5cm <dbl>, pacutp <dbl>, tss20cm <dbl>
```

Note that when possible, data representing dates and numbers are
converted to the right format.

### Spatial objects: sf

Another major change in **v1.0.0** is the ability to return information
in spatial **sf** format using `return_sf = TRUE`. The coordinate
reference system (CRS) used is **EPSG 4326**, which corresponds to the
**World Geodetic System (WGS)** and returns coordinates in
latitude/longitude (unprojected coordinates):

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

![Example: Temperature in Spain](./spatial-1.png)

Example: Temperature in Spain

## Further enhancements

Other enhancements included in **v1.0.0**:

- All the functions are now vectorized.
- New function
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).
- New function
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md).
  This function is now the default for `climatogram_*` functions
  [![Experimental](https://ropenspain.github.io/climaemet/reference/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental).
  Old behavior can be reproduced with options `ggplot2 = FALSE`.
- Plot functions gain new arguments (`verbose` and `...`). Now it is
  possible to pass colors to the plotting functions.
- New example datasets:
  [`climaemet::climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
  [`climaemet::climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md)
  and
  [`climaemet::climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md).
