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
#> DÍA 24 DE ABRIL DE 2026 A LAS 11:37 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL VIERNES 24
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> De madrugada, tormentas en las mesetas y en el sistema Central.
#> Por la tarde, chubascos fuertes y tormentas en Castilla y León,
#> norte y oeste de Castilla-La Mancha, La Rioja y Madrid. Descenso
#> notable de las temperaturas máximas en el sureste.
#> 
#> B.- PREDICCIÓN
#> Con la llegada del aire frío en altura, la inestabilidad
#> predominará en gran parte del interior peninsular. Se prevé
#> abundante nubosidad de evolución, con chubascos y tormentas
#> generalizados. Durante la madrugada, se espera que continúen las
#> precipitaciones en el norte Extremadura, la Comunidad de Madrid y
#> el oeste de Castilla-La Mancha, y que se extiendan hacia la meseta
#> norte. En la segunda mitad del día, se esperan chubascos fuertes
#> acompañados de tormenta y de posible granizo en Castilla y León,
#> norte y oeste de Castilla-La Mancha, La Rioja y Madrid; con menor
#> probabilidad, podrían darse en otros puntos de la meseta sur,
#> centro y este de Andalucía, sur de la Comunidad Valenciana y
#> otras zonas montañosas del norte. En el noreste y en Baleares,
#> los cielos estarán despejados o con nubes altas y, en Canarias,
#> nubosos.
#> 
#> Son posibles las brumas y los bancos de niebla matinales en el
#> interior de la Comunidad Valencia. La calima irá remitiendo y
#> desplazándose hacia el este peninsular.
#> 
#> Las temperaturas máximas descenderán en la Península y en
#> Baleares, de forma notable el sureste, y subirán en el noreste;
#> las mínimas subirán en la mitad occidental y bajarán en la
#> oriental y en Baleares. En Canarias, se espera un ascenso de las
#> máximas en medianías y cumbres de las islas más montañosas y
#> pocos cambios en las mínimas.
#> 
#> Predominará el viento flojo y variable en el interior de la
#> Península; del este, más intenso, en el tercio oriental. Será
#> flojo o moderado, del oeste en el Cantábrico y del norte en
#> Galicia y en Canarias. Podrían darse rachas muy fuertes de viento
#> sur en el interior del País Vasco y en la vertiente cantábrica
#> de Navarra durante la madrugada.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ✖ HTTP 404:
#>   No hay datos que satisfagan esos criterios

# Write and read
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)
#> Error in writeBin(image, tmp): can only write vector objects

gganimate::gif_file(tmp)
```
