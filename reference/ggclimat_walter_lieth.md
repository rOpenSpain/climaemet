# Walter and Lieth climatic diagram on [ggplot2](https://CRAN.R-project.org/package=ggplot2)

Plot of a Walter and Lieth climatic diagram of a station. This function
is an updated version of
[`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html), by
Jose A. Guijarro.

![\[Experimental\]](figures/lifecycle-experimental.svg)

## Usage

``` r
ggclimat_walter_lieth(
  dat,
  est = "",
  alt = NA,
  per = NA,
  mlab = "es",
  pcol = "#002F70",
  tcol = "#ff0000",
  pfcol = "#9BAEE2",
  sfcol = "#3C6FC4",
  shem = FALSE,
  p3line = FALSE,
  ...
)
```

## Arguments

- dat:

  Monthly climatic data for which the diagram will be plotted.

- est:

  Name of the climatological station.

- alt:

  Altitude of the climatological station.

- per:

  Period on which the averages have been computed.

- mlab:

  Month labels for the X axis. Use 2-digit language code (`"en"`,
  `"es"`, etc.). See
  [`readr::locale()`](https://readr.tidyverse.org/reference/locale.html)
  for info.

- pcol:

  Color for precipitation.

- tcol:

  Color for temperature.

- pfcol:

  Fill color for probable frosts.

- sfcol:

  Fill color for sure frosts.

- shem:

  Set to `TRUE` for southern hemisphere stations.

- p3line:

  Set to `TRUE` to draw a supplementary precipitation line referenced to
  three times the temperature (as suggested by Bogdan Rosca).

- ...:

  Other graphic parameters

## Value

A [ggplot2](https://CRAN.R-project.org/package=ggplot2) object. See
[`help("ggplot2")`](https://ggplot2.tidyverse.org/reference/ggplot2-package.html).

## Details

See Details on
[`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html).

Climatic data must be passed as a 4x12 matrix or `data.frame` of monthly
(January to December) data, in the following order:

- Row 1: Mean precipitation.

- Row 2: Mean maximum daily temperature.

- Row 3: Mean minimum daily temperature.

- Row 4: Absolute monthly minimum temperature.

See
[climaemet_9434_climatogram](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md)
for a sample dataset.

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## References

- Walter, H. K., Harnickell, E., Lieth, F. H. H., & Rehder, H. (1967).
  *Klimadiagramm-weltatlas*. Jena: Fischer, 1967.

## See also

[`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html),
[`readr::locale()`](https://readr.tidyverse.org/reference/locale.html)

Other aemet_plots:
[`climatestripes_station()`](https://ropenspain.github.io/climaemet/reference/climatestripes_station.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`ggstripes()`](https://ropenspain.github.io/climaemet/reference/ggstripes.md),
[`ggwindrose()`](https://ropenspain.github.io/climaemet/reference/ggwindrose.md),
[`windrose_days()`](https://ropenspain.github.io/climaemet/reference/windrose_days.md),
[`windrose_period()`](https://ropenspain.github.io/climaemet/reference/windrose_period.md)

Other climatogram:
[`climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md)

## Examples

``` r
library(ggplot2)

wl <- ggclimat_walter_lieth(
  climaemet::climaemet_9434_climatogram,
  alt = "249",
  per = "1981-2010",
  est = "Zaragoza Airport"
)

wl


# As it is a ggplot object we can modify it

wl + theme(
  plot.background = element_rect(fill = "grey80"),
  panel.background = element_rect(fill = "grey70"),
  axis.text.y.left = element_text(
    colour = "black",
    face = "italic"
  ),
  axis.text.y.right = element_text(
    colour = "black",
    face = "bold"
  )
)
```
