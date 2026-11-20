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

> AGENCIA ESTATAL DE METEOROLOGÍA PREDICCIÓN GENERAL PARA ESPAÑA DÍA 10
> DE NOVIEMBRE DE 2026 A LAS 09:47 HORA OFICIAL PREDICCIÓN VÁLIDA PARA
> EL MARTES 10
>
> A.- FENÓMENOS SIGNIFICATIVOS Precipitaciones fuertes y persistentes en
> Galicia, el macizo Galaico-Leonés, Sistema Central, Extremadura y
> suroeste de Castilla y León, sin descartarse en Andalucía occidental.
> Rachas muy fuertes de viento del sur en los litorales atlánticos
> gallegos y montañas del norte peninsular y en Canarias al final del
> día.
>
> B.- PREDICCIÓN Los frentes de la borrasca Bruna seguirán dejando una
> situación de inestabilidad en la mitad occidental peninsular. Así,
> predominarán los cielos nubosos o cubiertos y precipitaciones con
> alguna tormenta aislada en la vertiente atlántica, más abundantes e
> intensas en el oeste y sur de Galicia, el macizo Galaico-Leonés, el
> Sistema Central, Extremadura y sudoeste de Castilla y León. En menor
> medida, aunque sin descartar que sean fuertes o persistentes, son
> probables las lluvias en Andalucía occidental, el Cantábrico, las
> mesetas, La Rioja, Navarra y los Pirineos. En Baleares y el este
> peninsular, se esperan nubes altas sin precipitaciones. En Canarias,
> intervalos nubosos, con posibles precipitaciones, sin descartar que
> localmente sean moderadas en puntos de las islas de mayor relieve.
>
> Son probables las brumas y las nieblas matinales en interiores del
> tercio este peninsular, el valle del Ebro y los entornos de montaña.
> Además, se esperan brumas asociadas a los frentes, que serán más
> densas y persistentes en zonas altas de montaña.
>
> Las temperaturas máximas ascenderán en el tercio nordeste; descenderán
> en Galicia, la meseta sur y Canarias y se mantendrán sin cambios en el
> resto. Las mínimas no presentarán grandes variaciones, aunque
> predominarán los descensos ligeros en Canarias y el sudeste
> peninsular. Habrá heladas débiles en los Pirineos.
>
> Se prevé viento moderado de componente sur en la mayor parte de la
> Península y Baleares, con intervalos fuertes y probables rachas muy
> fuertes en los litorales gallegos y las montañas del norte. En las
> regiones mediterráneas y del interior oriental, predominará la
> componente oeste, moderada en los litorales. En Canarias, el viento
> será moderado del suroeste con probables rachas muy fuertes en las
> islas montañosas al final del día.

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
