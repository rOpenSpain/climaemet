# ggstripes errors

    Code
      ggstripes(data, plot_title = "Zaragoza Airport", n_temp = "calab")
    Condition
      Error in `ggstripes()`:
      ! `n_temp` must be numeric, not a string.

---

    Code
      ggstripes(data, plot_title = "Zaragoza Airport", plot_type = "calab")
    Condition
      Error in `ggstripes()`:
      ! `plot_type` must be one of "background", "stripes", "trend", or "animation", not "calab".

---

    Code
      ggstripes(data, plot_title = "Zaragoza Airport", col_pal = "calab")
    Condition
      Error in `ggstripes()`:
      ! `col_pal` must be one of the palettes returned by `grDevices::hcl.pals()`.

---

    Code
      ggstripes(data.frame(x = 1), plot_title = "Zaragoza Airport")
    Condition
      Error in `ggstripes()`:
      ! `data` must have year and temp columns.

# ggstripes plotting

    Code
      n <- ggstripes(data, plot_title = "Zaragoza Airport")
    Message
      i Plotting climate stripes.

# climatestripes_station

    Code
      n <- climatestripes_station("9434", start = 2024, end = 2024, with_labels = "yes",
        col_pal = "Inferno")
    Message
      i Downloading data, this may take a few seconds.
      i Plotting climate stripes.

---

    Code
      n2 <- climatestripes_station("9434", start = 2024, end = 2024, with_labels = NULL,
        col_pal = "Inferno")
    Message
      i Downloading data, this may take a few seconds.
      i Plotting climate stripes.

---

    Code
      climatestripes_station("anyvalue")
    Message
      i Downloading data, this may take a few seconds.
    Condition
      Error in `climatestripes_station()`:
      ! No valid results from the API.

