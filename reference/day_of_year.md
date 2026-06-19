# First and last day of a year

Returns the first or last calendar day of a year.

## Usage

``` r
first_day_of_year(year = NULL)

last_day_of_year(year = NULL)
```

## Arguments

- year:

  A numeric year in `YYYY` format.

## Value

A character string containing a date in `YYYY-MM-DD` format.

## Examples

``` r
first_day_of_year(2000)
#> [1] "2000-01-01"
last_day_of_year(2020)
#> [1] "2020-12-31"
```
