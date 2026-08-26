# climatogram_normal returns a Walter-Lieth plot

    Code
      n <- climatogram_normal("9434", verbose = TRUE, labels = NULL)
    Message
      i Downloading data. This may take a few seconds.

---

    Code
      climatogram_normal("XXXX")
    Condition
      Error in `climatogram_normal()`:
      ! The AEMET OpenData API returned no valid results.

# climatogram_period returns a Walter-Lieth plot

    Code
      climatogram_period("XXXX", start = 2019, end = 2020)
    Condition
      Error in `data_raw[c("fecha", "p_mes", "tm_max", "tm_min", "ta_min")]`:
      ! Can't subset columns that don't exist.
      x Columns `fecha`, `p_mes`, `tm_max`, `tm_min`, and `ta_min` don't exist.

---

    Code
      climatogram_period("9434", start = 1800, end = 1801)
    Condition
      Error:
      ! No valid period

# ggclimat_walter_lieth validates data and returns a plot

    Code
      ggclimat_walter_lieth(dat)
    Condition
      Error in `ggclimat_walter_lieth()`:
      ! `dat` must have dimensions `4 x 12`, not `1 x 1`.

---

    Code
      ggclimat_walter_lieth(df)
    Condition
      Error in `ggclimat_walter_lieth()`:
      ! Cannot plot the diagram because `dat` contains missing values.

