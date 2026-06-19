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

> AGENCIA ESTATAL DE METEOROLOGÍA PREDICCIÓN GENERAL PARA ESPAÑA DÍA 18
> DE JUNIO DE 2026 A LAS 09:05 HORA OFICIAL PREDICCIÓN VÁLIDA PARA EL
> JUEVES 18
>
> A.- FENÓMENOS SIGNIFICATIVOS Chubascos y tormentas localmente fuertes
> en el interior del tercio occidental peninsular, sin descartar que
> afecten a puntos del Pirineo. Temperaturas máximas que pueden superar
> los 34-37 grados en el interior del País Vasco, los 35-36 grados en
> Mallorca, los 36-38 grados en el tercio nororiental y los 38-39 grados
> en los valles del Tajo, Guadiana y del Guadalquivir.
>
> B.- PREDICCIÓN La influencia de las altas presiones estabilizará el
> tiempo en buena parte de la Península y Baleares. Habrá cielos poco
> nubosos o despejados en Andalucía, el tercio este, Baleares y el
> Cantábrico oriental. En cambio, en los litorales del norte y de
> Cataluña se esperan nubes bajas desde la mañana, aunque con tendencia
> a despejar. A partir del mediodía, se espera el desarrollo el
> desarrollo de nubosidad de evolución en el interior. Se prevén
> chubascos y tormentas, con posibles rachas de viento muy fuertes, en
> la cordillera Cantábrica, el oeste de la meseta norte, Extremadura,
> sierra Morena y, con menor probabilidad, los Pirineos y puntos de la
> meseta sur. En Canarias, los cielos estarán con intervalos de nubes en
> el norte, que pueden dejar algo de precipitación, y despejados en el
> sur.
>
> Las temperaturas máximas subirán ligeramente en la cornisa cantábrica,
> más acusadamente en el interior de la zona oriental; descenderán en el
> litoral atlántico gallego, el interior de Cataluña y de la Comunidad
> Valenciana y el oeste de Castilla y León, y se mantendrán sin cambios
> en el resto. Las mínimas subirán ligeramente de forma generalizada. Se
> podrán superar los 34-37 grados en el interior del País Vasco, los
> 35-36 grados en Mallorca, los 36-38 grados en el tercio nororiental y
> los 38-39 grados en los valles del Tajo, Guadiana y del Guadalquivir;
> en este último podrían llegar localmente a los 40. Se prevén noches
> tropicales, sin bajar de 20 grados, en los valles fluviales del
> suroeste y los litorales mediterráneos. En los archipiélagos se
> esperan pocos cambios en las temperaturas.
>
> El viento en los litorales estará determinado por el régimen de brisas
> y será flojo en general, siendo moderado del nordeste en el sureste y
> con posibles rachas muy fuertes de levante en el Estrecho. En el
> tercio oriental será de componente este y flojo, y en el resto,
> variable y también flojo. En Canarias el viento será de componente
> norte, moderado en zonas expuestas.

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
