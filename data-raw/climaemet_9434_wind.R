## code to prepare `climaemet_9434_wind` dataset goes here

library(climaemet)
library(tidyverse)

data_raw <- aemet_daily_period(9434, start = 2000, end = 2020, verbose = TRUE)

# Extract wind

climaemet_9434_wind <- data_raw |>
  select(fecha, dir, velmedia) |>
  drop_na() |>
  mutate(dir = as.numeric(dir) * 10) |>
  filter(dir >= 0 & dir <= 360)


usethis::use_data(climaemet_9434_wind, overwrite = TRUE)
