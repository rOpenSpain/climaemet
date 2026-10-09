# Extending climaemet

**climaemet** provides functions for selected [**AEMET OpenData API**
endpoints](https://opendata.aemet.es/dist/index.html). However, the
package does not cover every endpoint.

[`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
provides access to any **AEMET OpenData API** endpoint. Users must parse
endpoint-specific results themselves.

``` r

library(climaemet)
```

## Retrieve normalized text

Some API endpoints, such as `predicciones-normalizadas-texto`, return
plain text. **climaemet** does not parse these responses, but you can
retrieve them directly:

``` r

# Endpoint: today's forecast.

today <- "/api/prediccion/nacional/hoy"

# Retrieve metadata.
knitr::kable(get_metadata_aemet(today))
```

| unidad_generadora | descripcion | periodicidad | formato | copyright | notaLegal |
|:---|:---|:---|:---|:---|:---|
| Grupo Funcional de Predicción de Referencia | Predicción general nacional para hoy / mañana / pasado mañana / medio plazo (tercer y cuarto día) / tendencia (del quinto al noveno día) | Disponibilidad. Para hoy, solo se confecciona si hay cambios significativos. Para mañana y pasado mañana diaria a las 15:00 h.o.p.. Para el medio plazo diaria a las 16:00 h.o.p.. La tendencia, diaria a las 18:30 h.o.p. | ascii/txt | © AEMET. Autorizado el uso de la información y su reproducción citando a AEMET como autora de la misma. | https://www.aemet.es/es/nota_legal |

``` r


# Retrieve data.
pred_today <- get_data_aemet(today)
#> ℹ Response MIME type: "text/plain".
#> → Returning a UTF-8 `character` string.
```

``` r

# Produce a result.

clean <- gsub("\r", "\n", pred_today, fixed = TRUE)
clean <- gsub("\n\n\n", "\n", clean, fixed = TRUE)

cat("<blockquote>", clean, "</blockquote>", sep = "\n")
```

> AGENCIA ESTATAL DE METEOROLOGÍA PREDICCIÓN GENERAL PARA ESPAÑA DÍA 09
> DE OCTUBRE DE 2026 A LAS 08:16 HORA OFICIAL PREDICCIÓN VÁLIDA PARA EL
> VIERNES 9
>
> A.- FENÓMENOS SIGNIFICATIVOS Probables chubascos y tormentas
> localmente en litorales del sudeste durante la madrugada y con menor
> probabilidad a lo largo de la jornada en Baleares y Lanzarote. Rachas
> muy fuertes en el Ampurdán y norte de Baleares de tramontana, en el
> Ebro de cierzo de madrugada y en las cumbres de Pirineos de norte.
>
> B.- PREDICCIÓN Este día se prevé una estabilización en el norte
> peninsular con la entrada de altas presiones; por el contrario, la
> transición de una vaguada a dana entre el sudoeste peninsular y
> Canarias inestabilizará este entorno. Así, en el extremo norte se
> esperan cielos nubosos con alguna llovizna y tendencia a despejar.
> Mientras que en el tercio sur, Alborán y Canarias se espera abundante
> nubosidad, que podría dejar precipitaciones débiles, o localmente
> moderadas, en Ceuta y Melilla, así como chubascos y tormentas en los
> litorales del sudeste durante la madrugada. Asimismo, en Baleares se
> esperan chubascos, sin descartar que también sean localmente fuertes.
> En el resto de la Península se prevé un tiempo más estable, con cielos
> poco nubosos. En Canarias, se esperan intervalos nubosos con chubascos
> localmente moderados, sin descartar que alguno sea puntualmente fuerte
> y acompañado de tormenta en Lanzarote por la cercanía de la dana.
>
> Brumas y bancos de niebla matinales en montañas y la meseta de la
> mitad norte, el sudeste y en Alborán.
>
> Las temperaturas máximas descenderán en el arco mediterráneo y la
> mitad sur, mientras que en el resto no se esperan cambios, salvo algún
> ascenso en montañas y en Galicia. Las mínimas en descenso, salvo en el
> extremo sur y Canarias, donde no se esperan cambios. Probables heladas
> débiles en zonas altas de montaña de la mitad norte.
>
> Soplará tramontana fuerte con rachas muy fuertes en Ampurdán y norte
> de Baleares, cierzo moderado con intervalos fuertes y rachas muy
> fuertes en el bajo Ebro, tendiendo a amainar, y viento moderado del
> nordeste en los litorales del Cantábrico y Galicia, yendo a menos. En
> las cumbres de Pirineos se esperan rachas muy fuertes de norte.
> Levante moderado con intervalos de fuerte en el Estrecho y Alborán.
> Viento flojo del norte y este en el resto, con intervalos moderados en
> zonas expuestas de interior.

## Retrieve maps

AEMET also provides maps, usually with the `image/gif` MIME type. You
can retrieve these binary responses directly:

``` r

# Map endpoint.
a_map <- "/api/mapasygraficos/analisis"

# Retrieve metadata.
knitr::kable(get_metadata_aemet(a_map))
```

| unidad_generadora | descripción | periodicidad | formato | copyright | notaLegal |
|:---|:---|:---|:---|:---|:---|
| Grupo Funcional de Jefes de Turno | Mapas de análisis de frentes en superficie | Dos veces al día, a las 02:00 y 14:00 h.o.p. en invierno y a las 03:00 y 15:00 en verano. | image/gif | © AEMET. Autorizado el uso de la información y su reproducción citando a AEMET como autora de la misma. | https://www.aemet.es/es/nota_legal |

``` r

the_map <- get_data_aemet(a_map)
#> ℹ Response MIME type: "image/gif".
#> → Returning `raw` bytes. See also `base::writeBin()`.

# Write as GIF and include it.
giffile <- "example-gif.gif"
writeBin(the_map, giffile)

# Display in the vignette. It may be rotated.
knitr::include_graphics(giffile)
```

![Surface weather analysis map with pressure contours and weather fronts
over Europe and the North Atlantic. High- and low-pressure centers and
front symbols describe the weather systems around the Iberian Peninsula.
The analysis date and time are printed on the map. ](example-gif.gif)

Example: surface analysis map provided by AEMET
