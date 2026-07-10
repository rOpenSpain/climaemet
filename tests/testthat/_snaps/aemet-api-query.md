# get_data_aemet handles mocked response branches

    Code
      expect_null(get_data_aemet("endpoint"))
    Message
      ! Could not parse JSON. Returning "NULL". Check the response.

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
      > Returning <raw> bytes. See also `base::writeBin()`.

---

    Code
      string <- get_data_aemet("endpoint")
    Message
      i Response MIME type: "text/plain".
      > Returning a UTF-8 <character> string.

---

    Code
      out <- get_data_aemet("endpoint", verbose = TRUE)
    Message
      
      -- climaemet: AEMET OpenData API call ------------------------------------------
      i Using API key "XXXX..._1234567890".
      i Requesting <https://opendata.aemet.es/opendata/endpoint>.
      v HTTP status 200: OK
      
      -- Requesting data --
      
      i Requesting <data-url>.
      v HTTP status 200: OK
      

# get_metadata_aemet handles mocked response branches

    Code
      expect_null(get_metadata_aemet("endpoint"))
    Message
      ! Could not parse JSON. Returning "NULL". Check the response.

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
      i Using API key "XXXX..._1234567890".
      i Requesting <https://opendata.aemet.es/opendata/endpoint>.
      v HTTP status 200: OK
      
      -- Requesting metadata --
      
      i Requesting <metadata-url>.
      v HTTP status 200: OK
      

# aemet_api_call handles mocked HTTP responses

    Code
      expect_null(aemet_api_call("endpoint", apikey = apikey))
    Message
      x HTTP status 404:
        Not here

---

    Code
      expect_null(aemet_api_call("endpoint", apikey = apikey))
    Message
      x HTTP status 418:
        API request failed.

# aemet_api_call validates inputs and updates cached quota

    Code
      response <- aemet_api_call("endpoint", verbose = TRUE, apikey = apikey)
    Message
      i Requesting <https://opendata.aemet.es/opendata/endpoint>.
      v HTTP status 200: OK
      i Remaining request count: "123".
      

