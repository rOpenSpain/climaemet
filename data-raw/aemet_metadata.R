## code to prepare `aemet_metadata` dataset goes here

library(dplyr)

# Observacion

aemet_metadata <- NULL

get_metadata <- function(url, name) {
  apikey <- Sys.getenv("AEMET_API_KEY")
  response <- httr::GET(url, httr::add_headers(api_key = apikey))

  content <-
    jsonlite::fromJSON(httr::content(response, as = "text"))
  metadata <-
    httr::GET(content$metadatos, httr::add_headers(api_key = apikey))

  meta <-
    jsonlite::fromJSON(httr::content(metadata), flatten = TRUE)$campos
  meta <- tibble::as_tibble(meta)
  meta_end <- dplyr::bind_cols(tibble::tibble(fun = name), meta)
  return(meta_end)
}

aemet_metadata <- aemet_metadata %>%
  bind_rows(
    get_metadata(
      "https://opendata.aemet.es/opendata/api/observacion/convencional/todas",
      "aemet_last_obs_all"
    )
  ) %>%
  bind_rows(
    get_metadata(
      "https://opendata.aemet.es/opendata/api/observacion/convencional/datos/estacion/9434",
      "aemet_last_obs"
    )
  )





# usethis::use_data(aemet_metadata, overwrite = TRUE)
