# Errors and validations

    Code
      aemet_daily_clim(NULL)
    Condition
      Error in `aemet_daily_clim()`:
      ! Station can't be missing

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
      aemet_daily_period(start = NULL)
    Condition
      Error in `aemet_daily_period()`:
      ! Start year can't be missing

---

    Code
      aemet_daily_period(end = NULL)
    Condition
      Error in `aemet_daily_period()`:
      ! End year can't be missing

---

    Code
      aemet_daily_period(start = "aa")
    Condition
      Error in `aemet_daily_period()`:
      ! Start year need to be numeric

---

    Code
      aemet_daily_period(end = "aa")
    Condition
      Error in `aemet_daily_period()`:
      ! End year need to be numeric

---

    Code
      aemet_daily_period_all(start = NULL)
    Condition
      Error in `aemet_daily_period_all()`:
      ! Start year can't be missing

---

    Code
      aemet_daily_period_all(end = NULL)
    Condition
      Error in `aemet_daily_period_all()`:
      ! End year can't be missing

---

    Code
      aemet_daily_period_all(start = "aa")
    Condition
      Error in `aemet_daily_period_all()`:
      ! Start year need to be numeric

---

    Code
      aemet_daily_period_all(end = "aa")
    Condition
      Error in `aemet_daily_period_all()`:
      ! End year need to be numeric

