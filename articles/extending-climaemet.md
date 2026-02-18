# Extending climaemet

**climaemet** provides several functions for accessing a selection of
endpoints of the [AEMET API
tool](https://opendata.aemet.es/dist/index.html?). However, this package
does not cover in full all the capabilities of the API.

For that reason, we provide the
[`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
function, that allows to access any API endpoint freely. The drawback is
that the user would need to handle the results by him/herself.

``` r
library(climaemet)
```

## Example: Normalized text

Some API endpoints, as `predicciones-normalizadas-texto`, provides the
results as plain text on natural language. These results are not parsed
by **climaemet**, but can be retrieved as this:

``` r
# endpoint, today forecast

today <- "/api/prediccion/nacional/hoy"

# Metadata
knitr::kable(get_metadata_aemet(today))
```

| unidad_generadora                           | descripcion                                                                                                                              | periodicidad                                                                                                                                                                                                               | formato   | copyright                                                                                               | notaLegal                          |
|:--------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------|:--------------------------------------------------------------------------------------------------------|:-----------------------------------|
| Grupo Funcional de Predicción de Referencia | Predicción general nacional para hoy / mañana / pasado mañana / medio plazo (tercer y cuarto día) / tendencia (del quinto al noveno día) | Disponibilidad. Para hoy, solo se confecciona si hay cambios significativos. Para mañana y pasado mañana diaria a las 15:00 h.o.p.. Para el medio plazo diaria a las 16:00 h.o.p.. La tendencia, diaria a las 18:30 h.o.p. | ascii/txt | © AEMET. Autorizado el uso de la información y su reproducción citando a AEMET como autora de la misma. | https://www.aemet.es/es/nota_legal |

``` r

# Data
pred_today <- get_data_aemet(today)
#> ℹ Results are MIME type: "text/plain".
#> → Returning data as UTF-8 string.
```

``` r
# Produce a result

clean <- gsub("\r", "\n", pred_today, fixed = TRUE)
clean <- gsub("\n\n\n", "\n", clean, fixed = TRUE)

cat("<blockquote>", clean, "</blockquote>", sep = "\n")
```

> AGENCIA ESTATAL DE METEOROLOGÍA PREDICCIÓN GENERAL PARA ESPAÑA DÍA 18
> DE FEBRERO DE 2026 A LAS 07:28 HORA OFICIAL PREDICCIÓN VÁLIDA PARA EL
> MIÉRCOLES 18
>
> A.- FENÓMENOS SIGNIFICATIVOS Precipitaciones que pueden ser
> puntualmente fuertes o persistentes en Galicia. Rachas muy fuertes en
> Galicia, Cantábrico, Castilla y León y tercio este peninsular.
>
> B.- PREDICCIÓN Se prevé el paso de un frente por la Península que, de
> oeste a este, tenderá a dejar cielos nubosos o cubiertos en la mayor
> parte del territorio, con un predominio de cielos poco nubosos o con
> intervalos de nubes altas en los tercios este y sureste, así como en
> Baleares durante la mayor parte del día. Este frente, y la posterior
> descarga fría, dejarán precipitaciones en la mitad norte de la
> vertiente atlántica, área cantábrica, alto Ebro y entorno pirenaico,
> pudiendo afectar a otras regiones a excepción del este y sureste. Se
> prevén más abundantes cuanto más al noroeste, pudiendo ser fuertes o
> persistentes en el oeste de Galicia. Asimismo, podrá darse alguna
> tormenta ocasional en regiones del norte peninsular. Nevará a una cota
> de 1200-1500 metros, disminuyendo a 900-1200m en el extremo norte y a
> una cota de 1500/1900m en el resto. Cielos poco nubosos o despejados
> en Canarias.
>
> Probables nieblas matinales en las campiñas del sur de Andalucía,
> meseta así como en zonas bajas del nordeste. Brumas frontales en el
> noroeste peninsular. Posibles restos de calima ligera en Canarias.
>
> Las temperaturas descenderán en la mayor parte del país, exceptuando
> las máximas, que aumentarán en el Cantábrico oriental, Pirineo y
> nordeste de Cataluña. Heladas localmente débiles en el Pirineo.
>
> Predominará viento moderado de componentes oeste y sur en la Península
> y Baleares, en general flojo en interiores del tercio nordeste y
> suroeste peninsular y con intensidad fuerte en litorales del extremo
> noroeste y Alborán. Se esperan rachas muy fuertes en Galicia,
> Cantábrico y Castilla y León. También a últimas horas en el tercio
> oriental peninsular. En Canarias, alisio con intervalos de fuerte en
> zonas expuestas.

## Example: Maps

AEMET also provides map data, usually on `image/gif` format. One way to
get this kind of data is as follows:

``` r
# Endpoint of a map
a_map <- "/api/mapasygraficos/analisis"

# Metadata
knitr::kable(get_metadata_aemet(a_map))
```

| unidad_generadora                 | descripción                                | periodicidad                                                                              | formato   | copyright                                                                                               | notaLegal                          |
|:----------------------------------|:-------------------------------------------|:------------------------------------------------------------------------------------------|:----------|:--------------------------------------------------------------------------------------------------------|:-----------------------------------|
| Grupo Funcional de Jefes de Turno | Mapas de análisis de frentes en superficie | Dos veces al día, a las 02:00 y 14:00 h.o.p. en invierno y a las 03:00 y 15:00 en verano. | image/gif | © AEMET. Autorizado el uso de la información y su reproducción citando a AEMET como autora de la misma. | https://www.aemet.es/es/nota_legal |

``` r
the_map <- get_data_aemet(a_map)
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write as gif and include it
giffile <- "example-gif.gif"
writeBin(the_map, giffile)

# Display on the vignette, it may be rotated
knitr::include_graphics(giffile)
```

![Example: Surface analysis map provided by AEMET](example-gif.gif)

Example: Surface analysis map provided by AEMET
