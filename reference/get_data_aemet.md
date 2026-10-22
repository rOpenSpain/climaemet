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
#> ✖ Tu apiKey ha superado el plazo establecido hasta el 15/10/2026 para su renovación. Debes renovar la credencial antes de continuar utilizando el servicio.
#> Error in aemet_api_call(apidest, verbose, apikey = apikey): HTTP 401 Unauthorized.

# Metadata.

get_metadata_aemet(url)
#> ✖ Tu apiKey ha superado el plazo establecido hasta el 15/10/2026 para su renovación. Debes renovar la credencial antes de continuar utilizando el servicio.
#> Error in aemet_api_call(apidest, verbose, apikey = apikey): HTTP 401 Unauthorized.

# Get data from any API endpoint.

# Plain text.

plain <- get_data_aemet("/api/prediccion/nacional/hoy")
#> ℹ Response MIME type: "text/plain".
#> → Returning a UTF-8 `character` string.

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 22 DE OCTUBRE DE 2026 A LAS 08:56 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL JUEVES 22
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Rachas muy fuertes de viento del oeste y suroeste en el norte de
#> Galicia y oeste de Asturias. Chubascos con tormenta que podrían
#> ser localmente fuertes o muy fuertes y persistentes en Canarias.
#> 
#> B.- PREDICCIÓN
#> Se espera una jornada marcada por la estabilidad en la Península
#> y Baleares bajo la influencia de las altas presiones. Únicamente
#> en el Cantábrico y Galicia la aproximación de una borrasca
#> dejará cielos nubosos o cubiertos, con precipitaciones en Galicia
#> durante la segunda mitad del día que también afectará en menor
#> medida a zonas aledañas del noroeste y vertiente cantábrica.
#> Intervalos nubosos en el resto del extremo norte peninsular,
#> fachada oriental y norte de Baleares, con posibles chubascos
#> aislados en el norte del archipiélago y nordeste de Cataluña,
#> sin descartar que puedan afectar de forma aislada a los litorales
#> del sureste. Predominio de cielos poco nubosos o con nubes altas
#> en el resto. Tiempo inestable en Canarias bajo la influencia de
#> una dana, que dejará cielos nubosos o con intervalos nubosos en
#> las islas de mayor relieve. Chubascos acompañados de tormenta que
#> podrían ser localmente fuertes o muy fuertes y persistentes en el
#> este de las islas más occidentales. Cielos poco nubosos en el
#> resto del archipiélago.
#> 
#> Probables bancos de niebla matinales dispersos en montañas del
#> norte peninsular, área del Estrecho y Melilla, con presencia de
#> calima ligera en Canarias.
#> 
#> Las máximas aumentarán en las islas Canarias más orientales y
#> en la Península, exceptuando en regiones mediterráneas con
#> descensos; con pocos cambios en el resto. Las mínimas
#> descenderán en buena parte del tercio este peninsular, meseta
#> Norte y Melilla, manteniéndose con pocos cambios en el resto. Se
#> darán heladas débiles en montañas del extremo norte.
#> 
#> Soplará viento moderado de componente norte en Baleares y fachada
#> oriental peninsular, con intervalos fuertes en Ampurdán y una
#> tendencia a rolar a sur moderado. Predominio de viento flojo de
#> componente sur en el resto de la Península rolando a oeste y
#> suroeste y arreciando en el centro norte y noroeste, con
#> intervalos fuertes y rachas muy fuertes en el norte de Galicia y
#> en Asturias. En Canarias, viento de flojo a moderado del este y
#> nordeste.
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
