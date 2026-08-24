# aemet_alerts rejects invalid regions and languages

    Code
      aemet_alerts("Idonotexist")
    Message
      ! No match found for "Idonotexist" with `destination` "codauto".
    Condition
      Error in `aemet_alerts()`:
      ! No match found for `ccaa`.

---

    Code
      aemet_alerts(lang = "frr")
    Condition
      Error in `aemet_alerts()`:
      ! `lang` must be one of "es" or "en", not "frr".

# aemet_alerts returns NULL for regions without alerts

    Code
      aemet_alerts(ca)
    Message
      v No current alerts for the selected `ccaa` values.
    Output
      NULL

# aemet_alerts returns NULL when the alert feed is empty

    Code
      aemet_alerts()
    Message
      v No current alerts.
    Output
      NULL

