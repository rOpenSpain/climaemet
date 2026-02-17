# Converts `dms` format to decimal degrees

Converts degrees, minutes and seconds to decimal degrees.

## Usage

``` r
dms2decdegrees(input = NULL)

dms2decdegrees_2(input = NULL)
```

## Arguments

- input:

  Character string as `dms` coordinates.

## Value

A numeric value.

## Note

Code for `dms2decdegrees()` modified from project
<https://github.com/SevillaR/aemet>.

## See also

Other helpers:
[`climaemet_news()`](https://ropenspain.github.io/climaemet/reference/climaemet_news.md),
[`first_day_of_year()`](https://ropenspain.github.io/climaemet/reference/day_of_year.md)

## Examples

``` r
dms2decdegrees("055245W")
#> [1] -5.879167
dms2decdegrees_2("-3º 40' 37\"")
#> [1] -3.676944
```
