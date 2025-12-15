# Errors and validations

    Code
      aemet_extremes_clim(NULL)
    Condition
      Error in `aemet_extremes_clim()`:
      ! `station` can't be NULL.

---

    Code
      aemet_extremes_clim("NULL", parameter = NULL)
    Condition
      Error in `aemet_extremes_clim()`:
      ! `parameter` can't be NULL.

---

    Code
      aemet_extremes_clim("NULL", parameter = TRUE)
    Condition
      Error in `aemet_extremes_clim()`:
      ! `parameter` needs to be a character, not `TRUE`.

---

    Code
      aemet_extremes_clim("NULL", parameter = "ABC")
    Condition
      Error in `aemet_extremes_clim()`:
      ! `paramater` accepted values are "T", "P", and "V".

