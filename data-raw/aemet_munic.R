## code to prepare `aemet_munic` dataset goes here
# From https://www.ine.es/daco/daco42/codmun/codmunmapa.htm

library(readxl)
library(dplyr)

download.file(
  "https://www.ine.es/daco/daco42/codmun/diccionario25.xlsx",
  "data-raw/diccionario25.xlsx"
)

munis <- read_excel("data-raw/diccionario25.xlsx", skip = 1)


names(munis) <- tolower(names(munis))

# Complete with mapSpain info
master_mapspain <- mapSpain::esp_codelist %>%
  as_tibble()

selected <- master_mapspain %>%
  select(
    codauto,
    codauto_nombre = ine.ccaa.name,
    cpro,
    cpro_nombre = ine.prov.name
  ) %>%
  distinct_all()

prev <- climaemet::aemet_munic

# Build final name
aemet_munic <- munis %>%
  left_join(selected) %>%
  mutate(municipio = paste0(cpro, cmun)) %>%
  select(
    municipio,
    municipio_nombre = nombre,
    cpro,
    cpro_nombre,
    codauto,
    codauto_nombre
  ) %>%
  distinct_all() %>%
  arrange(municipio)


identical(names(prev), names(aemet_munic))


usethis::use_data(aemet_munic, overwrite = TRUE)
