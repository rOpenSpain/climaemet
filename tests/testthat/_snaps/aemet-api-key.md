# Load at init the keys

    Code
      aemet_daily_clim()
    Condition
      Error in `get_data_aemet()`:
      ! Configure an API key with `climaemet::aemet_api_key()`.

---

    Code
      aemet_daily_clim(extract_metadata = TRUE)
    Condition
      Error in `get_metadata_aemet()`:
      ! Configure an API key with `climaemet::aemet_api_key()`.

# Errors

    Code
      aemet_api_key(list(a = 1))
    Condition
      Error in `aemet_api_key()`:
      ! `apikey` must be a character string, not a list.

# Minimal validation for aemet_show_api_key

    Code
      aemet_show_api_key()
    Output
      [1] "TEST_SHOW_API_KEY"

