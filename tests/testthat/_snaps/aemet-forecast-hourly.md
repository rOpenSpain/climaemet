# aemet_forecast_hourly combines successful forecasts

    Code
      emp <- aemet_forecast_hourly("naha")
    Message
      ! AEMET OpenData API request for "naha" returned an error.
      i Returning `NULL` for this request.
    Condition
      Warning:
      Unknown or uninitialised column: `id`.

---

    Code
      aemet_forecast_tidy(alll, "hagaga")
    Condition
      Error in `aemet_forecast_tidy()`:
      ! Column hagaga was not found in `x`.

