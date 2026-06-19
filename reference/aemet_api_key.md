# Install an AEMET API key

Stores an AEMET API key on your local machine so it can be used without
including it in your code.

Alternatively, set the key for the current session with
`Sys.setenv(AEMET_API_KEY = "Your_Key")`, equivalent to
`install = FALSE`. To store it permanently, add
`AEMET_API_KEY = "Your_Key"` to `.Renviron`, equivalent to
`install = TRUE`.

## Usage

``` r
aemet_api_key(apikey, overwrite = FALSE, install = FALSE)
```

## Arguments

- apikey:

  Character vector of AEMET API keys. A key can be acquired at
  <https://opendata.aemet.es/centrodedescargas/inicio>. You can install
  multiple API keys at once. See **Details**.

- overwrite:

  Logical. If `TRUE`, overwrites an existing `AEMET_API_KEY` environment
  variable.

- install:

  Logical. If `TRUE`, installs the key on your local machine for use in
  future sessions. Defaults to `FALSE`.

## Value

`NULL`, invisibly.

## Details

You can pass multiple `apikey` values as a character vector
`c(api1, api2)`. In this case, multiple `AEMET_API_KEY` values are
stored. In each subsequent API call,
[climaemet](https://CRAN.R-project.org/package=climaemet) chooses the
API key with the highest remaining quota.

This is useful when performing batch queries to avoid API throttling.

## Note

To locate the stored API key, run
`tools::R_user_dir("climaemet", "config")`.

## See also

AEMET API authentication:
[`aemet_detect_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_detect_api_key.md)

## Examples

``` r
# Do not run these examples.

if (FALSE) {
  aemet_api_key("111111abc", install = TRUE)

  # Check it with:
  Sys.getenv("AEMET_API_KEY")
}

if (FALSE) {
  # Overwrite an existing key:
  aemet_api_key("222222abc", overwrite = TRUE, install = TRUE)

  # Check it with:
  Sys.getenv("AEMET_API_KEY")
}
```
