# Extending climaemet

**climaemet** provides functions for selected endpoints from the [AEMET
API tool](https://opendata.aemet.es/dist/index.html?). However, the
package does not cover every API capability.

For that reason,
[`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
allows access to any API endpoint. Users need to parse endpoint-specific
results themselves.

``` r

library(climaemet)
```

### Example: normalized text

Some API endpoints, such as `predicciones-normalizadas-texto`, return
plain natural language text. **climaemet** does not parse these results,
but you can retrieve them directly:

``` r

# Endpoint: today's forecast.

today <- "/api/prediccion/nacional/hoy"

# Metadata
knitr::kable(get_metadata_aemet(today))
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere al siguiente
#>   minuto.
#> ℹ Retrying.
#> Error in `httr2::req_perform()` at climaemet/R/aemet-api-query.R:402:5:
#> ! Failed to perform HTTP request.
#> Caused by error in `curl::curl_fetch_memory()`:
#> ! Failure when receiving data from the peer [opendata.aemet.es]:
#> schannel: server closed abruptly (missing close_notify)
#> 

# Data
pred_today <- get_data_aemet(today)
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere al siguiente
#>   minuto.
#> ℹ Retrying.
#> Error in `httr2::req_perform()` at climaemet/R/aemet-api-query.R:402:5:
#> ! Failed to perform HTTP request.
#> Caused by error in `curl::curl_fetch_memory()`:
#> ! Failure when receiving data from the peer [opendata.aemet.es]:
#> schannel: server closed abruptly (missing close_notify)
#> 
```

``` r
# Produce a result.

clean <- gsub("\r", "\n", pred_today, fixed = TRUE)
Error:
! objeto 'pred_today' no encontrado
clean <- gsub("\n\n\n", "\n", clean, fixed = TRUE)
Error:
! objeto 'clean' no encontrado

cat("<blockquote>", clean, "</blockquote>", sep = "\n")
Error:
! objeto 'clean' no encontrado
```

### Example: maps

AEMET also provides map data, usually in `image/gif` format. You can
retrieve this kind of data directly:

\`\`\` r \# Map endpoint. a_map \<- “/api/mapasygraficos/analisis”

## Metadata

knitr::kable(get_metadata_aemet(a_map)) \#\> ! HTTP 429: \#\> Límite de
peticiones o caudal por minuto excedido para este usuario. Espere al
siguiente \#\> minuto. \#\> ℹ Retrying. \#\> Waiting 2s for retry
backoff ■■■■■■■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■

Waiting 5s for retry backoff ■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■■■■■■■■■■

Waiting 5s for retry backoff ■■■■■■■■■■■■■■■■■■■■
