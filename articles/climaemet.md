# Get started with climaemet 1.0.0

Since the last release, this package has been integrated into
[rOpenSpain](https://ropenspain.es/), a community of **R** enthusiasts
whose ultimate goal is to create high-quality **R** packages for data
mining public Spanish open sources.

As of version **1.0.0**, the package includes improvements and breaking
changes for smoother interaction with the AEMET API service.

## API Key

### Get your API Key

To download data from AEMET, you need a free API key, which you can get
at <https://opendata.aemet.es/centrodedescargas/obtencionAPIKey>.

Once you have your API key, you can use any of the following methods:

#### a. Set API Key with `aemet_api_key()`

This is the recommended option. Just type:

``` r
aemet_api_key("YOUR_API_KEY", install = TRUE)
```

Using `install = TRUE` ensures that the API key is stored on your local
computer and it would be reloaded every time you load the library. From
now on you can forget about API keys!

#### b. Use an environment variable

This is a temporary alternative. You can set your API key as an
environment variable

``` r
Sys.setenv(AEMET_API_KEY = "YOUR_API_KEY")
```

Note that this is only valid for the current session. You need to run
this command each time you restart your R session.

#### c. Modify your `.Renviron` file

This stores your API key permanently on your machine. You can start
editing your `.Renviron` running this command:

``` r
usethis::edit_r_environ()
```

Now you can add the following line to your `.Renviron` file:

    AEMET_API_KEY=YOUR_API_KEY

## New features

### `tibble` format

From **v1.0.0** onward, **climaemet** returns its results in [tibble
format](https://tibble.tidyverse.org/). The functions also try to parse
fields into their correct types (for example, date/hour fields are
parsed as date/time objects and numeric fields as double values).

See how a tibble is displayed:

``` r
# See a tibble in action

aemet_last_obs("9434")
#> # A tibble: 12 × 25
#>    idema   lon fint                 prec   alt  vmax    vv    dv   lat  dmax ubi       
#>    <chr> <dbl> <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <chr>     
#>  1 9434  -1.00 2026-03-21 23:00:00     0   249   1.6   0.7   263  41.7   238 ZARAGOZA …
#>  2 9434  -1.00 2026-03-22 00:00:00     0   249   1.8   0.3   183  41.7   263 ZARAGOZA …
#>  3 9434  -1.00 2026-03-22 01:00:00     0   249   1.5   0.8   149  41.7    18 ZARAGOZA …
#>  4 9434  -1.00 2026-03-22 02:00:00     0   249   1.7   0.5   282  41.7   175 ZARAGOZA …
#>  5 9434  -1.00 2026-03-22 03:00:00     0   249   2.5   1.5   287  41.7   260 ZARAGOZA …
#>  6 9434  -1.00 2026-03-22 04:00:00     0   249   2     1.6   218  41.7   208 ZARAGOZA …
#>  7 9434  -1.00 2026-03-22 05:00:00     0   249   1.8   0.9    14  41.7    20 ZARAGOZA …
#>  8 9434  -1.00 2026-03-22 06:00:00     0   249   2.3   0.9   226  41.7   280 ZARAGOZA …
#>  9 9434  -1.00 2026-03-22 07:00:00     0   249   1.7   0.5     7  41.7    13 ZARAGOZA …
#> 10 9434  -1.00 2026-03-22 08:00:00     0   249   1.5   0.4   182  41.7    53 ZARAGOZA …
#> 11 9434  -1.00 2026-03-22 09:00:00     0   249   4.5   3.2   316  41.7   323 ZARAGOZA …
#> 12 9434  -1.00 2026-03-22 10:00:00     0   249   8.8   5.8   292  41.7   283 ZARAGOZA …
#> # ℹ 14 more variables: pres <dbl>, hr <dbl>, stdvv <dbl>, ts <dbl>, pres_nmar <dbl>,
#> #   tamin <dbl>, ta <dbl>, tamax <dbl>, tpr <dbl>, stddv <dbl>, inso <dbl>,
#> #   tss5cm <dbl>, pacutp <dbl>, tss20cm <dbl>
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

![Example: Temperature in Spain](./spatial-1.png)

Example: Temperature in Spain

## Further enhancements

Other enhancements included in the **v1.0.0**:

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
