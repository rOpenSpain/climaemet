# Errors and validations

    Code
      aemet_last_obs(NULL)
    Condition
      Error in `aemet_last_obs()`:
      ! `station` cannot be NULL.

---

    Code
      aemet_last_obs(return_sf = "A")
    Condition
      Error in `aemet_last_obs()`:
      ! `return_sf` must be a single logical value, not a string.

---

    Code
      aemet_last_obs(verbose = "A")
    Condition
      Error in `aemet_last_obs()`:
      ! `verbose` must be a single logical value, not a string.

