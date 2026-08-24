# cache_apikeys rejects missing configured keys

    Code
      cache_apikeys("noexist.rds")
    Condition
      Error in `cache_apikeys()`:
      ! Configure a valid API key with `climaemet::aemet_api_key()`.

# get_data_aemet rejects requests without an API key

    Code
      get_data_aemet(apidest = "testing")
    Condition
      Error in `get_data_aemet()`:
      ! Configure an API key with `climaemet::aemet_api_key()`.

# get_data_aemet parses JSON, text, and raw responses

    Code
      expect_null(get_data_aemet("endpoint"))
    Message
      ! Could not parse JSON. Returning `NULL`. Check the response.

---

    Code
      expect_null(get_data_aemet("endpoint"))
    Message
      ! The AEMET OpenData API request returned no body. Skipping <endpoint>.

---

    Code
      raw <- get_data_aemet("endpoint")
    Message
      i Response MIME type: "image/gif".
      > Returning `raw` bytes. See also `base::writeBin()`.

---

    Code
      string <- get_data_aemet("endpoint")
    Message
      i Response MIME type: "text/plain".
      > Returning a UTF-8 `character` string.

---

    Code
      out <- get_data_aemet("endpoint", verbose = TRUE)
    Message
      
      -- climaemet: AEMET OpenData API call ------------------------------------------
      i Using API key "XXXX...7890".
      i Requesting <https://opendata.aemet.es/opendata/endpoint>.
      v HTTP status 200: OK
      
      -- Requesting data --
      
      i Requesting <data-url>.
      v HTTP status 200: OK
      

# get_metadata_aemet rejects requests without an API key

    Code
      get_metadata_aemet("endpoint")
    Condition
      Error in `get_metadata_aemet()`:
      ! Configure an API key with `climaemet::aemet_api_key()`.

# get_metadata_aemet parses JSON, text, and raw responses

    Code
      expect_null(get_metadata_aemet("endpoint"))
    Message
      ! Could not parse JSON. Returning `NULL`. Check the response.

---

    Code
      expect_null(get_metadata_aemet("endpoint"))
    Message
      ! The AEMET OpenData API request returned no body. Skipping <endpoint>.

---

    Code
      meta <- get_metadata_aemet("endpoint", verbose = TRUE)
    Message
      
      -- climaemet: AEMET OpenData API call ------------------------------------------
      i Using API key "XXXX...7890".
      i Requesting <https://opendata.aemet.es/opendata/endpoint>.
      v HTTP status 200: OK
      
      -- Requesting metadata --
      
      i Requesting <metadata-url>.
      v HTTP status 200: OK
      

# aemet_api_call handles success and HTTP error statuses

    Code
      aemet_api_call("endpoint", apikey = apikey)
    Message
      x The API key is not valid. Try a new one.
    Condition
      Error in `aemet_api_call()`:
      ! HTTP 401 Unauthorized.

---

    Code
      expect_null(aemet_api_call("endpoint", apikey = apikey))
    Message
      x HTTP status 404:
        Not here

---

    Code
      aemet_api_call("endpoint", apikey = apikey)
    Message
      ! HTTP status 429:
        API rate limit reached.
      i Retrying.
      x The API key is not valid. Try a new one.
    Condition
      Error in `aemet_api_call()`:
      ! HTTP 401 Unauthorized.
    Message
      

---

    Code
      expect_null(aemet_api_call("endpoint", apikey = apikey))
    Message
      x HTTP status 418:
        API request failed.

# aemet_api_call rejects missing keys and stores remaining quota

    Code
      aemet_api_call(apidest = "fake")
    Condition
      Error in `aemet_api_call()`:
      ! `apikey` cannot be `NULL`.

---

    Code
      response <- aemet_api_call("endpoint", verbose = TRUE, apikey = apikey)
    Message
      i Requesting <https://opendata.aemet.es/opendata/endpoint>.
      v HTTP status 200: OK
      i Remaining request count: "123".
      

