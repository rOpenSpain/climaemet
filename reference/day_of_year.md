# First and last day of a year

Returns the first or last calendar day of a year.

## Usage

``` r
first_day_of_year(year = NULL)

last_day_of_year(year = NULL)
```

## Arguments

- year:

  Numeric year in `YYYY` format.

## Value

A character string containing a date in `YYYY-MM-DD` format.

## See also

Helper functions:
[`climaemet_news()`](https://ropenspain.github.io/climaemet/reference/climaemet_news.md),
[`dms2decdegrees()`](https://ropenspain.github.io/climaemet/reference/dms2decdegrees.md)

## Examples

``` r
first_day_of_year(2000)
#> [1] "2000-01-01"
last_day_of_year(2020)
#> [1] "2020-12-31"
```
