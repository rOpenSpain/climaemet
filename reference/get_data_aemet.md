# Query the AEMET OpenData API

Retrieves data and metadata from AEMET and converts JSON responses to a
[tibble](https://tibble.tidyverse.org/reference/tibble.html) when
possible.

## Usage

``` r
get_data_aemet(apidest, verbose = FALSE)

get_metadata_aemet(apidest, verbose = FALSE)
```

## Source

<https://opendata.aemet.es/dist/index.html>.

## Arguments

- apidest:

  A character string containing the destination URL. See
  <https://opendata.aemet.es/dist/index.html>.

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) (if
possible) or the results of the query as provided by
[`httr2::resp_body_raw()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`httr2::resp_body_string()`](https://httr2.r-lib.org/reference/resp_body_raw.html).

## See also

- [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
  configures API authentication.

- [`vignette("extending-climaemet", package = "climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md)
  provides usage examples.

## Examples

``` r
# Run only when AEMET_API_KEY is detected.

url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"

get_data_aemet(url)
#> # A tibble: 920 × 7
#>    latitud provincia     altitud indicativo nombre             indsinop longitud
#>    <chr>   <chr>         <chr>   <chr>      <chr>              <chr>    <chr>   
#>  1 394924N ILLES BALEARS 490     B013X      ESCORCA, LLUC      "08304"  025309E 
#>  2 394744N BALEARES      5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N ILLES BALEARS 60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N BALEARES      52      B103B      ANDRATX - SANT ELM ""       022208E 
#>  5 393305N BALEARES      50      B158X      CALVIÀ, ES CAPDEL… ""       022759E 
#>  6 393315N BALEARES      3       B228       PALMA, PUERTO      "08301"  023731E 
#>  7 393832N ILLES BALEARS 95      B236C      PALMA, UNIVERSITAT ""       023838E 
#>  8 394406N ILLES BALEARS 1030    B248       SIERRA DE ALFABIA… "08303"  024247E 
#>  9 393621N BALEARES      47      B275E      SON BONET, AEROPU… "08302"  024224E 
#> 10 393339N BALEARES      5       B278       PALMA DE MALLORCA… "08306"  024412E 
#> # ℹ 910 more rows

# Metadata.

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

# Get data from any API endpoint.

# Plain text.

plain <- get_data_aemet("/api/prediccion/nacional/hoy")
#> ℹ Response MIME type: "text/plain".
#> → Returning a UTF-8 <character> string.

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 20 DE JULIO DE 2026 A LAS 09:10 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL LUNES 20
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probables tormentas y chubascos fuertes con granizo en el interior
#> sureste peninsular, en el interior de Galicia y en puntos de
#> Tarragona. Temperaturas significativamente elevadas, por encima de
#> 35 grados en amplias zonas de la Península y en Baleares, e
#> incluso de 40 en puntos de Andalucía y del sudeste, y localmente
#> en la Mancha, el nordeste y Mallorca.
#> 
#> B.- PREDICCIÓN
#> Se mantendrá la estabilidad en la mayor parte del país, con
#> temperaturas muy elevadas. Se esperan cielos poco nubosos, con
#> intervalos de nubes medias y altas, y en Canarias de nubes bajas
#> en los nortes. Únicamente en el norte de Galicia y el Cantábrico
#> occidental predominarán los cielos nubosos con posibles
#> precipitaciones débiles y dispersas por la mañana. Por la tarde
#> se formará nubosidad de evolución con posibles chubascos y
#> tormentas localmente fuertes en zonas del interior de Galicia y
#> del tercio oriental peninsular, que en el sudeste y sur de
#> Cataluña podrían dar tormentas secas, localmente fuertes, con
#> rachas muy fuertes e ir con granizo.
#> 
#> Probables bancos de niebla matinales en Galicia y área
#> cantábrica, con calima en la mitad sureste de la Península y
#> Baleares, débil en Canarias.
#> 
#> Las temperaturas máximas en aumento ligero en el este de la
#> Península y en Baleares; sin cambios en el resto y en Canarias.
#> Se superarán los 35 grados en Baleares y amplias zonas de la
#> Península, exceptuando regiones del centro norte y noroeste;
#> siendo probable rebasar los 40 en interiores de Andalucía y del
#> sureste peninsular, sin descartar localmente Mallorca o puntos de
#> las depresiones del nordeste y de La Mancha. Las mínimas en
#> general no sufrirán cambios, con noches tropicales en amplias
#> zonas de la mitad sureste peninsular y en Baleares, pudiendo
#> incluso no bajar de 25 grados en puntos del Mediterráneo y
#> Guadalquivir.
#> 
#> Soplará el alisio en Canarias con intervalos fuertes y posibles
#> rachas muy fuertes en zonas expuestas. Poniente moderado en el
#> golfo de Cádiz y Estrecho, y del norte y nordeste en los
#> litorales de Cataluña, Cantábrico y Galicia, también con
#> intervalos fuertes en este caso. Viento flojo en el resto, aunque
#> arreciando por la tarde, con predominio de la componente oeste
#> salvo en la fachada oriental peninsular, donde lo hará la
#> componente este, y en el noroeste y centro norte, donde lo hará
#> la norte. Flojo de dirección variable en Baleares.
#> 

# An image.

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Response MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read.
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
