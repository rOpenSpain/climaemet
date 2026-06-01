# Errors and validations

    Code
      aemet_monthly_clim(NULL)
    Condition
      Error in `aemet_monthly_clim()`:
      ! `station` cannot be NULL.

---

    Code
      aemet_monthly_clim("a", year = "aa")
    Condition
      Error in `aemet_monthly_clim()`:
      ! `year` must be numeric, not a string.

---

    Code
      aemet_monthly_clim("a", return_sf = "aa")
    Condition
      Error in `aemet_monthly_clim()`:
      ! `return_sf` must be a single logical value, not a string.

---

    Code
      aemet_monthly_clim("a", verbose = "aa")
    Condition
      Error in `aemet_monthly_clim()`:
      ! `verbose` must be a single logical value, not a string.

---

    Code
      aemet_monthly_period("a", start = NULL)
    Condition
      Error in `aemet_monthly_period()`:
      ! `start` cannot be NULL.

---

    Code
      aemet_monthly_period("a", end = NULL)
    Condition
      Error in `aemet_monthly_period()`:
      ! `end` cannot be NULL.

---

    Code
      aemet_monthly_period(NULL, start = "aa")
    Condition
      Error in `aemet_monthly_period()`:
      ! `station` cannot be NULL.

---

    Code
      aemet_monthly_period_all(start = NULL)
    Condition
      Error in `aemet_monthly_period_all()`:
      ! `start` cannot be NULL.

---

    Code
      aemet_monthly_period_all(end = NULL)
    Condition
      Error in `aemet_monthly_period_all()`:
      ! `end` cannot be NULL.

---

    Code
      aemet_monthly_period_all(start = "NULL")
    Condition
      Error in `aemet_monthly_period_all()`:
      ! `start` must be numeric, not a string.

---

    Code
      aemet_monthly_period_all(end = "NULL")
    Condition
      Error in `aemet_monthly_period_all()`:
      ! `end` must be numeric, not a string.

