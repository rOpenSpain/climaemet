# Check if an AEMET API Key is present for the current session

Detects whether an API key is available in the current session:

- If an API key is already set as an environment variable, it is
  preserved.

- If no environment variable is set and an API key has been stored
  permanently via
  [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md),
  it is loaded.

## Usage

``` r
aemet_detect_api_key(...)

aemet_show_api_key(...)
```

## Arguments

- ...:

  Ignored.

## Value

`TRUE` or `FALSE`. `aemet_show_api_key()` displays your stored API keys.

## See also

Other aemet_auth:
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)

## Examples

``` r
aemet_detect_api_key()
#> [1] TRUE

# CAUTION: This may reveal API Keys
if (FALSE) {
  aemet_show_api_key()
}
```
