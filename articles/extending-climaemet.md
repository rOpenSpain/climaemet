# Extending climaemet

**climaemet** provides functions for selected endpoints from the [AEMET
API tool](https://opendata.aemet.es/dist/index.html?). However, the
package does not cover every API capability.

For that reason,
[`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
allows access to any API endpoint. Users need to parse endpoint-specific
results themselves.

``` r

library(climaemet)
```

## Example: normalized text

Some API endpoints, such as `predicciones-normalizadas-texto`, return
plain natural language text. **climaemet** does not parse these results,
but you can retrieve them directly:

``` r

# Endpoint: today's forecast.

today <- "/api/prediccion/nacional/hoy"

# Metadata
knitr::kable(get_metadata_aemet(today))
```

| unidad_generadora | descripcion | periodicidad | formato | copyright | notaLegal |
|:---|:---|:---|:---|:---|:---|
| Grupo Funcional de Predicción de Referencia | Predicción general nacional para hoy / mañana / pasado mañana / medio plazo (tercer y cuarto día) / tendencia (del quinto al noveno día) | Disponibilidad. Para hoy, solo se confecciona si hay cambios significativos. Para mañana y pasado mañana diaria a las 15:00 h.o.p.. Para el medio plazo diaria a las 16:00 h.o.p.. La tendencia, diaria a las 18:30 h.o.p. | ascii/txt | © AEMET. Autorizado el uso de la información y su reproducción citando a AEMET como autora de la misma. | https://www.aemet.es/es/nota_legal |

``` r


# Data
pred_today <- get_data_aemet(today)
#> ℹ Results are MIME type: "text/plain".
#> → Returning data as UTF-8 string.
```

``` r

# Produce a result.

clean <- gsub("\r", "\n", pred_today, fixed = TRUE)
clean <- gsub("\n\n\n", "\n", clean, fixed = TRUE)

cat("<blockquote>", clean, "</blockquote>", sep = "\n")
```

> AGENCIA ESTATAL DE METEOROLOGÍA PREDICCIÓN GENERAL PARA ESPAÑA DÍA 06
> DE JUNIO DE 2026 A LAS 08:46 HORA OFICIAL PREDICCIÓN VÁLIDA PARA EL
> SÁBADO 6
>
> A.- FENÓMENOS SIGNIFICATIVOS Rachas muy fuertes (superiores a 70 km/h)
> de alisio en Canarias. Probabilidad de chubascos localmente fuertes en
> el Pirineo oriental. Ascenso notable de las temperaturas máximas
> (superior a 6 grados) en interiores de la Comunidad Valenciana y el
> Ampurdán.
>
> B.- PREDICCIÓN Se prevé una situación de estabilidad en la mayor parte
> del país, con predominio de cielos poco nubosos o despejados.
> Únicamente en Galicia y el área cantábrica el paso de un frente poco
> activo dejará cielos nubosos o cubiertos con precipitaciones débiles
> avanzando de oeste a este, tendiendo a poco nuboso en Galicia.
> Asimismo, se prevén intervalos de nubes bajas en regiones del tercio
> este peninsular, Estrecho y Alborán, así como en el norte de las islas
> Canarias a primeras y últimas horas, y por la tarde nubosidad de
> evolución en montañas del este, con chubascos ocasionales en el
> Pirineo oriental que podrían ser localmente fuertes e ir acompañados
> de tormenta.
>
> Probables brumas y nieblas costeras en Alborán que a primeras horas
> también podrán afectar a zonas de interior del propio Alborán y del
> resto del área mediterránea.
>
> Las temperaturas máximas ascenderán de forma prácticamente
> generalizada, notablemente en interiores de la Comunidad Valenciana y
> el Ampurdán, exceptuando Alborán y el Cantábrico, donde descenderán.
> Las mínimas también aumentarán en la Península, exceptuando el
> cuadrante sureste y la fachada oriental, donde no se esperan cambios
> significativos. Igualmente, sin cambios en las islas.
>
> Soplará alisio fuerte con rachas muy fuertes en Canarias, con viento
> moderado del oeste en el Cantábrico y norte de Galicia con posibilidad
> de algún intervalo fuerte tendiendo a amainar, y viento flojo en el
> resto. Predominará la componente este en regiones del Mediterráneo y
> las norte y oeste en el resto, arreciando por la tarde en el Ebro,
> meseta Norte y litorales atlánticos gallegos.

## Example: maps

AEMET also provides map data, usually in `image/gif` format. You can
retrieve this kind of data directly:

``` r

# Map endpoint.
a_map <- "/api/mapasygraficos/analisis"

# Metadata
knitr::kable(get_metadata_aemet(a_map))
```

| unidad_generadora | descripción | periodicidad | formato | copyright | notaLegal |
|:---|:---|:---|:---|:---|:---|
| Grupo Funcional de Jefes de Turno | Mapas de análisis de frentes en superficie | Dos veces al día, a las 02:00 y 14:00 h.o.p. en invierno y a las 03:00 y 15:00 en verano. | image/gif | © AEMET. Autorizado el uso de la información y su reproducción citando a AEMET como autora de la misma. | https://www.aemet.es/es/nota_legal |

``` r

the_map <- get_data_aemet(a_map)
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write as GIF and include it.
giffile <- "example-gif.gif"
writeBin(the_map, giffile)

# Display in the vignette. It may be rotated.
knitr::include_graphics(giffile)
```

![Example: surface analysis map provided by AEMET](example-gif.gif)

Example: surface analysis map provided by AEMET
