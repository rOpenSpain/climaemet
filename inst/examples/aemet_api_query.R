# Run this example only if AEMET_API_KEY is detected

url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"

if (aemet_detect_api_key()) {
  get_data_aemet(url)
}

# Metadata
if (aemet_detect_api_key()) {
  get_metadata_aemet(url)
}
