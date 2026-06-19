# Walter-Lieth climate diagram with [ggplot2](https://CRAN.R-project.org/package=ggplot2)

Plots a Walter-Lieth climate diagram for a station. This function is an
updated version of
[`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html) by
José A. Guijarro.

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

  Monthly climatology data from which to create the diagram.

- est:

  Name of the climatological station.

- alt:

  Altitude of the climatological station.

- per:

  Period used to compute the averages.

- mlab:

  Month labels for the x-axis. Use a two-letter language code, such as
  `"en"` or `"es"`. See
  [`readr::locale()`](https://readr.tidyverse.org/reference/locale.html)
  for details.

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

  Set to `TRUE` to draw a supplementary precipitation line relative to
  three times the temperature (as suggested by Bogdan Rosca).

- ...:

  Further graphic arguments.

## Value

A [ggplot2](https://CRAN.R-project.org/package=ggplot2) object. See
[`help("ggplot2")`](https://ggplot2.tidyverse.org/reference/ggplot2-package.html).

## Details

See the details in
[`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html).

Climatology data must be passed as a 4 by 12 matrix or data frame of
monthly data from January to December. Rows must contain mean
precipitation, mean maximum daily temperature, mean minimum daily
temperature and absolute monthly minimum temperature, in that order.

See
[climaemet_9434_climatogram](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md)
for a sample dataset.

## References

- Walter, H. K., Harnickell, E., Lieth, F. H. H. and Rehder, H. (1967).
  *Klimadiagramm-weltatlas*. Jena: Fischer.

- Guijarro J. A. (2023). *climatol: Climate Tools (Series Homogenization
  and Derived Products)*. R package version 4.0.0,
  <https://climatol.eu>.

## See also

[`climatol::diagwl()`](https://rdrr.io/pkg/climatol/man/diagwl.html) and
[`readr::locale()`](https://readr.tidyverse.org/reference/locale.html).

Walter-Lieth climate diagrams:
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


# Since it is a ggplot object, we can modify it.

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
