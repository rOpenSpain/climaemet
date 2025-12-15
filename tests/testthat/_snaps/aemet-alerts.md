# Errors

    Code
      aemet_alerts("Idonotexist")
    Condition
      Warning in `mapSpain::esp_dict_region_code()`:
      No match on codauto found for Idonotexist
      Error in `aemet_alerts()`:
      ! In `ccaa`: No match found.

---

    Code
      aemet_alerts(lang = "frr")
    Condition
      Error in `match.arg()`:
      ! 'arg' should be one of "es", "en"

# In no alerts

    Code
      aemet_alerts(ca)
    Message
      v No upcoming alerts for selected `ccaa`s.
    Output
      NULL

