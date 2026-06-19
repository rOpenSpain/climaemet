# Check for an AEMET API key

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

`TRUE` if an API key is available and `FALSE` otherwise.
`aemet_show_api_key()` displays stored API keys.

## See also

AEMET API authentication:
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)

## Examples

``` r

aemet_detect_api_key()
#> [1] TRUE

# CAUTION: This may reveal API keys.
if (FALSE) {
  aemet_show_api_key()
}
```
