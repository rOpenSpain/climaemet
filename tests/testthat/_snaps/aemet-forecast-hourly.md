# Online

    Code
      emp <- aemet_forecast_hourly("naha")
    Message
      x HTTP 404:
        No hay datos que satisfagan esos criterios
      ! AEMET API call for "naha" returned an error.
      i Return NULL for this query.
    Condition
      Warning:
      Unknown or uninitialised column: `id`.

---

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

