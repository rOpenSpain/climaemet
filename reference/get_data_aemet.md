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
#> Waiting 3s for retry backoff ■■■■■■■■■■■                     
#> Waiting 3s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
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
#> DÍA 23 DE FEBRERO DE 2026 A LAS 12:58 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL LUNES 23
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Calima en Canarias. Nieblas y brumas en litorales mediterráneos
#> que localmente pueden ser persistentes.
#> 
#> B.- PREDICCIÓN
#> Se prevén altas presiones en todo el territorio con el centro
#> situado en el norte de África. Con esta situación no se esperan
#> precipitaciones y los cielos estarán despejados o con nubes
#> altas. De madrugada, se esperan nubes bajas con algunas brumas y
#> bancos de niebla en la meseta Norte, el extremo norte y en
#> litorales mediterráneos donde pueden ser localmente más
#> persistentes. En Canarias, intervalos de nubes altas con una
#> entrada de calima afectando a todas las islas.
#> 
#> Temperaturas máximas en ascenso prácticamente generalizado en la
#> Península y Baleares, aunque con probabilidad de ligeros
#> descensos en zonas del este de la Ibérica y de la Bética, en el
#> noreste y en el extremo sudoeste peninsular. Mínimas en ascenso
#> ligero salvo en Alborán y el sudoeste, donde se espera un
#> descenso. En Canarias se espera pocos cambios o ligero descenso de
#> las máximas, principalmente en las islas orientales y zonas altas
#> de las occidentales, y un ascenso de las mínimas, más marcado en
#> las islas occidentales, en zonas bajas y medianías, y sin cambios
#> o en ligero descenso en zonas del interior. Las heladas débiles
#> quedarán restringidas a cumbres de montaña de los Pirineos y de
#> la Cantábrica y no se descartan de forma puntual en la meseta
#> Norte.
#> 
#> Viento flojo de dirección variable con predominio de la
#> componente sur en el interior peninsular, algo más intenso en los
#> litorales donde predominarán los regímenes de brisa salvo el
#> levante en el golfo de Cádiz y Alborán, el sudeste en el mar
#> Balear, la componente este en el Cantábrico y la sur en los
#> litorales atlánticos gallegos al final. En Canarias, viento
#> moderado de componente este..
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
