# Daily and annual climatology values

Retrieves climatology values for one station or all available stations.
`aemet_daily_period()` and `aemet_daily_period_all()` are shortcuts for
`aemet_daily_clim()`.

## Usage

``` r
aemet_daily_clim(
  station = "all",
  start = Sys.Date() - 7,
  end = Sys.Date(),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)

aemet_daily_period(
  station,
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)

aemet_daily_period_all(
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)
```

## Arguments

- station:

  A character vector of station identifiers (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md))
  or `"all"` for all stations.

- start, end:

  Character strings containing the start and end dates. See **Details**.

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

- return_sf:

  A logical value. If `TRUE`, the function returns an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object. If `FALSE` (the default), it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  [sf](https://CRAN.R-project.org/package=sf) must be installed.

- extract_metadata:

  A logical value. If `TRUE`, returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  describing the response fields. See
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  A logical value. If `TRUE`, displays a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  unless `verbose = TRUE`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
an [`sf`](https://r-spatial.github.io/sf/reference/sf.html) object.

## Details

For `aemet_daily_clim()`, `start` and `end` must be `Date` objects or
strings in `YYYY-MM-DD` format, such as `"2020-12-31"`, that can be
coerced with [`as.Date()`](https://rdrr.io/r/base/as.Date.html). For
`aemet_daily_period()` and `aemet_daily_period_all()`, they must be
strings representing the years to extract, such as `"2018"` and
`"2020"`.

## API key

Queries to the AEMET OpenData API require an API key. Use
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
to set it globally. Query timeout can be controlled with
`options(climaemet_timeout = 60)` (default value). See
[`httr2::req_timeout()`](https://httr2.r-lib.org/reference/req_timeout.html)
for details.

## See also

[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)
for station identifiers.

Climatology:
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_monthly_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_monthly.md),
[`aemet_normal_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md)

## Examples

``` r

library(dplyr)
obs <- aemet_daily_clim(c("9434", "3195"))
#> ! HTTP status 429:
#>   Se ha alcanzado uno de los límites de uso. Vuelva a intentarlo el próximo
#>   minuto.
#> ℹ Retrying.
#> Waiting 3s for retry backoff ■■■■■■■■■■■                     
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 16s for retry backoff ■■■                             
#> Waiting 16s for retry backoff ■■■■■                           
#> Waiting 16s for retry backoff ■■■■■■■■■■■                     
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■          
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■    
#> Waiting 16s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 33s for retry backoff ■■                              
#> Waiting 33s for retry backoff ■■■■■                           
#> Waiting 33s for retry backoff ■■■■■■■                         
#> Waiting 33s for retry backoff ■■■■■■■■■■                      
#> Waiting 33s for retry backoff ■■■■■■■■■■■■■                   
#> Waiting 33s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 33s for retry backoff ■■■■■■■■■■■■■■■■■■              
#> Waiting 33s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 33s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■        
#> Waiting 33s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 33s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 33s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 38s for retry backoff ■■                              
#> Waiting 38s for retry backoff ■■■■                            
#> Waiting 38s for retry backoff ■■■■■■■                         
#> Waiting 38s for retry backoff ■■■■■■■■■                       
#> Waiting 38s for retry backoff ■■■■■■■■■■■                     
#> Waiting 38s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 38s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 38s for retry backoff ■■■■■■■■■■■■■■■■■■              
#> Waiting 38s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 38s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■         
#> Waiting 38s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■      
#> Waiting 38s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■    
#> Waiting 38s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 38s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> ✖ HTTP status 429:
#>   Se ha alcanzado uno de los límites de uso. Vuelva a intentarlo el próximo
#>   minuto.
#> 
#> ! HTTP status 429:
#>   Se ha alcanzado uno de los límites de uso. Vuelva a intentarlo el próximo
#>   minuto.
#> ℹ Retrying.
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 6s for retry backoff ■■■■■■                          
#> Waiting 6s for retry backoff ■■■■■■■■■■■■■■■■■■■             
#> Waiting 6s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 14s for retry backoff ■■■                             
#> Waiting 14s for retry backoff ■■■■■■■■                        
#> Waiting 14s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 14s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 14s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■    
#> Waiting 14s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> 
glimpse(obs)
#> Rows: 4
#> Columns: 26
#> $ fecha       <date> 2026-11-19, 2026-11-20, 2026-11-21, 2026-11-22
#> $ indicativo  <chr> "3195", "3195", "3195", "3195"
#> $ nombre      <chr> "MADRID, RETIRO", "MADRID, RETIRO", "MADRID, RETIRO", "MA…
#> $ provincia   <chr> "MADRID", "MADRID", "MADRID", "MADRID"
#> $ altitud     <dbl> 667, 667, 667, 667
#> $ tmed        <dbl> 12.0, 11.2, 11.2, 10.1
#> $ prec        <dbl> 0, 0, 3, 0
#> $ tmin        <dbl> 9.6, 9.1, 10.2, 6.6
#> $ horatmin    <time> 23:59:00, 07:20:00, 09:30:00, 23:59:00
#> $ tmax        <dbl> 14.5, 13.3, 12.1, 13.6
#> $ horatmax    <time> 00:10:00, 15:00:00, 15:00:00, 13:00:00
#> $ dir         <dbl> 27, 29, 29, 32
#> $ velmedia    <dbl> 3.9, 1.7, 1.1, 3.1
#> $ racha       <dbl> 10.8, 7.5, 5.3, 11.7
#> $ horaracha   <time> 09:10:00, 01:40:00, 10:50:00, 12:10:00
#> $ presMax     <dbl> 943.7, 946.8, 945.2, 950.5
#> $ horaPresMax <chr> "Varias", "11", "00", "24"
#> $ presMin     <dbl> 931.6, 943.5, 938.9, 939.9
#> $ horaPresMin <chr> "00", "01", "22", "01"
#> $ hrMedia     <dbl> 66, 85, 91, 58
#> $ hrMax       <dbl> 95, 91, 98, 98
#> $ horaHrMax   <chr> "00:40", "Varias", "22:30", "01:10"
#> $ hrMin       <dbl> 47, 76, 81, 46
#> $ horaHrMin   <time> 13:20:00, 14:40:00, 15:30:00, 13:30:00
#> $ pintMax     <dbl> 0.6, 0.0, 3.0, 0.0
#> $ horaPIntMax <chr> "Varias", NA, "Varias", NA

# Metadata.
meta <- aemet_daily_clim(c("9434", "3195"), extract_metadata = TRUE)

glimpse(meta$campos)
#> List of 27
#>  $ :List of 4
#>   ..$ id         : chr "fecha"
#>   ..$ descripcion: chr "fecha del dia (AAAA-MM-DD)"
#>   ..$ tipo_datos : chr "string"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 4
#>   ..$ id         : chr "indicativo"
#>   ..$ descripcion: chr "indicativo climatológico"
#>   ..$ tipo_datos : chr "string"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 4
#>   ..$ id         : chr "nombre"
#>   ..$ descripcion: chr "nombre (ubicación) de la estación"
#>   ..$ tipo_datos : chr "string"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 4
#>   ..$ id         : chr "provincia"
#>   ..$ descripcion: chr "provincia de la estación"
#>   ..$ tipo_datos : chr "string"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 5
#>   ..$ id         : chr "altitud"
#>   ..$ descripcion: chr "altitud de la estación en m sobre el nivel del mar"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "m"
#>   ..$ requerido  : logi TRUE
#>  $ :List of 5
#>   ..$ id         : chr "tmed"
#>   ..$ descripcion: chr "Temperatura media diaria"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "°C"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "prec"
#>   ..$ descripcion: chr "Precipitación diaria de 07 a 07"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "mm (Ip = inferior a 0,1 mm) (Acum = Precipitación acumulada)"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "tmin"
#>   ..$ descripcion: chr "Temperatura Mínima del día"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "°C"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horatmin"
#>   ..$ descripcion: chr "Hora y minuto de la temperatura mínima"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "tmax"
#>   ..$ descripcion: chr "Temperatura Máxima del día"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "°C"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horatmax"
#>   ..$ descripcion: chr "Hora y minuto de la temperatura máxima"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "dir"
#>   ..$ descripcion: chr "Dirección de la racha máxima"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "decenas de grado (99 = dirección variable)(88 = sin dato)"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "velmedia"
#>   ..$ descripcion: chr "Velocidad media del viento"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "m/s"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "racha"
#>   ..$ descripcion: chr "Racha máxima del viento"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "m/s"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horaracha"
#>   ..$ descripcion: chr "Hora y minuto de la racha máxima"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "sol"
#>   ..$ descripcion: chr "Insolación"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "horas"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "presmax"
#>   ..$ descripcion: chr "Presión máxima al nivel de referencia de la estación"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "hPa"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horapresmax"
#>   ..$ descripcion: chr "Hora de la presión máxima (redondeada a la hora entera más próxima)"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "presmin"
#>   ..$ descripcion: chr "Presión mínima al nivel de referencia de la estación"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "hPa"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horapresmin"
#>   ..$ descripcion: chr "Hora de la presión mínima (redondeada a la hora entera más próxima)"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "hrmedia"
#>   ..$ descripcion: chr "Humedad relativa media diaria"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "%"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "hrmax"
#>   ..$ descripcion: chr "Humedad relativa máxima diaria"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "%"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horahrmax"
#>   ..$ descripcion: chr "Hora de la humedad relativa máxima diaria"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "hrmin"
#>   ..$ descripcion: chr "Humedad relativa mínima diaria"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "%"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horahrmin"
#>   ..$ descripcion: chr "Hora de la humedad relativa mínima diaria"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "pintmax"
#>   ..$ descripcion: chr "Intensidad máxima de precipitación"
#>   ..$ tipo_datos : chr "float"
#>   ..$ unidad     : chr "mm/h (-0,3 = precipitación inapreciable < 0,1 mm/h)"
#>   ..$ requerido  : logi FALSE
#>  $ :List of 5
#>   ..$ id         : chr "horapintmax"
#>   ..$ descripcion: chr "Hora de la intensidad máxima de precipitación"
#>   ..$ tipo_datos : chr "string"
#>   ..$ unidad     : chr "UTC"
#>   ..$ requerido  : logi FALSE
```
