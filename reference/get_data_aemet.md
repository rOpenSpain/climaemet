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
#> DÍA 09 DE OCTUBRE DE 2026 A LAS 08:16 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL VIERNES 9
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probables chubascos y tormentas localmente en litorales del
#> sudeste durante la madrugada y con menor probabilidad a lo largo
#> de la jornada en Baleares y Lanzarote. Rachas muy fuertes en el
#> Ampurdán y norte de Baleares de tramontana, en el Ebro de cierzo
#> de madrugada y en las cumbres de Pirineos de norte.
#> 
#> B.- PREDICCIÓN
#> Este día se prevé una estabilización en el norte peninsular con
#> la entrada de altas presiones; por el contrario, la transición de
#> una vaguada a dana entre el sudoeste peninsular y Canarias
#> inestabilizará este entorno. Así, en el extremo norte se esperan
#> cielos nubosos con alguna llovizna y tendencia a despejar.
#> Mientras que en el tercio sur, Alborán y Canarias se espera
#> abundante nubosidad, que podría dejar precipitaciones débiles, o
#> localmente moderadas, en Ceuta y Melilla, así como chubascos y
#> tormentas en los litorales del sudeste durante la madrugada.
#> Asimismo, en Baleares se esperan chubascos, sin descartar que
#> también sean localmente fuertes. En el resto de la Península se
#> prevé un tiempo más estable, con cielos poco nubosos. En
#> Canarias, se esperan intervalos nubosos con chubascos localmente
#> moderados, sin descartar que alguno sea puntualmente fuerte y
#> acompañado de tormenta en Lanzarote por la cercanía de la dana.
#> 
#> Brumas y bancos de niebla matinales en montañas y la meseta de la
#> mitad norte, el sudeste y en Alborán.
#> 
#> Las temperaturas máximas descenderán en el arco mediterráneo y
#> la mitad sur, mientras que en el resto no se esperan cambios,
#> salvo algún ascenso en montañas y en Galicia. Las mínimas en
#> descenso, salvo en el extremo sur y Canarias, donde no se esperan
#> cambios. Probables heladas débiles en zonas altas de montaña de
#> la mitad norte.
#> 
#> Soplará tramontana fuerte con rachas muy fuertes en Ampurdán y
#> norte de Baleares, cierzo moderado con intervalos fuertes y rachas
#> muy fuertes en el bajo Ebro, tendiendo a amainar, y viento
#> moderado del nordeste en los litorales del Cantábrico y Galicia,
#> yendo a menos. En las cumbres de Pirineos se esperan rachas muy
#> fuertes de norte. Levante moderado con intervalos de fuerte en el
#> Estrecho y Alborán. Viento flojo del norte y este en el resto,
#> con intervalos moderados en zonas expuestas de interior.
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
