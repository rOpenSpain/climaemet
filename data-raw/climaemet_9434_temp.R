## code to prepare `climaemet_9434_temp` dataset goes here

library(climaemet)

data_raw <- aemet_monthly_period(9434, 1950, 2020, TRUE)

if (nrow(data_raw) == 0) stop("No valid results from the API")

data <- data_raw[c("fecha", "indicativo", "tm_mes")]
data <- data[!is.na(data$tm_mes), ]
data <- data[grep("-13", data$fecha), ]
data <- dplyr::rename(data, year = "fecha", temp = "tm_mes")
climaemet_9434_temp <-
  dplyr::mutate(data,
    temp = as.numeric(data$temp),
    year = as.integer(gsub("-13", "", data$year))
  )


usethis::use_data(climaemet_9434_temp, overwrite = TRUE)
