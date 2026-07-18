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
[`httr2::resp_body_raw()`](https://rdrr.io/pkg/httr2/man/resp_body_raw.html)
or
[`httr2::resp_body_string()`](https://rdrr.io/pkg/httr2/man/resp_body_raw.html).

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
#> DÍA 17 DE JULIO DE 2026 A LAS 08:54 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL VIERNES 17
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Temperaturas significativamente altas en Baleares, tercio este
#> peninsular y Andalucía. Tormentas en el interior del tercio
#> sudeste peninsular que pueden venir acompañadas de rachas de
#> viento muy fuertes.
#> 
#> B.- PREDICCIÓN
#> Se mantendrá la estabilidad en la mayor parte del país, con
#> cielos poco nubosos o despejados. Únicamente en Galicia y área
#> cantábrica estarán nubosos o cubiertos con probables
#> precipitaciones, en general débiles y ocasionales, pero que a
#> primeras horas podrán ser localmente fuertes en puntos del
#> litoral cantábrico. Asimismo se prevé la entrada de nubosidad de
#> tipo medio y alto por el sureste peninsular y Baleares y por la
#> tarde la formación de nubes de evolución en el tercio oriental,
#> pudiendo dejar alguna tormenta, y que en zonas del sudeste pueden
#> venir acompañadas de rachas de viento muy fuertes. También
#> intervalos nubosos en el norte de las islas Canarias.
#> 
#> Probables bancos de niebla matinales en Galicia y área
#> cantábrica, con calima en el sur y este de la Península y
#> Baleares.
#> 
#> Las temperaturas máximas descenderán en los archipiélagos y en
#> la mayor parte del tercio norte peninsular, exceptuando en el
#> oeste de Galicia en aumento al igual que en el entorno del
#> Guadalquivir  y puntos de Murcia y Alicante. Pocos cambios en el
#> resto. Se superarán los 35 grados en Baleares y amplias zonas de
#> la Península, exceptuando cuadrante noroeste y Cantábrico;
#> pudiendo incluso rebasar los 40 en interiores del sureste y puntos
#> de Alborán y Guadalquivir. Las mínimas descenderán en la mayor
#> parte de la Península, con ligeros aumentos en Baleares y sin
#> cambios en Canarias. No bajarán de 20 grados, incluso localmente
#> de 25, en regiones de Andalucía, Mediterráneo, Canarias e
#> interior de los tercios nordeste y sureste peninsular.
#> 
#> Soplará el alisio en Canarias con intervalos fuertes en zonas
#> expuestas, con viento moderado del sur rolando a norte flojo en
#> Baleares y poniente moderado en los litorales del sur peninsular
#> amainando en Alborán. En el resto viento flojo de componente
#> oeste, salvo en el Cantábrico y Galicia donde será de norte y en
#> el Levante donde será de norte y este; arreciando por la tarde en
#> litorales gallegos y en zonas de interior del centro norte y este
#> peninsular.
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
