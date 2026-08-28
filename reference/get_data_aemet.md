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
#> DÍA 24 DE AGOSTO DE 2026 A LAS 11:39 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL LUNES 24
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Precipitaciones localmente fuertes y persistentes en el noroeste y
#> oeste del Sistema Central. Chubascos y tormentas fuertes o muy
#> fuertes, acompañadas de rachas de viento muy fuertes y de
#> granizo, ocasionalmente grande, en el noreste. Probables rachas
#> muy fuertes de viento (superiores a 70 km/h) en Galicia, las
#> mesetas y las zonas de montaña de la mitad norte. Descenso
#> notable de las temperaturas máximas (más de 6 grados) en el
#> oeste de la meseta norte y del sistema Central.
#> 
#> B.- PREDICCIÓN
#> La borrasca situada al oeste de Portugal se aproximará y dejará
#> una jornada inestable en buena parte de la Península y Baleares.
#> Se prevé que los frentes asociados a la borrasca recorran el
#> oeste peninsular y dejen cielos muy nubosos o cubiertos y
#> precipitaciones localmente fuertes y persistentes, especialmente
#> en zonas del noroeste. Por otro lado, en Baleares y en el noreste
#> se esperan cielos nubosos con chubascos y tormentas, que en puntos
#> del tercio noreste peninsular pueden ser fuertes o muy fuertes e
#> ir acompañadas de rachas muy fuertes y de granizo, ocasionalmente
#> grande, y sin descartar la formación de algún tornado. Solo en
#> algunos puntos del centro los cielos estarán poco nubosos o
#> despejados. En Canarias, cielos nubosos en el norte de las islas
#> con alguna precipitación débil en las montañosas.
#> 
#> Es posible la formación de brumas matinales en Galicia, el
#> interior de las regiones del Cantábrico, el alto Ebro y buena
#> parte de los interiores del tercio este.
#> 
#> Las temperaturas máximas bajarán de forma generalizada, incluso
#> notablemente en el oeste de la meseta norte y del sistema Central,
#> salvo en los litorales, en los prelitorales mediterráneos y en
#> los archipiélagos, donde se mantendrán sin cambios o subirán.
#> Se podrán superar los 35 grados en puntos del valle del Ebro, de
#> Mallorca y en los prelitorales del Levante. Las mínimas subirán
#> en el Cantábrico oriental, puntos del suroeste y Canarias y no
#> variarán de forma relevante en el resto.
#> 
#> Se espera un predominio del viento del suroeste o sur en la
#> Península, moderado en general y con intervalos localmente
#> fuertes. Son probables las rachas muy fuertes en Galicia, las
#> mesetas y las zonas de montaña de la mitad norte. En el Levante y
#> Baleares soplará del sudeste, rolando a sudoeste. En el litoral
#> del mar de Alborán, se espera un poniente moderado, sin descartar
#> rachas muy fuertes. En Canarias, el viento del norte rolará a
#> noreste a últimas horas, con intensidad moderada.
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
