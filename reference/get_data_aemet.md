# Query the AEMET OpenData API

Retrieves data and metadata from AEMET and converts JSON responses to a
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) when
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

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
when possible, otherwise a [raw](https://rdrr.io/r/base/raw.html) vector
or a [character](https://rdrr.io/r/base/character.html) string as
provided by
[`httr2::resp_body_raw()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`httr2::resp_body_string()`](https://httr2.r-lib.org/reference/resp_body_raw.html).

## See also

[`vignette("extending-climaemet", package = "climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md)
provides usage examples.

AEMET OpenData API functions:
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md),
[`aemet_detect_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_detect_api_key.md)

## Examples

``` r
# Run only when AEMET_API_KEY is detected.

url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"

get_data_aemet(url)
#> # A tibble: 926 × 7
#>    latitud provincia     altitud indicativo nombre             indsinop longitud
#>    <chr>   <chr>         <chr>   <chr>      <chr>              <chr>    <chr>   
#>  1 394924N ILLES BALEARS 490     B013X      ESCORCA, LLUC      "08304"  025309E 
#>  2 394744N BALEARES      5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N BALEARES      60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N BALEARES      52      B103B      ANDRATX - SANT ELM ""       022208E 
#>  5 393305N BALEARES      50      B158X      CALVIÀ, ES CAPDEL… ""       022759E 
#>  6 393315N BALEARES      3       B228       PALMA, PUERTO      "08301"  023731E 
#>  7 393832N BALEARES      95      B236C      PALMA, UNIVERSITAT ""       023838E 
#>  8 394406N ILLES BALEARS 1030    B248       SIERRA DE ALFABIA… "08303"  024247E 
#>  9 393621N BALEARES      47      B275E      SON BONET, AEROPU… "08302"  024224E 
#> 10 393339N BALEARES      5       B278       PALMA DE MALLORCA… "08306"  024412E 
#> # ℹ 916 more rows

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
#> → Returning a UTF-8 `character` string.

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 22 DE OCTUBRE DE 2026 A LAS 08:56 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL JUEVES 22
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Rachas muy fuertes de viento del oeste y suroeste en el norte de
#> Galicia y oeste de Asturias. Chubascos con tormenta que podrían
#> ser localmente fuertes o muy fuertes y persistentes en Canarias.
#> 
#> B.- PREDICCIÓN
#> Se espera una jornada marcada por la estabilidad en la Península
#> y Baleares bajo la influencia de las altas presiones. Únicamente
#> en el Cantábrico y Galicia la aproximación de una borrasca
#> dejará cielos nubosos o cubiertos, con precipitaciones en Galicia
#> durante la segunda mitad del día que también afectará en menor
#> medida a zonas aledañas del noroeste y vertiente cantábrica.
#> Intervalos nubosos en el resto del extremo norte peninsular,
#> fachada oriental y norte de Baleares, con posibles chubascos
#> aislados en el norte del archipiélago y nordeste de Cataluña,
#> sin descartar que puedan afectar de forma aislada a los litorales
#> del sureste. Predominio de cielos poco nubosos o con nubes altas
#> en el resto. Tiempo inestable en Canarias bajo la influencia de
#> una dana, que dejará cielos nubosos o con intervalos nubosos en
#> las islas de mayor relieve. Chubascos acompañados de tormenta que
#> podrían ser localmente fuertes o muy fuertes y persistentes en el
#> este de las islas más occidentales. Cielos poco nubosos en el
#> resto del archipiélago.
#> 
#> Probables bancos de niebla matinales dispersos en montañas del
#> norte peninsular, área del Estrecho y Melilla, con presencia de
#> calima ligera en Canarias.
#> 
#> Las máximas aumentarán en las islas Canarias más orientales y
#> en la Península, exceptuando en regiones mediterráneas con
#> descensos; con pocos cambios en el resto. Las mínimas
#> descenderán en buena parte del tercio este peninsular, meseta
#> Norte y Melilla, manteniéndose con pocos cambios en el resto. Se
#> darán heladas débiles en montañas del extremo norte.
#> 
#> Soplará viento moderado de componente norte en Baleares y fachada
#> oriental peninsular, con intervalos fuertes en Ampurdán y una
#> tendencia a rolar a sur moderado. Predominio de viento flojo de
#> componente sur en el resto de la Península rolando a oeste y
#> suroeste y arreciando en el centro norte y noroeste, con
#> intervalos fuertes y rachas muy fuertes en el norte de Galicia y
#> en Asturias. En Canarias, viento de flojo a moderado del este y
#> nordeste.
#> 

# An image.

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ! HTTP status 500:
#>   API rate limit reached.
#> ℹ Retrying.
#> 
#> ℹ Response MIME type: "image/gif".
#> → Returning `raw` bytes. See also `base::writeBin()`.

# Write and read.
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
