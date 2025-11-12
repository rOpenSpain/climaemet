# Check if an AEMET API Key is present for the current session

The function would detect if an API Key is available on this session:

- If an API Key is already set as an environment variable it would be
  preserved

- If no environment variable has been set and you have stored
  permanently an API Key using
  [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md),
  the latter would be loaded.

## Usage

``` r
aemet_detect_api_key(...)

aemet_show_api_key(...)
```

## Arguments

- ...:

  Ignored

## Value

`TRUE` or `FALSE`. `aemet_show_api_key()` would display your stored API
keys.

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
