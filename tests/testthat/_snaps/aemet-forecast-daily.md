# Online

    Code
      dput(emp)
    Output
      structure(list(id = character(0)), row.names = integer(0), class = c("tbl_df", 
      "tbl", "data.frame"))

---

    Code
      vv <- aemet_forecast_vars_available(alll)

---

    Code
      aemet_forecast_tidy(alll, "hagaga")
    Condition
      Error in `aemet_forecast_tidy()`:
      ! Variable "hagaga" not found in `x`.

