## code to prepare `climaemet_9434_climatogram` dataset goes here

library(climaemet)

data_raw <- aemet_normal_clim(9434, verbose = TRUE)

data <- data_raw[c("mes", "p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min")]

data$mes <- as.numeric(data$mes)
data <- data[data$mes < 13, ]
data <- tidyr::pivot_longer(data, 2:5)
data <-
  tidyr::pivot_wider(data, names_from = "mes", values_from = "value")
data <-
  dplyr::arrange(data, match(
    "name",
    c("p_mes_md", "tm_max_md", "tm_min_md", "ta_min_min")
  ))

# Need a data frame with row names
data <- as.data.frame(data)
rownames(data) <- data$name
data <- data[, colnames(data) != "name"]

climaemet_9434_climatogram <- data

usethis::use_data(climaemet_9434_climatogram, overwrite = TRUE)
