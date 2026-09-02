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
#> DÍA 02 DE SEPTIEMBRE DE 2026 A LAS 15:03 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 2
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probables tormentas fuertes en el sistema Ibérico, este de
#> Castilla la Mancha y en sierras del sureste. Probables rachas muy
#> fuertes de levante en el Estrecho. Temperaturas altas en el centro
#> y sur peninsular.
#> 
#> B.- PREDICCIÓN
#> Se prevé que se mantenga la situación de estabilidad dominada
#> por  altas presiones, con cielos poco nubosos o despejados en
#> general en la Península y Baleares. Únicamente en el Estrecho,
#> litoral de Alborán, Ceuta y Melilla, se esperan cielos con nubes
#> bajas y alguna llovizna aislada. Asimismo, también se esperan
#> nubes bajas a primeras horas en las regiones del norte peninsular,
#> con tendencia general a despejar. Por la tarde, se formarán nubes
#> de evolución en los interiores del tercio oriental, con
#> posibilidad de alguna tormenta, sin descartar que vayan
#> acompañadas de precipitaciones y rachas de viento muy fuertes, y
#> quizá granizo, en el sistema Ibérico y en sierras del sureste.
#> En Canarias, se esperan nubes bajas en la vertiente norte de las
#> islas e intervalos de nubes altas en las islas más orientales.
#> 
#> Son probables los bancos de niebla matinales en el norte
#> peninsular, el interior sureste y Baleares y las nieblas costeras
#> en el Estrecho y Alborán. Se espera la presencia de calima en
#> Alborán, el sureste peninsular, Baleares y las islas Canarias
#> orientales.
#> 
#> Las temperaturas máximas aumentarán en la Península y Baleares,
#> de forma menos acusada en los litorales. Se superarán los 35
#> grados en amplias zonas del cuadrante suroeste y de la meseta sur,
#> el valle del Ebro, las depresiones del nordeste, Mallorca y,
#> puntualmente, en zonas bajas del sistema Central y los Pirineos.
#> Las mínimas subirán ligeramente o se mantendrán sin cambios en
#> general. Se esperan noches tropicales, sin bajar de 20 grados, en
#> los litorales mediterráneos, las depresiones del nordeste y las
#> zonas bajas de Andalucía. En Canarias, las temperaturas
#> descienden ligeramente.
#> 
#> Se espera un predominio de viento flojo y variable en el interior
#> peninsular y de brisas en el Mediterráneo. El levante será
#> moderado en el sureste, el litoral de Alborán y el Estrecho,
#> donde además podrán darse rachas muy fuertes. En el Cantábrico,
#> soplará del este, flojo. En Canarias, el alisio moderado
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
