# Errors and validations

    Code
      aemet_monthly_clim(NULL)
    Condition
      Error in `aemet_monthly_clim()`:
      ! Station can't be missing

---

    Code
      aemet_monthly_clim("a", year = "aa")
    Condition
      Error in `aemet_monthly_clim()`:
      ! Year need to be numeric

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
      ! Start year need to be numeric

---

    Code
      aemet_monthly_period("a", end = NULL)
    Condition
      Error in `aemet_monthly_period()`:
      ! End year need to be numeric

---

    Code
      aemet_monthly_period(NULL, start = "aa")
    Condition
      Error in `aemet_monthly_period()`:
      ! Station can't be missing

---

    Code
      aemet_monthly_period_all(start = NULL)
    Condition
      Error in `aemet_monthly_period_all()`:
      ! Start year can't be missing

---

    Code
      aemet_monthly_period_all(end = NULL)
    Condition
      Error in `aemet_monthly_period_all()`:
      ! End year can't be missing

---

    Code
      aemet_monthly_period_all(start = "NULL")
    Condition
      Error in `aemet_monthly_period_all()`:
      ! Start year need to be numeric

---

    Code
      aemet_monthly_period_all(end = "NULL")
    Condition
      Error in `aemet_monthly_period_all()`:
      ! End year need to be numeric

