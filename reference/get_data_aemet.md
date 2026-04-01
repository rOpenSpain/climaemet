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
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying...
#> Waiting 3s for retry backoff ■■■■■■■■■■■                     
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■      
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> 
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
#> DÍA 01 DE ABRIL DE 2026 A LAS 08:35 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 1
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Rachas de viento muy fuertes (superiores a 70 km/h) en el
#> Ampurdán, los Pirineos, el valle del Ebro, el sistema Ibérico y
#> Baleares. Nevadas en los Pirineos por encima de 1200-1400 metros,
#> principalmente cerca de la divisoria. Precipitaciones débiles
#> pero persistentes en el Cantábrico oriental. Calima en Canarias.
#> 
#> B.- PREDICCIÓN
#> Durante este día se espera un flujo de componente norte sobre la
#> Península, producido por el anticiclón, situado al noroeste, y
#> la borrasca Erminio, en el Mediterráneo central. Los cielos
#> estarán nubosos o cubiertos en el norte peninsular y poco nuboso
#> o con intervalos en el resto. Se prevén precipitaciones, débiles
#> y persistentes, en el Cantábrico oriental, en el alto Ebro, en el
#> norte del sistema Ibérico y en los Pirineos, donde se espera que
#> sean en forma de nieve a partir de los 1200-1400 metros,
#> principalmente cerca de la divisoria. En Baleares, intervalos
#> nubosos con chubascos ocasionales, más probables al final día.
#> En Canarias, habrá calima e intervalos de nubes medias, que, con
#> baja probabilidad, podrían dejar alguna lluvia débil en la
#> provincia occidental.
#> 
#> Se esperan brumas y bancos de niebla en zonas altas de los
#> principales sistemas de montaña de la mitad norte y, con menor
#> probabilidad, en la meseta norte.
#> 
#> Las temperaturas máximas subirán ligeramente en la mitad norte y
#> en los litorales del este, y bajarán en el resto, de manera más
#> acusada en el Estrecho y en Cataluña; las mínimas subirán en
#> Andalucía occidental, en Ceuta y en Melilla, y se mantendrán sin
#> cambios o bajarán ligeramente en el resto. En Canarias, las
#> máximas descenderán en las islas orientales y subirán en las
#> occidentales; las mínimas ascenderán en las islas montañosas y
#> se mantendrán en Lanzarote y Fuerteventura. Habrá heladas
#> débiles en los Pirineos y en las cumbres de otros sistemas
#> montañosos del norte.
#> 
#> Predominará el viento moderado de componente norte en la
#> Península y en Baleares; se darán rachas muy fuertes en el
#> Ampurdán, en Baleares, en el Ebro, en el sistema Ibérico y en
#> los Pirineos. En el litoral del mar de Alborán, el viento se
#> intensificará y rolará de este a oeste a lo largo del día. En
#> Canarias, el alisio será moderado.
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
