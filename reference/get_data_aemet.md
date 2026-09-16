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
#> DÍA 15 DE SEPTIEMBRE DE 2026 A LAS 09:08 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MARTES 15
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Temperaturas máximas elevadas en los valles del Tajo, Guadiana,
#> Guadalquivir y Ebro, también en zonas del interior peninsular. En
#> Canarias, temperaturas máximas elevadas y calima, especialmente
#> en las más orientales. Rachas muy fuertes de cierzo en el valle
#> del Ebro en la segunda mitad.
#> 
#> B.- PREDICCIÓN
#> Se mantendrá una situación de estabilidad generalizada dominada
#> por las altas presiones, con cielos poco nubosos o despejados y
#> sin precipitaciones. Únicamente en el norte de Galicia y área
#> cantábrica la cola de un frente y un cambio de viento provocará
#> un aumento de la nubosidad, acabando por dejar cielos nubosos o
#> cubiertos con probables precipitaciones débiles. Asimismo, se
#> prevén cielos nubosos con nubosidad baja en la costa oeste de
#> Galicia, con probables brumas o nieblas costeras, e intervalos
#> nubosos en el Estrecho y Melilla tendiendo a despejar. Cielos poco
#> nubosos o despejados también en Canarias, excepto algunas nubes
#> bajas matinales en el litoral, y con presencia de calima que
#> podría presentar concentraciones significativas en las islas
#> orientales.
#> 
#> Las temperaturas máximas descenderán en litorales del golfo de
#> Cádiz y especialmente en Galicia y Cantábrico, donde los
#> descensos serán notables en muchas zonas. Predominio de los
#> aumentos en el resto, más acusados en regiones mediterráneas y
#> del interior este. Se superarán los 35 grados en zonas de
#> Canarias e interiores de la vertiente atlántica sur y del tercio
#> nordeste, así como en otros puntos del interior peninsular.
#> Mínimas en descenso en Galicia y con un predominio de los
#> aumentos en el resto. Se darán noches tropicales, sin bajar de 20
#> grados, en el cuadrante suroeste peninsular, litorales
#> mediterráneos y archipiélagos, pudiendo quedar por encima de 25
#> en puntos de Canarias.
#> 
#> Soplará viento moderado de levante en el Estrecho, de componente
#> norte en Canarias y de componentes norte y oeste en el Cantábrico
#> y Galicia, en este caso con intervalos fuertes en sus costas.
#> Viento flojo en el resto con intervalos moderados en otras
#> regiones del tercio norte y de los litorales de la fachada
#> oriental. Cierzo moderado con posibilidad rachas muy fuertes en el
#> Ebro al final del día. Predominará la componente este en
#> Alborán, la sur en el resto del Mediterráneo y las oeste y norte
#> en el resto.
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
