# Client tool for the AEMET API

Client tool to retrieve data and metadata from AEMET and convert JSON to
a [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).

## Usage

``` r
get_data_aemet(apidest, verbose = FALSE)

get_metadata_aemet(apidest, verbose = FALSE)
```

## Source

<https://opendata.aemet.es/dist/index.html>.

## Arguments

- apidest:

  Character string with a destination URL. See
  <https://opendata.aemet.es/dist/index.html>.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) (if
possible) or the results of the query as provided by
[`httr2::resp_body_raw()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`httr2::resp_body_string()`](https://httr2.r-lib.org/reference/resp_body_raw.html).

## See also

See examples of how to use these functions in
[`vignette("extending-climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md).

## Examples

``` r
# Run this example only if AEMET_API_KEY is detected.

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

# Get data from any API endpoint.

# Plain text

plain <- get_data_aemet("/api/prediccion/nacional/hoy")
#> ℹ Results are MIME type: "text/plain".
#> → Returning data as UTF-8 string.

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 06 DE JUNIO DE 2026 A LAS 08:46 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL SÁBADO 6
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Rachas muy fuertes (superiores a 70 km/h) de alisio en Canarias.
#> Probabilidad de chubascos localmente fuertes en el Pirineo
#> oriental. Ascenso notable de las temperaturas máximas (superior a
#> 6 grados) en interiores de la Comunidad Valenciana y el Ampurdán.
#> 
#> B.- PREDICCIÓN
#> Se prevé una situación de estabilidad en la mayor parte del
#> país, con predominio de cielos poco nubosos o despejados.
#> Únicamente en Galicia y el área cantábrica el paso de un frente
#> poco activo dejará cielos nubosos o cubiertos con precipitaciones
#> débiles avanzando de oeste a este, tendiendo a poco nuboso en
#> Galicia. Asimismo, se prevén intervalos de nubes bajas en
#> regiones del tercio este peninsular, Estrecho y Alborán, así
#> como en el norte de las islas Canarias a primeras y últimas
#> horas, y por la tarde nubosidad de evolución en montañas del
#> este, con chubascos ocasionales en el Pirineo oriental que
#> podrían ser localmente fuertes e ir acompañados de tormenta.
#> 
#> Probables brumas y nieblas costeras en Alborán que a primeras
#> horas también podrán afectar a zonas de interior del propio
#> Alborán y del resto del área mediterránea.
#> 
#> Las temperaturas máximas ascenderán de forma prácticamente
#> generalizada, notablemente en interiores de la Comunidad
#> Valenciana y el Ampurdán, exceptuando Alborán y el Cantábrico,
#> donde descenderán. Las mínimas también aumentarán en la
#> Península, exceptuando el cuadrante sureste y la fachada
#> oriental, donde no se esperan cambios significativos. Igualmente,
#> sin cambios en las islas.
#> 
#> Soplará alisio fuerte con rachas muy fuertes en Canarias, con
#> viento moderado del oeste en el Cantábrico y norte de Galicia con
#> posibilidad de algún intervalo fuerte tendiendo a amainar, y
#> viento flojo en el resto. Predominará la componente este en
#> regiones del Mediterráneo y las norte y oeste en el resto,
#> arreciando por la tarde en el Ebro, meseta Norte y litorales
#> atlánticos gallegos.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read.
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
