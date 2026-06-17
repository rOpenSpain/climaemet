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
#> DÍA 17 DE JUNIO DE 2026 A LAS 10:43 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 17
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos y tormentas fuertes, con la posibilidad de venir
#> acompañadas de granizo en el noroeste peninsular y la cordillera
#> Cantábrica. Posibilidad de que sean muy fuertes en el interior
#> este de Galicia. También pueden dar en otros puntos de la meseta
#> norte, Extremadura, los Pirineos y la Ibérica norte. Temperaturas
#> máximas que pueden superar los 35-36 grados en amplias zonas del
#> cuadrante suroeste, los 36-38 grados en el noreste y los 38-39
#> grados en los valles del Guadiana y del Guadalquivir.
#> 
#> B.- PREDICCIÓN
#> La estabilidad predominará en buena parte de la Península por la
#> influencia de las altas presiones. En general habrá cielos poco
#> nubosos o despejados en Baleares, el sur y el tercio este. En los
#> litorales norte y de Cataluña son probables los cielos con nubes
#> bajas, aunque con tendencia a abrirse claros durante la tarde.
#> Asimismo, se espera abundante nubosidad de evolución en el
#> cuadrante noroeste peninsular, el sistema Ibérico, Extremadura,
#> el oeste de la meseta sur, los Pirineos y los sistemas Béticos.
#> Se prevén chubascos y tormentas fuertes, e incluso muy fuertes y
#> con la posibilidad de venir acompañadas de granizo, en el
#> interior este de Galicia, el noroeste de Castilla y León y la
#> cordillera Cantábrica. Puntualmente podrían darse chubascos en
#> otros puntos de la meseta norte, Extremadura, los Pirineos y la
#> Ibérica norte. En Canarias, los cielos estarán con intervalos de
#> nubes en el norte, que pueden dejar algo de precipitación, y
#> despejados en el sur.
#> 
#> Son probables las brumas o los bancos de niebla matinales en el
#> interior de Galicia y del Cantábrico.
#> 
#> Las temperaturas máximas subirán de forma generalizada. Se
#> podrán superar los 35-36 grados en amplias zonas del cuadrante
#> suroeste, los 36-38 en el valle del Ebro y los 38-39 en los valles
#> del Guadiana y del Guadalquivir; en este último podrían llegar a
#> los 40. Las mínimas bajarán en el tercio este, se mantendrán
#> sin cambios en los litorales del norte y subirán en el resto. Se
#> prevén noches tropicales, sin bajar de 20 grados, en los valles
#> fluviales del suroeste y los litorales mediterráneos. En Canarias
#> no se esperan cambios térmicos.
#> 
#> Predominará el viento flojo de componente este en el tercio
#> oriental peninsular y Baleares, moderado en el litoral del
#> sureste. Soplará flojo, del norte en el Cantábrico y Galicia y
#> variable en las mesetas. En el Estrecho, el levante será
#> moderado, con algún intervalo de fuerte, y en el suroeste,
#> predominará la componente oeste. En Canarias el alisio será
#> flojo o moderado.
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
