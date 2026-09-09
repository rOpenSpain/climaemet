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
#> DÍA 09 DE SEPTIEMBRE DE 2026 A LAS 09:14 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 9
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos y tormentas fuertes o muy fuertes, acompañados de
#> granizo puntualmente grande y rachas de viento muy fuertes, en
#> Baleares, el sureste peninsular y, con acumulados importantes y
#> sin descartar la intensidad torrencial, en Cataluña. Probables
#> rachas muy fuertes de cierzo en el valle del Ebro y de tramontana
#> en el Ampurdán y Baleares. Temperaturas máximas en descenso
#> notable (más de 6 grados) de forma generalizada en la Península
#> y Baleares, e incluso extraordinario (más de 10 grados) en
#> amplias zonas del nordeste peninsular. Temperaturas altas en
#> Canarias y Murcia.
#> 
#> B.- PREDICCIÓN
#> Durante la primera mitad del día, el paso del frente dejará una
#> situación de inestabilidad en el tercio norte, con predominio de
#> cielos nubosos o cubiertos. Por un lado, se esperan
#> precipitaciones débiles o moderadas en la mitad norte y
#> Extremadura; por otro, tormentas y chubascos muy fuertes, incluso
#> de intensidad torrencial y acompañados de granizo puntualmente
#> grande, que dejarán acumulados importantes y continuarán durante
#> la primera mitad en Cataluña. Estas tormentas se extenderán o
#> aparecerán por la tarde con rachas de viento muy fuertes en
#> Baleares, el sureste peninsular y, en menor medida, el sur del
#> sistema Ibérico y otros puntos del sur de Castilla-La Mancha y el
#> este de Andalucía. En el resto de la Península, se esperan
#> cielos poco nubosos en el oeste e intervalos de nubes medias en el
#> este y sur. En Canarias, se prevén cielos con nubes bajas en la
#> vertiente norte y despejados en el resto.
#> 
#> Son probables las brumas matinales en zonas altas del norte
#> peninsular y en Baleares; se espera que continúe la calima en
#> Canarias.
#> 
#> Las máximas descenderán de forma generalizada y en la mayor
#> parte de la Península y en los archipiélagos, con bajadas
#> notables (más de 6 grados) o incluso extraordinarias (más de 10
#> grados) en amplias zonas del nordeste peninsular; únicamente se
#> prevén aumentos en los litorales de Alborán y del sureste y en
#> el oeste de Galicia. Solo se superarán los 35 grados en puntos
#> del Guadalquivir, Alborán, Murcia y Canarias. Las mínimas
#> también bajarán, notablemente en el sistema Ibérico y los
#> Pirineos, de forma menos acusada en el resto. Se mantendrán las
#> noches tropicales, con mínimas por encima de 20 grados, en el sur
#> de la Península y en el Mediterráneo.
#> 
#> Predominará el viento de componente norte en casi toda la
#> Península, flojo o moderado. En el sur y Alborán, el viento
#> será del oeste. Son probables las rachas muy fuertes de cierzo en
#> el Ebro y de tramontana en el Ampurdán y Baleares. En Canarias,
#> soplará el alisio con algún intervalo.
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
