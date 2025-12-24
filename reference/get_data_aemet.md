# Client tool for AEMET API

Client tool to get data and metadata from AEMET and convert json to
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html).

## Usage

``` r
get_data_aemet(apidest, verbose = FALSE)

get_metadata_aemet(apidest, verbose = FALSE)
```

## Source

<https://opendata.aemet.es/dist/index.html>.

## Arguments

- apidest:

  Character string as destination URL. See
  <https://opendata.aemet.es/dist/index.html>.

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

## Value

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) (if
possible) or the results of the query as provided by
[`httr2::resp_body_raw()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`httr2::resp_body_string()`](https://httr2.r-lib.org/reference/resp_body_raw.html).

## See also

Some examples on how to use these functions on
[`vignette("extending-climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md).

## Examples

``` r
# Run this example only if AEMET_API_KEY is detected

url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"

get_data_aemet(url)
#> # A tibble: 947 × 7
#>    latitud provincia     altitud indicativo nombre             indsinop longitud
#>    <chr>   <chr>         <chr>   <chr>      <chr>              <chr>    <chr>   
#>  1 394924N ILLES BALEARS 490     B013X      ESCORCA, LLUC      "08304"  025309E 
#>  2 394744N ILLES BALEARS 5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N ILLES BALEARS 60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N ILLES BALEARS 52      B103B      ANDRATX - SANT ELM ""       022208E 
#>  5 393305N BALEARES      50      B158X      CALVIÀ, ES CAPDEL… ""       022759E 
#>  6 393315N ILLES BALEARS 3       B228       PALMA, PUERTO      "08301"  023731E 
#>  7 393832N ILLES BALEARS 95      B236C      PALMA, UNIVERSITAT ""       023838E 
#>  8 394406N ILLES BALEARS 1030    B248       SIERRA DE ALFABIA… "08303"  024247E 
#>  9 393621N BALEARES      47      B275E      SON BONET, AEROPU… "08302"  024224E 
#> 10 393339N BALEARES      5       B278       PALMA DE MALLORCA… "08306"  024412E 
#> # ℹ 937 more rows


# Metadata

get_metadata_aemet(url)
#> # A tibble: 7 × 7
#>   unidad_generadora         periodicidad descripcion formato copyright notaLegal
#>   <chr>                     <chr>        <chr>       <chr>   <chr>     <chr>    
#> 1 Servicio del Banco de Da… 1 vez al día Inventario… applic… © AEMET.… https://…
#> 2 Servicio del Banco de Da… 1 vez al día Inventario… applic… © AEMET.… https://…
#> 3 Servicio del Banco de Da… 1 vez al día Inventario… applic… © AEMET.… https://…
#> 4 Servicio del Banco de Da… 1 vez al día Inventario… applic… © AEMET.… https://…
#> 5 Servicio del Banco de Da… 1 vez al día Inventario… applic… © AEMET.… https://…
#> 6 Servicio del Banco de Da… 1 vez al día Inventario… applic… © AEMET.… https://…
#> 7 Servicio del Banco de Da… 1 vez al día Inventario… applic… © AEMET.… https://…
#> # ℹ 1 more variable: campos <df[,4]>

# We can get data from any API endpoint

# Plain text

plain <- get_data_aemet("/api/prediccion/nacional/hoy")
#> ℹ Results are MIME type: "text/plain".
#> → Returning data as UTF-8 string.

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 24 DE DICIEMBRE DE 2025 A LAS 08:58 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 24
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probables precipitaciones localmente fuertes y ocasionalmente con
#> tormenta en litorales de Alborán y del mar Balear. Nieblas
#> persistentes en zonas de montaña del norte peninsular.
#> 
#> B.- PREDICCIÓN
#> Se prevé una situación de inestabilidad con bajas presiones en
#> el Mediterráneo occidental y cielos muy nubosos o cubiertos en la
#> Península y Baleares, tendiendo a poco nuboso o despejado al
#> final en el suroeste. Se esperan precipitaciones moderadas y
#> persistentes en el Cantábrico y norte de Galicia, y probabilidad
#> de chubascos localmente fuertes y ocasionalmente con tormenta en
#> litorales de Alborán y del mar Balear; serán menos probables en
#> ambas mesetas. Nevará de forma débil en zonas de montaña por
#> encima de 1000-1200 m. En Canarias intervalos nubosos aumentando
#> por la tarde a nuboso o cubierto, principalmente en el norte de
#> las islas, con precipitaciones ocasionalmente moderadas y menos
#> probables y débiles en el sur.
#> 
#> Nieblas en zonas de montaña, más persistentes en las del norte
#> peninsular, y en zonas de ambas mesetas y del Ebro.
#> 
#> Descenso ligero de las temperaturas mínimas en la mitad sur,
#> noreste peninsular y Baleares y en ligero ascenso en el resto,
#> más acusado en el alto Ebro, Cantábrico central y zonas de la
#> meseta Norte. Máximas en ascenso general excepto en los litorales
#> del suroeste, fachadas sureste y este y zonas del alto Ebro y del
#> Cantábrico oriental. Pocos cambios en las temperaturas de
#> Canarias. Heladas moderadas en Pirineos, débiles en el resto de
#> las zonas de montaña, este de Castilla-La Mancha y, localmente,
#> en la meseta Norte.
#> 
#> Viento del norte y nordeste en general, que será moderado en los
#> litorales y en zonas de Castilla y León, con intervalos de fuerte
#> en litorales del noroeste y sin descartar rachas localmente muy
#> fuertes en zonas altas del tercio norte. Cierzo moderado en el
#> valle del Ebro, tramontana con intervalos de fuerte en Ampurdán y
#> poniente en el sur de Alborán. En Canarias viento moderado del
#> noroeste.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ! HTTP 500:
#>   Hit API Limits.
#> ℹ Retrying...
#> Waiting 4s for retry backoff ■■■■■■■■■                       
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 14s for retry backoff ■■■                             
#> Waiting 14s for retry backoff ■■■■■■■■                        
#> Waiting 14s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 14s for retry backoff ■■■■■■■■■■■■■■■■■■■■■           
#> Waiting 14s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■    
#> Waiting 14s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> 
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
#> Error in shell.exec(url): file association for 'C:\Users\RUNNER~1\AppData\Local\Temp\RtmpGyLnBl\filedac72e57b64.gif' not available or invalid
```
