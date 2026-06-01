# Errors and validations

    Code
      aemet_extremes_clim(NULL)
    Condition
      Error in `aemet_extremes_clim()`:
      ! `station` cannot be NULL.

---

    Code
      aemet_extremes_clim("NULL", parameter = NULL)
    Condition
      Error in `aemet_extremes_clim()`:
      ! `parameter` cannot be NULL.

---

    Code
      aemet_extremes_clim("NULL", parameter = TRUE)
    Condition
      Error in `aemet_extremes_clim()`:
      ! `parameter` must be a character, not `TRUE`.

---

    Code
      aemet_extremes_clim("NULL", parameter = "ABC")
    Condition
      Error in `aemet_extremes_clim()`:
      ! `parameter` must be one of "T", "P", or "V".

