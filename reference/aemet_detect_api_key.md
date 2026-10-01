# Check for an AEMET OpenData API key

Detects whether an API key is available in the current session. An
existing environment variable is preserved. Otherwise, a key stored
permanently with
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
is loaded.

## Usage

``` r
aemet_detect_api_key(...)

aemet_show_api_key(...)
```

## Arguments

- ...:

  Ignored.

## Value

`aemet_detect_api_key()` returns a
[logical](https://rdrr.io/r/base/logical.html) value, `TRUE` if an API
key is available and `FALSE` otherwise. `aemet_show_api_key()` returns a
[character](https://rdrr.io/r/base/character.html) vector containing the
available API keys.

## See also

AEMET OpenData API functions:
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md),
[`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)

## Examples

``` r

aemet_detect_api_key()
#> [1] TRUE

# Caution: This may reveal API keys.
if (FALSE) {
  aemet_show_api_key()
}
```
