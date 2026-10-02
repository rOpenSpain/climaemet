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
#> ! HTTP status 500:
#>   API rate limit reached.
#> ℹ Retrying.
#> 
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
#> DÍA 27 DE SEPTIEMBRE DE 2026 A LAS 08:44 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL DOMINGO 27
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos y tormentas localmente fuertes en el norte de Castilla y
#> León, interior oriental de Cantabria, País Vasco y La Rioja con
#> probable granizo asociado. No se descartan chubascos localmente
#> fuertes en el noroeste de Galicia. Rachas puntualmente muy fuertes
#> en el Estrecho y zonas expuestas de la provincia de Cádiz.
#> 
#> B.- PREDICCIÓN
#> Una masa de aire frío en altura dejará una jornada con abundante
#> nubosidad en la mitad oeste. Se esperan cielos muy nubosos o
#> cubiertos en Galicia y Asturias, donde se podrán producir
#> precipitaciones en la segunda mitad del día, localmente fuertes
#> en el noroeste gallego, y sin descartar alguna tormenta aislada;
#> se formarán algunas nubes bajas con brumas asociadas en los
#> litorales y prelitorales mediterráneos, el Estrecho y Baleares,
#> mientras que en el resto de la Península se prevén intervalos de
#> nubes medias. A últimas horas, se pueden producir chubascos y
#> tormentas que podrían afectar al norte de Castilla y León,
#> interior oriental de Cantabria, La Rioja y el País Vasco, que
#> pueden ser puntualmente fuertes y con probable granizo asociado.
#> En Canarias, se prevén intervalos de nubes medias y algo de
#> calima en altura y no se descartan chubascos con alguna tormenta
#> que pueden afectar a las islas más occidentales.
#> 
#> Las temperaturas máximas ascenderán en el Cantábrico oriental y
#> descenderán en el resto, de forma más acusada en Galicia, donde
#> pueden ser notables. Las mínimas bajarán en el sureste y
#> subirán en el resto. En Canarias se espera un descenso, mientras
#> que en Baleares no se esperan cambios significativos. Podrán
#> superarse los 35 grados en el valle del Guadalquivir.
#> 
#> El levante será moderado en Alborán y con intervalos de fuerte y
#> con alguna racha puntual muy fuerte en el Estrecho y zonas
#> expuestas de la provincia de Cádiz. En Canarias, el viento será
#> moderado y del este o nordeste, y, en Baleares, moderado y del
#> este. En cuanto al resto de la Península, predominarán las
#> brisas en los litorales mediterráneos, el viento moderado y de
#> componente sur en el interior, el viento variable en el
#> Cantábrico y Galicia.
#> 

# An image.

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Response MIME type: "image/gif".
#> → Returning `raw` bytes. See also `base::writeBin()`.

# Write and read.
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
