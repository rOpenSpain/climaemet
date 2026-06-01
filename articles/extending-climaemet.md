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

> AGENCIA ESTATAL DE METEOROLOGÍA PREDICCIÓN GENERAL PARA ESPAÑA DÍA 27
> DE MAYO DE 2026 A LAS 08:32 HORA OFICIAL PREDICCIÓN VÁLIDA PARA EL
> MIÉRCOLES 27
>
> A.- FENÓMENOS SIGNIFICATIVOS Tormentas localmente fuertes en el
> noroeste. Temperaturas máximas que superarán los 34-36 grados en el
> cuadrante suroeste, valle del Ebro, depresiones del nordeste
> peninsular, interiores del Cantábrico y de Galicia y puntos de la
> meseta norte, y podrán rebasar los 36-38 grados en el Guadiana y
> Guadalquivir. Rachas de levante muy fuertes en el Estrecho.
>
> B.- PREDICCIÓN Se prevé una situación de estabilidad generalizada en
> el país, con predominio de cielos poco nubosos o despejados, además de
> algunos intervalos de nubes altas, aunque con nubosidad de evolución
> diurna en el cuadrante noroeste peninsular y en otras montañas de la
> mitad norte, con algunos chubascos y tormentas localmente fuertes,
> acompañadas de granizo y con rachas muy fuertes asociadas. Por otro
> lado, se esperan intervalos de nubes bajas en zonas de los litorales
> de Galicia, del Cantábrico, de Cataluña y de Baleares, con posible
> formación de brumas y bancos de niebla costeros.
>
> La calima tenderá a menos en Canarias y podrá afectar también a zonas
> de los extremos oeste y sur peninsulares.
>
> Las temperaturas descenderán en Canarias y en el Cantábrico oriental,
> y aumentarán de forma predominante en el resto de la Península, de
> forma ligera en el caso de las mínimas. Sin cambios térmicos en
> Baleares. Se mantendrán en valores elevados para la época en amplias
> zonas del país, superando los 34-36 grados en el cuadrante suroeste,
> valle del Ebro, depresiones del nordeste peninsular, interiores del
> Cantábrico y de Galicia, y puntos de la meseta norte, y podrán rebasar
> los 36-38 grados en el Guadiana y Guadalquivir, donde las mínimas no
> bajarán de 20 grados.
>
> Soplará viento flojo con predominio de las componentes este y sur en
> la Península, con intervalos fuertes y posibilidad de alguna racha muy
> fuerte en el Estrecho, y viento moderado en zonas aledañas y litorales
> del sureste. Régimen de brisas en el resto de litorales mediterráneos,
> con la componente sur arreciando. Viento moderado de componente norte
> en Canarias y flojo de dirección variable en Baleares.

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
