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
#> DÍA 29 DE JULIO DE 2026 A LAS 09:13 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 29
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Temperaturas elevadas, por encima de los 35 grados en amplias
#> zonas del interior peninsular, el interior de Mallorca y el sur de
#> Gran Canaria, y de los 40-42 grados en los valles fluviales del
#> cuadrante suroeste, el valle del Ebro y Navarra. No se descartan
#> chubascos localmente fuertes acompañados de tormenta en el
#> Pirineo de Girona.
#> 
#> B.- PREDICCIÓN
#> Comienza la ola de calor. Continúa la estabilidad atmosférica
#> con un predominio de cielos poco nubosos o despejados. Únicamente
#> se esperan nubes bajas en los litorales de Galicia, del
#> Cantábrico y, por la mañana, de Andalucía y Mallorca. Se
#> desarrollarán algunas nubes de evolución en el sistema Ibérico
#> y los Pirineos; en el Pirineo de Girona, podrían darse chubascos
#> localmente fuertes. En Canarias, se esperan cielos con nubes bajas
#> en la vertiente norte y despejados en la sur.
#> 
#> Son probables las brumas en Galicia y en el Cantábrico, con
#> tendencia a remitir durante el día. Se espera calima en el sur de
#> la Península y en el extremo oriental de Canarias.
#> 
#> Las temperaturas máximas subirán en el tercio este, Castilla y
#> León y los archipiélagos, y bajarán, de forma notable, en
#> Galicia y en el Cantábrico. Se prevé rebasar los 35 grados en
#> amplias zonas del interior peninsular, el interior de Mallorca y
#> el sur de Gran Canaria, y los 40-42 grados en los valles fluviales
#> del cuadrante suroeste, en el valle del Ebro y Navarra. Las
#> mínimas subirán de manera generalizada en la Península y en
#> Canarias, de forma notable en el alto Ebro; solo bajarán en
#> Cádiz, el oeste de Galicia y Menorca. Se esperan noches
#> tropicales, sin bajar de 20 grados, en el Mediterráneo y los
#> valles fluviales de la mitad sur.
#> 
#> En el Estrecho, soplará levante moderado, y, en Canarias, alisio
#> con intervalos fuertes y posibles rachas muy fuertes en zonas
#> expuestas. El viento será moderado y del nordeste en los
#> litorales del sureste peninsular; flojo y del oeste en el
#> Cantábrico y norte de Galicia, y flojo y con predominio del
#> suroeste en el resto.
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
