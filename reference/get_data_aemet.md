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
#> DÍA 14 DE OCTUBRE DE 2026 A LAS 08:58 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 14
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Posibles chubascos localmente fuertes en litorales del sureste
#> peninsular. Probables rachas muy fuertes de levante en el
#> Estrecho.
#> 
#> B.- PREDICCIÓN
#> Se mantendrá una situación de estabilidad en la mayor parte del
#> país, con predominio de cielos poco nubosos o con intervalos de
#> nubes altas. No obstante, en el extremo sureste peninsular la
#> entrada de humedad del Mediterráneo dejará cielos nubosos o
#> cubiertos, con chubascos que podrían ser localmente fuertes en
#> puntos del litoral sureste peninsular, y que pueden extenderse a
#> las islas Baleares. Asimismo, intervalos nubosos con posibilidad
#> de alguna precipitación aislada en otros puntos del
#> Mediterráneo, más probable en el Estrecho, y abundante nubosidad
#> baja matinal en regiones del norte e interior este peninsular, con
#> tendencia a levantar. En Canarias, intervalos de nubes en el norte
#> de las islas montañosas con posibilidad de alguna precipitación
#> a primeras horas, e intervalos de nubes altas en el resto.
#> 
#> Probables brumas y bancos de niebla matinales en regiones de los
#> tercios norte y este peninsulares, pudiendo ser más persistentes
#> en litorales gallegos. Entrada de calima ligera en altura en
#> Canarias.
#> 
#> Las temperaturas máximas descenderán en el cuadrante sureste
#> peninsular y Alborán, con aumentos en Canarias, Cataluña y
#> especialmente en Galicia y Cantábrico, donde podrán ser
#> localmente notables. Pocos cambios en el resto. Las mínimas
#> aumentarán en la mayor parte de la vertiente atlántica sur, así
#> como en Ceuta, Melilla y zonas del Cantábrico. Pocos cambios en
#> el resto predominando los descensos en zonas de montaña.
#> 
#> Soplará levante con intervalos fuertes y probables rachas muy
#> fuertes en el Estrecho, con viento moderado también del este y
#> nordeste en litorales de Alborán, sureste peninsular, Cantábrico
#> y Galicia donde amainará. Tramontana moderada en Ampurdán y
#> norte de Baleares también amainando y alisio moderado en
#> Canarias. En el resto viento flojo predominando la componente
#> este.
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
