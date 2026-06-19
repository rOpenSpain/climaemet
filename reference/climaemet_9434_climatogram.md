# Climatological normals for Zaragoza Airport ("9434"), 1981–2010

Climatological normal data for Zaragoza Airport (1981–2010). This
example dataset is used to create Walter-Lieth climate diagrams.

## Format

A data frame with four rows and 12 columns. Columns `1` through `12`
represent months from January through December. Rows contain:

- `p_mes_md`: precipitation (mm).

- `tm_max_md`: maximum temperature (Celsius).

- `tm_min_md`: minimum temperature (Celsius).

- `ta_min_min`: absolute monthly minimum temperature (Celsius).

## Source

AEMET.

## See also

[`ggclimat_walter_lieth()`](https://ropenspain.github.io/climaemet/reference/ggclimat_walter_lieth.md),
[`climatogram_period()`](https://ropenspain.github.io/climaemet/reference/climatogram_period.md),
[`climatogram_normal()`](https://ropenspain.github.io/climaemet/reference/climatogram_normal.md).

## Examples

``` r
data(climaemet_9434_climatogram)
```
