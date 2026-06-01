# Errors and validations

    Code
      aemet_daily_clim(NULL)
    Condition
      Error in `aemet_daily_clim()`:
      ! `station` cannot be NULL.

---

    Code
      aemet_daily_clim(start = "aa")
    Condition
      Error in `charToDate()`:
      ! character string is not in a standard unambiguous format

---

    Code
      aemet_daily_clim(return_sf = "aa")
    Condition
      Error in `aemet_daily_clim()`:
      ! `return_sf` must be a single logical value, not a string.

---

    Code
      aemet_daily_clim(verbose = "aa")
    Condition
      Error in `aemet_daily_clim()`:
      ! `verbose` must be a single logical value, not a string.

---

    Code
      aemet_daily_period("a", start = NULL)
    Condition
      Error in `aemet_daily_period()`:
      ! `start` cannot be NULL.

---

    Code
      aemet_daily_period("a", end = NULL)
    Condition
      Error in `aemet_daily_period()`:
      ! `end` cannot be NULL.

---

    Code
      aemet_daily_period("a", start = "aa")
    Condition
      Error in `aemet_daily_period()`:
      ! `start` must be numeric, not a string.

---

    Code
      aemet_daily_period("a", end = "aa")
    Condition
      Error in `aemet_daily_period()`:
      ! `end` must be numeric, not a string.

---

    Code
      aemet_daily_period_all(start = NULL)
    Condition
      Error in `aemet_daily_period_all()`:
      ! `start` cannot be NULL.

---

    Code
      aemet_daily_period_all(end = NULL)
    Condition
      Error in `aemet_daily_period_all()`:
      ! `end` cannot be NULL.

---

    Code
      aemet_daily_period_all(start = "aa")
    Condition
      Error in `aemet_daily_period_all()`:
      ! `start` must be numeric, not a string.

---

    Code
      aemet_daily_period_all(end = "aa")
    Condition
      Error in `aemet_daily_period_all()`:
      ! `end` must be numeric, not a string.

