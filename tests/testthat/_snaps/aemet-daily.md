# Errors and validations

    Code
      aemet_daily_clim(NULL)
    Condition
      Error in `aemet_daily_clim()`:
      ! `station` can't be NULL.

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
      ! is.logical(return_sf) is not TRUE

---

    Code
      aemet_daily_clim(verbose = "aa")
    Condition
      Error in `aemet_daily_clim()`:
      ! is.logical(verbose) is not TRUE

---

    Code
      aemet_daily_period("a", start = NULL)
    Condition
      Error in `aemet_daily_period()`:
      ! `start` can't be NULL.

---

    Code
      aemet_daily_period("a", end = NULL)
    Condition
      Error in `aemet_daily_period()`:
      ! `end` can't be NULL.

---

    Code
      aemet_daily_period("a", start = "aa")
    Condition
      Error in `aemet_daily_period()`:
      ! `start` needs to be numeric, not a string.

---

    Code
      aemet_daily_period("a", end = "aa")
    Condition
      Error in `aemet_daily_period()`:
      ! `end` needs to be numeric, not a string.

---

    Code
      aemet_daily_period_all(start = NULL)
    Condition
      Error in `aemet_daily_period_all()`:
      ! `start` can't be NULL.

---

    Code
      aemet_daily_period_all(end = NULL)
    Condition
      Error in `aemet_daily_period_all()`:
      ! `end` can't be NULL.

---

    Code
      aemet_daily_period_all(start = "aa")
    Condition
      Error in `aemet_daily_period_all()`:
      ! `start` needs to be numeric, not a string.

---

    Code
      aemet_daily_period_all(end = "aa")
    Condition
      Error in `aemet_daily_period_all()`:
      ! `end` needs to be numeric, not a string.

