# aemet_api_key loads and installs keys

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

---

    Code
      aemet_api_key(the_keys)
    Message
      i To install your API key for use in future sessions, run `climaemet::aemet_api_key()` with `install` set to `TRUE`.

---

    Code
      aemet_api_key(the_keys, install = TRUE)
    Condition
      Error in `aemet_api_key()`:
      ! A stored API key already exists at '<API_KEY_PATH>'. Set `overwrite` to `TRUE` to replace it.

# aemet_api_key rejects non-character keys

    Code
      aemet_api_key(list(a = 1))
    Condition
      Error in `aemet_api_key()`:
      ! `apikey` must be a character string, not a list.

# aemet_show_api_key returns configured keys

    Code
      aemet_show_api_key()
    Output
      [1] "TEST_SHOW_API_KEY"

# migrate_cache moves legacy keys

    Code
      migrate_cache(olddir, newdir)
    Message
      i Mocking new installation here with TRUE.

---

    Code
      aemet_api_key(c("TWO_KEYS", "THREE_KEYS"), install = TRUE, overwrite = FALSE)
    Condition
      Error in `aemet_api_key()`:
      ! A stored API key already exists at '<API_KEY_PATH>'. Set `overwrite` to `TRUE` to replace it.

