# Install an AEMET API Key

This function will store your AEMET API key on your local machine so it
can be called securely without being stored in your code.

Alternatively, you can install the API key manually:

- Run `Sys.setenv(AEMET_API_KEY = "Your_Key")`. You will need to run
  this command in each session (similar to `install = FALSE`).

- Write this line in your .Renviron file: `AEMET_API_KEY = "Your_Key"`
  (same behavior as `install = TRUE`). This stores your API key
  permanently.

## Usage

``` r
aemet_api_key(apikey, overwrite = FALSE, install = FALSE)
```

## Arguments

- apikey:

  The API key provided to you from the AEMET formatted in quotes. A key
  can be acquired at
  <https://opendata.aemet.es/centrodedescargas/inicio>. You can install
  several API keys as a character vector; see **Details**.

- overwrite:

  If `TRUE`, overwrites an existing `AEMET_API_KEY` already set on your
  local machine.

- install:

  If `TRUE`, installs the key on your local machine for use in future
  sessions. Defaults to `FALSE`.

## Value

Invisibly returns `NULL`.

## Details

You can pass several `apikey` values as a character vector
`c(api1, api2)`; in this case, multiple `AEMET_API_KEY` values are
generated. In each subsequent API call,
[climaemet](https://CRAN.R-project.org/package=climaemet) chooses the
API key with the highest remaining quota.

This is useful when performing batch queries to avoid API throttling.

## Note

To locate your API Key on your local machine, run
`rappdirs::user_cache_dir("climaemet", "R")`.

## See also

Other aemet_auth:
[`aemet_detect_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_detect_api_key.md)

## Examples

``` r
# Don't run these examples!

if (FALSE) {
  aemet_api_key("111111abc", install = TRUE)

  # You can check it with:
  Sys.getenv("AEMET_API_KEY")
}

if (FALSE) {
  # If you need to overwrite an existing key:
  aemet_api_key("222222abc", overwrite = TRUE, install = TRUE)

  # You can check it with:
  Sys.getenv("AEMET_API_KEY")
}
```
