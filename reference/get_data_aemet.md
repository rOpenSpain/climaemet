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
#> DÍA 08 DE JULIO DE 2026 A LAS 10:18 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 8
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Temperaturas muy altas, con máximas superiores a los 34-36 grados
#> en amplias zonas de la Península y los archipiélagos y a los
#> 38-42 grados en el cuadrante suroeste, valle del Ebro, depresiones
#> del noreste, así como en litorales y prelitorales del
#> Mediterráneo. Posibles tormentas acompañadas de rachas muy
#> fuertes de viento y granizo en el alto Ebro, Navarra, Sistema
#> Ibérico, Cordillera Cantábrica y en los Pirineos.
#> 
#> B.- PREDICCIÓN
#> Persiste la ola de calor. La estabilidad predominará en la
#> Península y en los archipiélagos, aunque el desarrollo de nubes
#> de evolución en el norte y nordeste peninsular podría dejar
#> chubascos y tormentas acompañadas de rachas muy fuertes de viento
#> y granizo en el alto Ebro, Navarra, Sistema Ibérico, Cordillera
#> Cantábrica y en los Pirineos. En las costas atlánticas gallegas
#> y el Cantábrico occidental, se esperan cielos con nubes bajas y
#> algunas brumas; en el resto de la Península y Baleares,
#> predominarán los cielos despejados o con algunas nubes altas, y
#> en Canarias, habrá intervalos nubosos en las islas más
#> occidentales y cielos poco nubosos o despejados en las orientales,
#> aún con presencia de calima ligera.
#> 
#> Las temperaturas máximas bajarán en el sistema Ibérico y la
#> mitad norte, de forma más acusada en el Cantábrico, subirán en
#> el extremo noreste y en el sureste, y se mantendrán sin cambios
#> en el resto. Las mínimas bajarán en el noroeste y subirán en el
#> arco mediterráneo. Se esperan pocos cambios de temperatura en los
#> archipiélagos. Se podrán superar los 36-38 grados en la mayor
#> parte del territorio peninsular y los archipiélagos, salvo en
#> zonas altas, el área cantábrica y el litoral de Alborán. En los
#> valles del Ebro, Tajo, Guadiana y Guadalquivir, el cuadrante
#> suroeste, el litoral de Valencia, Murcia, el sur de Huesca y
#> Lleida, así como en medianías del sur de Gran Canaria, podrán
#> superarse los 40-42 grados. Las mínimas no bajarán de los 20
#> grados en los litorales mediterráneos, el suroeste, el Ebro y
#> Canarias, y de los 25 grados en los valles del Ebro, Tajo,
#> Guadiana y Guadalquivir y en la vertiente sur de las islas
#> Canarias orientales.
#> 
#> Se espera viento flojo de componente oeste en el Cantábrico y el
#> norte en Galicia, flojo y variable en el interior, y en régimen
#> de brisas en el Mediterráneo. En Canarias, el viento será de
#> componente norte y moderado.
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
