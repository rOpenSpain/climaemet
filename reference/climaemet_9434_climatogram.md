# Climatogram data for Zaragoza Airport ("9434") period 1981-2010

Normal data for Zaragoza Airport (1981-2010). This is an example dataset
used to plot climatograms.

## Format

A data.frame with columns 1 to 12 (months) and rows:

- p_mes_md:

  Precipitation (mm).

- tm_max_md:

  Maximum temperature (Celsius).

- tm_min_md:

  Minimum temperature (Celsius).

- ta_min_md:

  Absolute monthly minimum temperature (Celsius).

## Source

AEMET.

## See also

[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md)

Other dataset:
[`aemet_munic`](https://ropenspain.github.io/climaemet/reference/aemet_munic.md),
[`climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md),
[`climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md)

Other climatogram:
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md)

## Examples

``` r
data(climaemet_9434_climatogram)
```
