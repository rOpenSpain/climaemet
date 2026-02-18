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
#> DÍA 18 DE FEBRERO DE 2026 A LAS 07:28 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 18
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Precipitaciones que pueden ser puntualmente fuertes o persistentes
#> en Galicia. Rachas muy fuertes en Galicia, Cantábrico, Castilla y
#> León y tercio este peninsular.
#> 
#> B.- PREDICCIÓN
#> Se prevé el paso de un frente por la Península que, de oeste a
#> este, tenderá a dejar cielos nubosos o cubiertos en la mayor
#> parte del territorio, con un predominio de cielos poco nubosos o
#> con intervalos de nubes altas en los tercios este y sureste, así
#> como en Baleares durante la mayor parte del día. Este frente, y
#> la posterior descarga fría, dejarán precipitaciones en la mitad
#> norte de la vertiente atlántica, área cantábrica, alto Ebro y
#> entorno pirenaico, pudiendo afectar a otras regiones a excepción
#> del este y sureste. Se prevén más abundantes cuanto más al
#> noroeste, pudiendo ser fuertes o persistentes en el oeste de
#> Galicia. Asimismo, podrá darse alguna tormenta ocasional en
#> regiones del norte peninsular. Nevará a una cota de 1200-1500
#> metros, disminuyendo a 900-1200m en el extremo norte y a una cota
#> de 1500/1900m en el resto. Cielos poco nubosos o despejados en
#> Canarias.
#> 
#> Probables nieblas matinales en las campiñas del sur de
#> Andalucía, meseta así como en zonas bajas del nordeste. Brumas
#> frontales en el noroeste peninsular. Posibles restos de calima
#> ligera en Canarias.
#> 
#> Las temperaturas descenderán en la mayor parte del país,
#> exceptuando las máximas, que aumentarán en el Cantábrico
#> oriental, Pirineo y nordeste de Cataluña. Heladas localmente
#> débiles en el Pirineo.
#> 
#> Predominará viento moderado de componentes oeste y sur en la
#> Península y Baleares, en general flojo en interiores del tercio
#> nordeste y suroeste peninsular y con intensidad fuerte en
#> litorales del extremo noroeste y Alborán. Se esperan rachas muy
#> fuertes en Galicia, Cantábrico y Castilla y León. También a
#> últimas horas en el tercio oriental peninsular. En Canarias,
#> alisio con intervalos de fuerte en zonas expuestas.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
