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
#> DÍA 11 DE JULIO DE 2026 A LAS 09:17 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL SÁBADO 11
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos y tormentas fuertes con granizo en el área cantábrica
#> occidental, con posibilidad de que sean muy fuertes en Galicia.
#> Temperaturas máximas significativamente elevadas en la mayor
#> parte de la Península y Baleares.
#> 
#> B.- PREDICCIÓN
#> Predominarán los cielos poco nubosos o despejados en la mayor
#> parte del país, con nubosidad baja matinal en regiones de
#> Andalucía occidental, Galicia, Cantábrico y puntos de la fachada
#> oriental peninsular que por lo general tenderá a despejar, y con
#> intervalos de nubes altas penetrando desde el sur peninsular a lo
#> largo del día. Por la tarde se formará nubosidad de evolución
#> en zonas del centro y mitad norte peninsular, con chubascos y
#> tormentas fuertes, incluso muy fuertes, acompañadas de granizo en
#> Galicia, siendo también probables a últimas horas en el área
#> cantábrica occidental. También podrá darse algún chubasco
#> aislado en el Pirineo. En Canarias la llegada de un frente poco
#> activo dejará cielos nubosos o cubiertos con precipitaciones en
#> el norte de las islas montañosas e intervalos nubosos con
#> posibilidad de alguna precipitación ocasional en el resto.
#> 
#> Bancos de niebla matinales en regiones de Galicia, Cantábrico y
#> fachada oriental peninsular, con calima en el sureste peninsular y
#> Baleares.
#> 
#> Las temperaturas máximas descenderán en los archipiélagos,
#> litorales mediterráneos, Extremadura y Andalucía occidental,
#> predominando los aumentos en el resto que podrán ser notables en
#> el oeste de Galicia y Cantábrico oriental. Se superarán los 35
#> grados en amplias zonas de la Península y Baleares, incluso
#> llegando a 38 en regiones de la meseta Sur, Andalucía oriental,
#> Ebro y aledaños, Cantábrico oriental, Miño y Mallorca. Mínimas
#> con pocos cambios, predominando los descensos en el cuadrante
#> nordeste y los aumentos en el noroeste. No bajarán de 20 grados
#> en los litorales mediterráneos y regiones de los tercios nordeste
#> y sureste y de la meseta Sur.
#> 
#> Soplará moderado el poniente en los litorales del sur peninsular
#> y el viento del nordeste en los de Galicia, Cantábrico y fachada
#> oriental, así como en Baleares. Predominio del viento de
#> componente sur en el resto, flojo arreciando a moderado por la
#> tarde en amplias zonas. Viento moderado del norte en Canarias.
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
