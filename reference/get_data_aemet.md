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
#> ! HTTP 500:
#>   Hit API Limits.
#> ℹ Retrying...
#> Waiting 4s for retry backoff ■■■■■■■■                        
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 4s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
#> Waiting 5s for retry backoff ■■■■■■■                         
#> Waiting 5s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■         
#> Waiting 5s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> 
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
#> DÍA 06 DE DICIEMBRE DE 2025 A LAS 08:05 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL SÁBADO 6
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probable ascenso notable de las temperaturas máximas en el Ebro y
#> Pirineos orientales y de las mínimas en el alto Ebro. Probables
#> rachas muy fuertes en el norte de Galicia, Cantábrico occidental
#> e interiores del Levante. Nieblas densas y persistentes en el
#> nordeste de Castilla-La Mancha, valle del Guadalquivir y
#> depresiones del nordeste.
#> 
#> B.- PREDICCIÓN
#> Tras un periodo marcado por el paso de frentes atlánticos por la
#> Península y Baleares, durante este día se prevé una transición
#> hacia un tiempo marcado por la situación anticiclónica, no
#> obstante, durante el sábado un frente aún afectará al noroeste
#> Peninsular. Para este día se esperan cielos nubosos o cubiertos
#> en la mayor parte de la Península, con intervalos de nubes altas
#> en áreas mediterráneas y Baleares y una tendencia a despejar en
#> el tercio sur. Se darán precipitaciones en el cuadrante noroeste
#> sin descartar que puedan darse de forma débil y dispersa en otros
#> puntos de la Península, más probables en montañas, y
#> exceptuando los extremos oriental y meridional donde no se
#> esperan. En el oeste de Galicia pueden ser persistentes dejado
#> acumulaciones importantes, sin descartar alguna tormenta aislada.
#> En Canarias intervalos de nubes medias y altas, aunque con
#> nubosidad baja en el norte de Tenerife y La Palma con posibilidad
#> de algún chubasco débil, tendiendo a poco nuboso al final del
#> día.
#> 
#> Brumas y nieblas matinales en amplias zonas de la mitad sur de la
#> vertiente atlántica, así como en las mesetas y montañas del
#> norte y depresiones del nordeste. Probable calima ligera en
#> Canarias.
#> 
#> Las temperaturas aumentarán en la mayor parte de la Península y
#> Baleares, incluso podrán hacerlo de forma notable las máximas en
#> el Ebro y Pirineos orientales o las mínimas en el alto Ebro.
#> Pocos cambios en Canarias. Con los ascensos se alcanzarán valores
#> elevados para la época en amplias zonas del tercio norte
#> peninsular, con heladas débiles restringidas al Pirineo.
#> 
#> Predominarán los vientos moderados del oeste y suroeste en la
#> Península y Baleares, en general flojos en interiores del
#> nordeste y sur peninsular, y con intervalos fuertes y probables
#> rachas muy fuertes en el norte de Galicia y Cantábrico occidental
#> que también podrán afectar a interiores del Levante. En Canarias
#> viento de componente este, flojo a moderado.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
#> Error in shell.exec(url): file association for 'C:\Users\RUNNER~1\AppData\Local\Temp\RtmpURyQyM\file116815412c97.gif' not available or invalid
```
