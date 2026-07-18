# Install an AEMET OpenData API key

Stores an AEMET OpenData API key on your local machine so it can be used
without including it in your code.

## Usage

``` r
aemet_api_key(apikey, overwrite = FALSE, install = FALSE)
```

## Arguments

- apikey:

  A character vector of AEMET OpenData API keys. Acquire a key at
  <https://opendata.aemet.es/centrodedescargas/inicio>. You can install
  multiple API keys at once. See **Details**.

- overwrite:

  A logical value. If `TRUE`, overwrites an existing `AEMET_API_KEY`
  environment variable.

- install:

  A logical value. If `TRUE`, installs the key on your local machine for
  use in future sessions. Defaults to `FALSE`.

## Value

`NULL`, invisibly.

## Details

Alternatively, set the key for the current session with
`Sys.setenv(AEMET_API_KEY = "Your_Key")`, equivalent to
`install = FALSE`. To store it permanently, add
`AEMET_API_KEY = "Your_Key"` to `.Renviron`, equivalent to
`install = TRUE`.

You can pass multiple `apikey` values as a character vector, such as
`c(api1, api2)`. In this case, multiple `AEMET_API_KEY` values are
stored. In each subsequent API call,
[climaemet](https://CRAN.R-project.org/package=climaemet) chooses the
API key with the highest remaining quota.

This is useful when performing batch queries to avoid API throttling.

## Note

To locate the stored API key, run
`tools::R_user_dir("climaemet", "config")`.

## API key

Queries to the AEMET OpenData API require an API key. Use
`aemet_api_key()` to set it globally. Query timeout can be controlled
with `options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

AEMET OpenData API authentication:
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
