# Online

    Code
      emp <- aemet_forecast_daily("naha")
    Condition
      Warning in `aemet_api_call()`:
      HTTP 404: Error al obtener los datos
    Message
      
      AEMET API call for 'naha' returned an error
      Return NULL for this query
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
      ! Var 'hagaga' not available in the current dataset.

