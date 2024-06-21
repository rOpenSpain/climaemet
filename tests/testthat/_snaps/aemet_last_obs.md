# Errors and validations

    Code
      aemet_last_obs(NULL)
    Condition
      Error in `aemet_last_obs()`:
      ! Station can't be missing

---

    Code
      aemet_last_obs(return_sf = "A")
    Condition
      Error in `aemet_last_obs()`:
      ! is.logical(return_sf) is not TRUE

---

    Code
      aemet_last_obs(verbose = "A")
    Condition
      Error in `aemet_last_obs()`:
      ! is.logical(verbose) is not TRUE

