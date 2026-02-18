# Client tool for AEMET API

Client tool to get data and metadata from AEMET and convert json to
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).

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

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) (if
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
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying...
#> Waiting 3s for retry backoff ■■■■■■■■■■■■                    
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Waiting 7s for retry backoff ■■■■■                           
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■■                  
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■     
#> Waiting 7s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 5s for retry backoff ■■■■■■■■■■■■■■■■                
#> Waiting 5s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> 
#> # A tibble: 947 × 7
#>    latitud provincia     altitud indicativo nombre             indsinop longitud
#>    <chr>   <chr>         <chr>   <chr>      <chr>              <chr>    <chr>   
#>  1 394924N ILLES BALEARS 490     B013X      ESCORCA, LLUC      "08304"  025309E 
#>  2 394744N BALEARES      5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N ILLES BALEARS 60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N BALEARES      52      B103B      ANDRATX - SANT ELM ""       022208E 
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
#> DÍA 06 DE FEBRERO DE 2026 A LAS 07:32 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL VIERNES 6
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probables precipitaciones persistentes en el oeste de Galicia y
#> del Sistema Central, Estrecho y vertiente oeste de las Béticas.
#> Tormentas en el suroeste peninsular. Rachas muy fuertes de viento
#> de oeste, en el este peninsular, sistemas Béticos, montañas del
#> extremo norte, Baleares y litorales del sur y noroeste peninsular.
#> 
#> B.- PREDICCIÓN
#> Se mantendrá la inestabilidad en la mayor parte de la Península
#> bajo la influencia de la borrasca Leonardo, estacionaria al sur de
#> Irlanda y ya en fase madura. Así, predominarán los cielos
#> nubosos y precipitaciones generalizadas en la vertiente
#> atlántica, Alborán y Aragón, siendo menos abundantes que en
#> días previos. Se esperan precipitaciones, aunque de carácter
#> débil y ocasional, en el Cantábrico, Baleares, fachada oriental
#> y resto del nordeste peninsular, con un predominio de cielos poco
#> nubosos o con intervalos nubosos en estas zonas. Los mayores
#> acumulados se esperan en el oeste de Galicia y del Sistema
#> Central, Estrecho y vertiente oeste de las Béticas, pudiendo ser
#> persistentes. Asimismo, podrán ir ocasionalmente acompañadas de
#> tormenta y granizo en zonas del oeste peninsular y litoral sur. Se
#> prevén nevadas en montañas de la mitad norte a una cota de
#> 1100/1500 m, pudiendo bajar en el noroeste a 900 m al final, y en
#> las del sureste a partir de 1400/1800 m. En Canarias, cielos
#> nubosos con posibilidad de alguna lluvia débil y dispersa al
#> principio, tendiendo a poco nuboso.
#> 
#> Bancos de niebla matinales en regiones de montaña.
#> 
#> Descensos generalizados de las temperaturas, con las mínimas al
#> final del día, en la Península y Canarias. Solamente en el
#> tercio nordeste peninsular las temperaturas máximas aumentarán y
#> las mínimas permanecerán sin cambios. En Baleares, mínimas sin
#> cambios y máximas en descenso. Heladas débiles en montañas de
#> la mitad norte peninsular, moderadas en Pirineos.
#> 
#> Predominará el viento moderado del oeste y suroeste en la
#> Península y Baleares, flojo en el interior del tercio nordeste
#> peninsular y alcanzando intervalos fuertes y rachas muy fuertes en
#> Baleares y litorales del sur y noroeste peninsular. Se esperan
#> además rachas muy fuertes en el este peninsular, sistemas
#> Béticos y montañas del extremo norte. En Canarias, viento
#> moderado de componente norte con intervalos de fuerte.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
