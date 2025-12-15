# Errors and validations

    Code
      aemet_monthly_clim(NULL)
    Condition
      Error in `aemet_monthly_clim()`:
      ! `station` can't be NULL.

---

    Code
      aemet_monthly_clim("a", year = "aa")
    Condition
      Error in `aemet_monthly_clim()`:
      ! `year` needs to be numeric, not a string.

---

    Code
      aemet_monthly_clim("a", return_sf = "aa")
    Condition
      Error in `aemet_monthly_clim()`:
      ! is.logical(return_sf) is not TRUE

---

    Code
      aemet_monthly_clim("a", verbose = "aa")
    Condition
      Error in `aemet_monthly_clim()`:
      ! is.logical(verbose) is not TRUE

---

    Code
      aemet_monthly_period("a", start = NULL)
    Condition
      Error in `aemet_monthly_period()`:
      ! `start` needs to be numeric, not NULL.

---

    Code
      aemet_monthly_period("a", end = NULL)
    Condition
      Error in `aemet_monthly_period()`:
      ! `end` needs to be numeric, not NULL.

---

    Code
      aemet_monthly_period(NULL, start = "aa")
    Condition
      Error in `aemet_monthly_period()`:
      ! `station` can't be NULL.

---

    Code
      aemet_monthly_period_all(start = NULL)
    Condition
      Error in `aemet_monthly_period_all()`:
      ! `start` can't be NULL.

---

    Code
      aemet_monthly_period_all(end = NULL)
    Condition
      Error in `aemet_monthly_period_all()`:
      ! `end` can't be NULL.

---

    Code
      aemet_monthly_period_all(start = "NULL")
    Condition
      Error in `aemet_monthly_period_all()`:
      ! `start` needs to be numeric, not a string.

---

    Code
      aemet_monthly_period_all(end = "NULL")
    Condition
      Error in `aemet_monthly_period_all()`:
      ! `end` needs to be numeric, not a string.

