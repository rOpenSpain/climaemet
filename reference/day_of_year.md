# First and last day of year

Get first and last day of year.

## Usage

``` r
first_day_of_year(year = NULL)

last_day_of_year(year = NULL)
```

## Arguments

- year:

  Numeric value as year (format: YYYY).

## Value

Character string as date (format: YYYY-MM-DD).

## See also

Other helpers:
[`climaemet_news()`](https://ropenspain.github.io/climaemet/reference/climaemet_news.md),
[`dms2decdegrees()`](https://ropenspain.github.io/climaemet/reference/dms2decdegrees.md)

## Examples

``` r
first_day_of_year(2000)
#> [1] "2000-01-01"
last_day_of_year(2020)
#> [1] "2020-12-31"
```
