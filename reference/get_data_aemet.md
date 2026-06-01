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
#> DÍA 27 DE MAYO DE 2026 A LAS 08:32 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 27
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Tormentas localmente fuertes en el noroeste. Temperaturas máximas
#> que superarán los 34-36 grados en el cuadrante suroeste, valle
#> del Ebro, depresiones del nordeste peninsular, interiores del
#> Cantábrico y de Galicia y puntos de la meseta norte, y podrán
#> rebasar los 36-38 grados en el Guadiana y Guadalquivir. Rachas de
#> levante muy fuertes en el Estrecho.
#> 
#> B.- PREDICCIÓN
#> Se prevé una situación de estabilidad generalizada en el país,
#> con predominio de cielos poco nubosos o despejados, además de
#> algunos intervalos de nubes altas, aunque con nubosidad de
#> evolución diurna en el cuadrante noroeste peninsular y en otras
#> montañas de la mitad norte, con algunos chubascos y tormentas
#> localmente fuertes, acompañadas de granizo y con rachas muy
#> fuertes asociadas. Por otro lado, se esperan intervalos de nubes
#> bajas en zonas de los litorales de Galicia, del Cantábrico, de
#> Cataluña y de Baleares, con posible formación de brumas y bancos
#> de niebla costeros.
#> 
#> La calima tenderá a menos en Canarias y podrá afectar también a
#> zonas de los extremos oeste y sur peninsulares.
#> 
#> Las temperaturas descenderán en Canarias y en el Cantábrico
#> oriental, y aumentarán de forma predominante en el resto de la
#> Península, de forma ligera en el caso de las mínimas. Sin
#> cambios térmicos en Baleares. Se mantendrán en valores elevados
#> para la época en amplias zonas del país, superando los 34-36
#> grados en el cuadrante suroeste, valle del Ebro, depresiones del
#> nordeste peninsular, interiores del Cantábrico y de Galicia, y
#> puntos de la meseta norte, y podrán rebasar los 36-38 grados en
#> el Guadiana y Guadalquivir, donde las mínimas no bajarán de 20
#> grados.
#> 
#> Soplará viento flojo con predominio de las componentes este y sur
#> en la Península, con intervalos fuertes y posibilidad de alguna
#> racha muy fuerte en el Estrecho, y viento moderado en zonas
#> aledañas y litorales del sureste. Régimen de brisas en el resto
#> de litorales mediterráneos, con la componente sur arreciando.
#> Viento moderado de componente norte en Canarias y flojo de
#> dirección variable en Baleares.
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
