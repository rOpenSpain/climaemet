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
#>  3 394121N ILLES BALEARS 60      B087X      BANYALBUFAR        ""       023046E 
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
#> DÍA 23 DE SEPTIEMBRE DE 2026 A LAS 09:42 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 23
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Temperaturas elevadas en el suroeste de Galicia, zonas bajas del
#> cuadrante suroeste y la provincia de Las Palmas. Ascenso notable
#> de las temperaturas máximas en la mitad occidental de Lanzarote y
#> Fuerteventura.
#> 
#> B.- PREDICCIÓN
#> Continúa la situación de estabilidad generalizada dominada por
#> las altas presiones con cielos poco nubosos o despejados y
#> ausencia de precipitaciones. Únicamente en los litorales del
#> extremo norte se darán intervalos nubosos con posibles brumas
#> costeras que localmente afecten a zonas de interior. Asimismo,
#> habrá algunos intervalos de nubes bajas matinales en los
#> litorales mediterráneos del sureste, Alborán y Estrecho. Poco
#> nuboso o con intervalos de nubes altas en Canarias, con probable
#> calima en altura y sin descartar algún chubasco en el Teide.
#> 
#> Las temperaturas máximas descenderán en zonas litorales y
#> prelitorales del Cantábrico occidental y Comunidad Valenciana. En
#> la mitad sur, las temperaturas sufrirán ascensos ligeros, así
#> como en el alto Ebro y Pirineos occidentales. Pocos cambios en las
#> temperaturas mínimas, con tendencia a descender en zonas bajas y
#> a ascender en las altas. Ascensos en Canarias, incluso notables
#> para las máximas en el litoral occidental de Lanzarote y
#> Fuerteventura. Se superarán los 35 grados en zonas de la
#> vertiente atlántica sur, pudiendo hacerlo también en puntos de
#> Galicia y la provincia de Las Palmas.
#> 
#> Soplará levante moderado en Alborán y con intervalos fuertes en
#> el Estrecho, viento moderado de componente nordeste en Canarias,
#> litorales de Galicia, Ampurdán, Baleares y de norte en el
#> Cantábrico. En el resto, viento flojo con predominio de las
#> componentes norte y este, y con intervalos moderados en otras
#> zonas de litoral y el Ebro.
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
