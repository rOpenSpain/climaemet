# Errors and validations

    Code
      aemet_extremes_clim(NULL)
    Condition
      Error in `aemet_extremes_clim()`:
      ! Station can't be missing

---

    Code
      aemet_extremes_clim("NULL", parameter = NULL)
    Condition
      Error in `aemet_extremes_clim()`:
      ! Parameter can't be missing

---

    Code
      aemet_extremes_clim("NULL", parameter = TRUE)
    Condition
      Error in `aemet_extremes_clim()`:
      ! Parameter need to be character string

---

    Code
      aemet_extremes_clim("NULL", parameter = "ABC")
    Condition
      Error in `aemet_extremes_clim()`:
      ! Parameter should be one of 'T', 'P', 'V'

