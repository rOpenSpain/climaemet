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
      ! Something went wrong.

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
      ! `year` can't be NULL.

---

    Code
      last_day_of_year()
    Condition
      Error in `last_day_of_year()`:
      ! `year` can't be NULL.

---

    Code
      first_day_of_year("A")
    Condition
      Error in `first_day_of_year()`:
      ! `year` needs to be numeric, not a string.

---

    Code
      last_day_of_year("B")
    Condition
      Error in `last_day_of_year()`:
      ! `year` needs to be numeric, not a string.

