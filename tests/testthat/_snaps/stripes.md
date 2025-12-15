# ggstripes errors

    Code
      ggstripes(data, plot_title = "Zaragoza Airport", n_temp = "calab")
    Condition
      Error in `ggstripes()`:
      ! `n_temp` needs to be numeric, not a string.

---

    Code
      ggstripes(data, plot_title = "Zaragoza Airport", plot_type = "calab")
    Condition
      Error in `ggstripes()`:
      ! `plot_type` should be one of "background", "stripes", "trend", and "animation", not "calab".

---

    Code
      ggstripes(data, plot_title = "Zaragoza Airport", col_pal = "calab")
    Condition
      Error in `ggstripes()`:
      ! `col_pal` should be one of the palettes defined on `grDevices::hcl.pals()`.

---

    Code
      ggstripes(data.frame(x = 1), plot_title = "Zaragoza Airport")
    Condition
      Error in `ggstripes()`:
      ! `data` must have "year" and "temp" cols.

