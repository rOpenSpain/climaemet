# Manual request

    Code
      aemet_api_call(apidest = "fake")
    Condition
      Error in `aemet_api_call()`:
      ! `apikey` can't be NULL.

---

    Code
      aemet_api_call(entry, apikey = "FAKEONE")
    Message
      x API key invalido
    Condition
      Error in `aemet_api_call()`:
      ! HTTP 401 Unauthorized.

---

    Code
      aemet_api_call(paste0("https://opendata.aemet.es/opendata/", entry), data_call = TRUE,
      verbose = TRUE, apikey = "FAKEONE")
    Message
      i Requesting <https://opendata.aemet.es/opendata/api/valores/climatologicos/inventarioestaciones/todasestaciones>
      x API key invalido
    Condition
      Error in `aemet_api_call()`:
      ! HTTP 401 Unauthorized.

---

    Code
      n <- aemet_api_call(paste0("https://opendata.aemet.es/opendata/", entry,
        "/fake"), data_call = TRUE, verbose = TRUE, apikey = "FAKEONE")
    Message
      i Requesting <https://opendata.aemet.es/opendata/api/valores/climatologicos/inventarioestaciones/todasestaciones/fake>
      x HTTP 404:
        Not Found.

---

    Code
      n <- aemet_api_call("https://opendata.aemet.es/opendata/sh/1234fakethis",
        data_call = TRUE, verbose = TRUE, apikey = aemet_show_api_key()[1])
    Message
      i Requesting <https://opendata.aemet.es/opendata/sh/1234fakethis>
      x HTTP 404:
        datos expirados

