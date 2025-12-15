# ggwindrose

    Code
      ggwindrose(speed = c(TRUE, FALSE))
    Condition
      Error in `ggwindrose()`:
      ! `speed` needs to be numeric, not a logical vector.

---

    Code
      ggwindrose(speed = seq(1, 3), direction = "atest")
    Condition
      Error in `ggwindrose()`:
      ! `direction` needs to be numeric, not a string.

---

    Code
      ggwindrose(speed = seq(1, 3), direction = seq(1, 3), stack_reverse = 45)
    Condition
      Error in `ggwindrose()`:
      ! `stack_reverse` needs to be logical, not a number.

---

    Code
      ggwindrose(speed = seq(1, 3), direction = seq(1, 3), facet = 35)
    Condition
      Error in `ggwindrose()`:
      ! `facet` needs to be character or factor, not a number.

---

    Code
      ggwindrose(speed = seq(1, 3), direction = seq(1, 3), facet = letters)
    Condition
      Error in `ggwindrose()`:
      ! `facet` and `speed` should have the same lenght (26 vs. 3).

---

    Code
      ggwindrose(speed = seq(1, 3), direction = seq(1, 8))
    Condition
      Error in `ggwindrose()`:
      ! `direction` and `speed` should have the same lenght (8 vs. 3).

---

    Code
      ggwindrose(speed = seq(1, 3), direction = seq(401, 403))
    Condition
      Error in `ggwindrose()`:
      ! `direction` should be between 0 and 360, not 401, 402, and 403

---

    Code
      ggwindrose(speed = speed, direction = direction, n_directions = seq(1, 3))
    Condition
      Error in `ggwindrose()`:
      ! `n_directions` should be a numeric vector of length 1, not an integer vector of length 3.

---

    Code
      ggwindrose(speed = speed, direction = direction, n_speeds = seq(1, 3))
    Condition
      Error in `ggwindrose()`:
      ! `n_speeds` should be a numeric vector of length 1, not an integer vector of length 3.

---

    Code
      ggwindrose(speed = speed, direction = direction, calm_wind = seq(1, 3))
    Condition
      Error in `ggwindrose()`:
      ! `calm_wind` should be a numeric vector of length 1, not an integer vector of length 3.

---

    Code
      ggwindrose(speed = speed, direction = direction, legend_title = seq(1, 3))
    Condition
      Error in `ggwindrose()`:
      ! `legend_title` should be a single character string or expressionnot an integer vector.

---

    Code
      ggwindrose(speed = speed, direction = direction, speed_cuts = letters[1:3])
    Condition
      Error in `ggwindrose()`:
      ! `speed_cuts` should be numeric or NA, not a character vector.

---

    Code
      ggwindrose(speed = speed, direction = direction, col_pal = "SOMECRAZY")
    Condition
      Error in `ggwindrose()`:
      ! `col_pal` should be one of the palettes defined on `grDevices::hcl.pals()`.

---

    Code
      s <- ggwindrose(speed = speed, direction = direction, n_directions = 37)
    Message
      i Using the closest optimal number of wind directions (16).

