# dms2decdegrees works

    Code
      dms2decdegrees("055245W")
    Output
      [1] -5.879167

---

    Code
      dms2decdegrees("522312N")
    Output
      [1] 52.38667

---

    Code
      dms2decdegrees(NULL)
    Condition
      Error in `dms2decdegrees()`:
      ! `input` must be a character string, not NULL.

---

    Code
      dms2decdegrees(45)
    Condition
      Error in `dms2decdegrees()`:
      ! `input` must be a character string, not a number.

# dms2decdegrees_2 works

    Code
      dms2decdegrees_2("-5º 52' 45\"")
    Output
      [1] -5.879167

---

    Code
      dms2decdegrees_2("52º 23'12\"")
    Output
      [1] 52.38667

---

    Code
      dms2decdegrees_2("52º 2312\"")
    Condition
      Error in `dms2decdegrees_2()`:
      ! Cannot parse coordinate pieces from `input`.

# first and last works

    Code
      first_day_of_year(2000)
    Output
      [1] "2000-01-01"

---

    Code
      last_day_of_year(2020)
    Output
      [1] "2020-12-31"

---

    Code
      first_day_of_year()
    Condition
      Error in `first_day_of_year()`:
      ! `year` must be numeric, not NULL.

---

    Code
      last_day_of_year()
    Condition
      Error in `last_day_of_year()`:
      ! `year` must be numeric, not NULL.

---

    Code
      first_day_of_year("A")
    Condition
      Error in `first_day_of_year()`:
      ! `year` must be numeric, not a string.

---

    Code
      last_day_of_year("B")
    Condition
      Error in `last_day_of_year()`:
      ! `year` must be numeric, not a string.

# aemet_hlp_validate_logical works

    Code
      aemet_hlp_validate_logical("TRUE", "my_param")
    Condition
      Error:
      ! `my_param` must be a single logical value, not a string.

---

    Code
      aemet_hlp_validate_logical(1, "my_param")
    Condition
      Error:
      ! `my_param` must be a single logical value, not a number.

---

    Code
      aemet_hlp_validate_logical(NULL, "my_param")
    Condition
      Error:
      ! `my_param` must be a single logical value, not NULL.

---

    Code
      aemet_hlp_validate_logical(c(TRUE, FALSE), "my_param")
    Condition
      Error:
      ! `my_param` must be a single logical value, not a logical vector.

---

    Code
      a_mock_fun(list())
    Condition
      Error in `a_mock_fun()`:
      ! `inside_a_fun` must be a single logical value, not an empty list.

