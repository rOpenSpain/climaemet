# Run this example only if AEMET_API_KEY is detected

if (aemet_detect_api_key()) {
  library(tibble)
  obs <- aemet_daily_clim(c("9434", "3195"))
  glimpse(obs)
}
