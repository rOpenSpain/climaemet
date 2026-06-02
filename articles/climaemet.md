# Get started with climaemet 1.0.0

Since the last release, this package has been integrated into
[rOpenSpain](https://ropenspain.es/), a community of **R** enthusiasts
whose ultimate goal is to create high-quality **R** packages for working
with public Spanish open data sources.

As of version 1.0.0, the package includes improvements and breaking
changes for smoother interaction with the AEMET API.

## API key

### Get your API key

To download data from AEMET, you need a free API key, which you can get
at <https://opendata.aemet.es/centrodedescargas/altaUsuario>.

Once you have your API key, you can use any of the following methods:

#### a. Set API key with `aemet_api_key()`

This is the recommended option. Run:

``` r

aemet_api_key("YOUR_API_KEY", install = TRUE)
```

Using `install = TRUE` stores the API key on your local computer and
reloads it each time you load the package.

#### b. Use an environment variable

This is a temporary alternative. You can set your API key as an
environment variable:

``` r

Sys.setenv(AEMET_API_KEY = "YOUR_API_KEY")
```

Note that this is valid only for the current session. You need to run
this command each time you restart your **R** session.

#### c. Modify your `.Renviron` file

This stores your API key permanently on your machine. Start editing your
`.Renviron` file with:

``` r

usethis::edit_r_environ()
```

Now you can add the following line to your `.Renviron` file:

    AEMET_API_KEY=YOUR_API_KEY

## New features

### `tibble` format

From version 1.0.0 onward, **climaemet** returns its results in
[**tibble** format](https://tibble.tidyverse.org/). The functions also
try to parse fields into their correct types. For example, date and hour
fields are parsed as date-time objects and numeric fields as double
values.

See how a tibble is displayed:

``` r

# See a tibble in action

aemet_last_obs("9434")
#> # A tibble: 12 × 25
#>    idema   lon fint                 prec   alt  vmax    vv    dv   lat  dmax
#>    <chr> <dbl> <dttm>              <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 9434  -1.00 2026-06-01 12:00:00     0   249   6.6   1.3   303  41.7   305
#>  2 9434  -1.00 2026-06-01 13:00:00     0   249   4     1.3   259  41.7   320
#>  3 9434  -1.00 2026-06-01 14:00:00     0   249   3.7   1.7    78  41.7   308
#>  4 9434  -1.00 2026-06-01 15:00:00     0   249   4.3   2.6    79  41.7   103
#>  5 9434  -1.00 2026-06-01 16:00:00     0   249   4.8   2.9   129  41.7   125
#>  6 9434  -1.00 2026-06-01 17:00:00     0   249   4.4   1.8   124  41.7    98
#>  7 9434  -1.00 2026-06-01 18:00:00     0   249   3.5   1.5   249  41.7    80
#>  8 9434  -1.00 2026-06-01 19:00:00     0   249   4.5   2.9   328  41.7   313
#>  9 9434  -1.00 2026-06-01 20:00:00     0   249   4.2   2.5   319  41.7   325
#> 10 9434  -1.00 2026-06-01 21:00:00     0   249   3.3   2.1   293  41.7   243
#> 11 9434  -1.00 2026-06-01 22:00:00     0   249   7.6   3.9   313  41.7   293
#> 12 9434  -1.00 2026-06-01 23:00:00     0   249   6.3   4.1   318  41.7   323
#> # ℹ 15 more variables: ubi <chr>, pres <dbl>, hr <dbl>, stdvv <dbl>, ts <dbl>,
#> #   pres_nmar <dbl>, tamin <dbl>, ta <dbl>, tamax <dbl>, tpr <dbl>,
#> #   stddv <dbl>, inso <dbl>, tss5cm <dbl>, pacutp <dbl>, tss20cm <dbl>
```

When possible, data representing dates and numbers are converted to the
appropriate type.

### Spatial objects with sf

Another major change in version 1.0.0 is the ability to return
information in spatial **sf** format using `return_sf = TRUE`. The
coordinate reference system (CRS) used is **EPSG:4326**, which
corresponds to the **World Geodetic System 1984 (WGS 84)** and returns
coordinates in latitude/longitude (unprojected coordinates):

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

## Further enhancements

Other enhancements included in version 1.0.0:

- Data functions are now vectorized where the AEMET API supports it.
- New function
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).
- New function
  [`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md).
  It is now the default for `climatogram_*` functions
  [![Experimental](https://ropenspain.github.io/climaemet/reference/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental).
  Old behavior can be reproduced with options `ggplot2 = FALSE`.
- Plot functions gain new arguments (`verbose` and `...`). Colors can
  now be passed to the plotting functions.
- New example datasets:
  [`climaemet::climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
  [`climaemet::climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md)
  and
  [`climaemet::climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md).
