# Install an AEMET API Key

This function will store your AEMET API key on your local machine so it
can be called securely without being stored in your code.

Alternatively, you can install the API Key manually:

- Run `Sys.setenv(AEMET_API_KEY = "Your_Key")`. You would need to run
  this command on each session (Similar to `install = FALSE`).

- Write this line on your .Renviron file: `AEMET_API_KEY = "Your_Key"`
  (same behavior than `install = TRUE`). This would store your API key
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
  several API Keys as a vector of characters, see **Details**.

- overwrite:

  If this is set to `TRUE`, it will overwrite an existing
  `AEMET_API_KEY` that you already have in local machine.

- install:

  if `TRUE`, will install the key in your local machine for use in
  future sessions. Defaults to `FALSE.`

## Value

None

## Details

You can pass several `apikey` values as a vector `c(api1, api2)`, in
this case several `AEMET_API_KEY` values would be generated. In each
subsequent api call
[climaemet](https://CRAN.R-project.org/package=climaemet) would choose
the API Key with the highest remaining quota.

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
