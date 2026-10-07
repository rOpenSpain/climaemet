# Query the AEMET OpenData API

Retrieves data and metadata from AEMET and converts JSON responses to a
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) when
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

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
when possible, otherwise a [raw](https://rdrr.io/r/base/raw.html) vector
or a [character](https://rdrr.io/r/base/character.html) string as
provided by
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
#>  3 394121N BALEARES      60      B087X      BANYALBUFAR        ""       023046E 
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
#> DÍA 06 DE OCTUBRE DE 2026 A LAS 09:20 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MARTES 6
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos y tormentas fuertes en regiones amplias zonas de la
#> Península y en Canarias, pudiendo ser localmente muy fuertes y
#> dejar acumulados significativos en puntos de Galicia y Asturias,
#> así como en sierras del centro y suroeste peninsular, Pirineos y
#> litorales de Cataluña.
#> 
#> B.- PREDICCIÓN
#> Se mantendrá una situación de inestabilidad en la península
#> bajo la influencia de una dana situada sobre el oeste. Así,
#> predominarán cielos nubosos o cubiertos y se darán
#> precipitaciones acompañadas de tormenta en la mayor parte del
#> territorio. Ya desde primeras horas es probable que estas sean
#> fuertes, yendo localmente con granizo en regiones del oeste de la
#> meseta Norte, sur de Galicia y entorno del Sistema Central. No
#> obstante, será por la tarde cuando se esperan las mayores
#> intensidades, y es probable que los chubascos y tormentas fuertes
#> afecten a amplias zonas de la Península; se espera que sean muy
#> fuertes con acumulados significativos en puntos de Galicia,
#> Asturias, Extremadura, oeste de Castilla-La Mancha, Pirineos y
#> litorales de Cataluña. Intervalos nubosos en Baleares con baja
#> probabilidad de algún chubasco aislado. Predominio de intervalos
#> nubosos en Canarias, con probables chubascos y tormentas
#> ocasionales en las islas orientales e interiores de las
#> montañosas, donde se esperan fuertes en medianías y zonas altas.
#> 
#> Probables bancos de niebla matinales en entornos de montaña,
#> Galicia, este peninsular y Baleares. Calima en Canarias con
#> posibles concentraciones significativas en las islas orientales y
#> en menor medida en la mitad sureste peninsular y Baleares, con
#> alguna lluvia de barro.
#> 
#> Las temperaturas máximas descenderán en Canarias y en la mayor
#> parte de la Península, pudiendo hacerlo de forma notable en
#> puntos de Andalucía, de la meseta sur y las Rías Baixas; pocos
#> cambios en el nordeste, litorales del Levante y Baleares. Mínimas
#> en descenso en Andalucía y Cordillera Cantábrica, y sin cambios
#> en el resto.
#> 
#> Predominará el viento flojo de componentes sur y oeste en la
#> Península y Baleares, con intervalos moderados de levante al
#> principio en el Estrecho, y por la tarde arreciando y rolando a
#> oeste en los litorales cantábricos y a sur en los de la fachada
#> oriental. Alisio de flojo a moderado en Canarias.
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
