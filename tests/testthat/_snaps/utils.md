# Check sf

    Code
      bad <- aemet_hlp_sf(ex, "lat", "lon", verbose = FALSE)
    Message
      lat/lon columns not found. Returning a tibble

---

    Code
      a <- aemet_hlp_sf(ex, "cpro", "codauto", verbose = TRUE)
    Message
      Converting to spatial object
      spatial conversion successful

---

    Code
      bad2 <- aemet_hlp_sf(ex, "cpro", "codauto", verbose = FALSE)
    Message
      Found NA coordinates. Returning a tibble

