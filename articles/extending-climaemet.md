# Extending climaemet

**climaemet** provides several functions for accessing a selection of
endpoints of the [AEMET API
tool](https://opendata.aemet.es/dist/index.html?). However, this package
does not cover all the capabilities of the API.

For that reason, we provide the
[`get_data_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md)
function, which allows access to any API endpoint. The drawback is that
users need to handle the results themselves.

``` r

library(climaemet)
```

## Example: Normalized text

Some API endpoints, such as `predicciones-normalizadas-texto`, provide
results as plain natural language text. These results are not parsed by
**climaemet** but can be retrieved as follows:

``` r

# endpoint: today's forecast

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

# Produce a result

clean <- gsub("\r", "\n", pred_today, fixed = TRUE)
clean <- gsub("\n\n\n", "\n", clean, fixed = TRUE)

cat("<blockquote>", clean, "</blockquote>", sep = "\n")
```

> AGENCIA ESTATAL DE METEOROLOGÍA PREDICCIÓN GENERAL PARA ESPAÑA DÍA 24
> DE ABRIL DE 2026 A LAS 11:37 HORA OFICIAL PREDICCIÓN VÁLIDA PARA EL
> VIERNES 24
>
> A.- FENÓMENOS SIGNIFICATIVOS De madrugada, tormentas en las mesetas y
> en el sistema Central. Por la tarde, chubascos fuertes y tormentas en
> Castilla y León, norte y oeste de Castilla-La Mancha, La Rioja y
> Madrid. Descenso notable de las temperaturas máximas en el sureste.
>
> B.- PREDICCIÓN Con la llegada del aire frío en altura, la
> inestabilidad predominará en gran parte del interior peninsular. Se
> prevé abundante nubosidad de evolución, con chubascos y tormentas
> generalizados. Durante la madrugada, se espera que continúen las
> precipitaciones en el norte Extremadura, la Comunidad de Madrid y el
> oeste de Castilla-La Mancha, y que se extiendan hacia la meseta norte.
> En la segunda mitad del día, se esperan chubascos fuertes acompañados
> de tormenta y de posible granizo en Castilla y León, norte y oeste de
> Castilla-La Mancha, La Rioja y Madrid; con menor probabilidad, podrían
> darse en otros puntos de la meseta sur, centro y este de Andalucía,
> sur de la Comunidad Valenciana y otras zonas montañosas del norte. En
> el noreste y en Baleares, los cielos estarán despejados o con nubes
> altas y, en Canarias, nubosos.
>
> Son posibles las brumas y los bancos de niebla matinales en el
> interior de la Comunidad Valencia. La calima irá remitiendo y
> desplazándose hacia el este peninsular.
>
> Las temperaturas máximas descenderán en la Península y en Baleares, de
> forma notable el sureste, y subirán en el noreste; las mínimas subirán
> en la mitad occidental y bajarán en la oriental y en Baleares. En
> Canarias, se espera un ascenso de las máximas en medianías y cumbres
> de las islas más montañosas y pocos cambios en las mínimas.
>
> Predominará el viento flojo y variable en el interior de la Península;
> del este, más intenso, en el tercio oriental. Será flojo o moderado,
> del oeste en el Cantábrico y del norte en Galicia y en Canarias.
> Podrían darse rachas muy fuertes de viento sur en el interior del País
> Vasco y en la vertiente cantábrica de Navarra durante la madrugada.

## Example: Maps

AEMET also provides map data, usually on `image/gif` format. One way to
get this kind of data is as follows:

``` r

# Endpoint of a map
a_map <- "/api/mapasygraficos/analisis"

# Metadata
knitr::kable(get_metadata_aemet(a_map))
#> ✖ HTTP 404:
#>   No hay datos que satisfagan esos criterios
```

``` r

the_map <- get_data_aemet(a_map)
#> ✖ HTTP 404:
#>   No hay datos que satisfagan esos criterios

# Write as gif and include it
giffile <- "example-gif.gif"
writeBin(the_map, giffile)
#> Error in `writeBin()`:
#> ! can only write vector objects

# Display on the vignette, it may be rotated
knitr::include_graphics(giffile)
```

![Example: Surface analysis map provided by AEMET](example-gif.gif)

Example: Surface analysis map provided by AEMET
