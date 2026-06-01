# Load at init the keys

    Code
      aemet_daily_clim()
    Condition
      Error in `get_data_aemet()`:
      ! An API key is required. See `climaemet::aemet_api_key()`.

---

    Code
      aemet_daily_clim(extract_metadata = TRUE)
    Condition
      Error in `get_metadata_aemet()`:
      ! An API key is required. See `climaemet::aemet_api_key()`.

# Errors

    Code
      aemet_api_key(list(a = 1))
    Condition
      Error in `aemet_api_key()`:
      ! `apikey` must be a character string, not a list.

