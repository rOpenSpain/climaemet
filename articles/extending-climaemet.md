# Extending climaemet

**climaemet** provides functions for selected [AEMET OpenData API
endpoints](https://opendata.aemet.es/dist/index.html). However, the
package does not cover every endpoint.

[`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
provides access to any AEMET OpenData API endpoint. Users must parse
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
#> → Returning a UTF-8 <character> string.
```

``` r

# Produce a result.

clean <- gsub("\r", "\n", pred_today, fixed = TRUE)
clean <- gsub("\n\n\n", "\n", clean, fixed = TRUE)

cat("<blockquote>", clean, "</blockquote>", sep = "\n")
```

> AGENCIA ESTATAL DE METEOROLOGÍA PREDICCIÓN GENERAL PARA ESPAÑA DÍA 11
> DE JULIO DE 2026 A LAS 09:17 HORA OFICIAL PREDICCIÓN VÁLIDA PARA EL
> SÁBADO 11
>
> A.- FENÓMENOS SIGNIFICATIVOS Chubascos y tormentas fuertes con granizo
> en el área cantábrica occidental, con posibilidad de que sean muy
> fuertes en Galicia. Temperaturas máximas significativamente elevadas
> en la mayor parte de la Península y Baleares.
>
> B.- PREDICCIÓN Predominarán los cielos poco nubosos o despejados en la
> mayor parte del país, con nubosidad baja matinal en regiones de
> Andalucía occidental, Galicia, Cantábrico y puntos de la fachada
> oriental peninsular que por lo general tenderá a despejar, y con
> intervalos de nubes altas penetrando desde el sur peninsular a lo
> largo del día. Por la tarde se formará nubosidad de evolución en zonas
> del centro y mitad norte peninsular, con chubascos y tormentas
> fuertes, incluso muy fuertes, acompañadas de granizo en Galicia,
> siendo también probables a últimas horas en el área cantábrica
> occidental. También podrá darse algún chubasco aislado en el Pirineo.
> En Canarias la llegada de un frente poco activo dejará cielos nubosos
> o cubiertos con precipitaciones en el norte de las islas montañosas e
> intervalos nubosos con posibilidad de alguna precipitación ocasional
> en el resto.
>
> Bancos de niebla matinales en regiones de Galicia, Cantábrico y
> fachada oriental peninsular, con calima en el sureste peninsular y
> Baleares.
>
> Las temperaturas máximas descenderán en los archipiélagos, litorales
> mediterráneos, Extremadura y Andalucía occidental, predominando los
> aumentos en el resto que podrán ser notables en el oeste de Galicia y
> Cantábrico oriental. Se superarán los 35 grados en amplias zonas de la
> Península y Baleares, incluso llegando a 38 en regiones de la meseta
> Sur, Andalucía oriental, Ebro y aledaños, Cantábrico oriental, Miño y
> Mallorca. Mínimas con pocos cambios, predominando los descensos en el
> cuadrante nordeste y los aumentos en el noroeste. No bajarán de 20
> grados en los litorales mediterráneos y regiones de los tercios
> nordeste y sureste y de la meseta Sur.
>
> Soplará moderado el poniente en los litorales del sur peninsular y el
> viento del nordeste en los de Galicia, Cantábrico y fachada oriental,
> así como en Baleares. Predominio del viento de componente sur en el
> resto, flojo arreciando a moderado por la tarde en amplias zonas.
> Viento moderado del norte en Canarias.

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
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write as GIF and include it.
giffile <- "example-gif.gif"
writeBin(the_map, giffile)

# Display in the vignette. It may be rotated.
knitr::include_graphics(giffile)
```

![Example: surface analysis map provided by AEMET](example-gif.gif)

Example: surface analysis map provided by AEMET
