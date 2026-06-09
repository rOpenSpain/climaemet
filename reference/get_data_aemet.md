# Client tool for the AEMET API

Client tool to retrieve data and metadata from AEMET and convert JSON to
a [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).

## Usage

``` r
get_data_aemet(apidest, verbose = FALSE)

get_metadata_aemet(apidest, verbose = FALSE)
```

## Source

<https://opendata.aemet.es/dist/index.html>.

## Arguments

- apidest:

  Character string with a destination URL. See
  <https://opendata.aemet.es/dist/index.html>.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) (if
possible) or the results of the query as provided by
[`httr2::resp_body_raw()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`httr2::resp_body_string()`](https://httr2.r-lib.org/reference/resp_body_raw.html).

## See also

See examples of how to use these functions in
[`vignette("extending-climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md).

## Examples

``` r
# Run this example only if AEMET_API_KEY is detected.

url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"

get_data_aemet(url)
#> # A tibble: 920 × 7
#>    latitud provincia     altitud indicativo nombre             indsinop longitud
#>    <chr>   <chr>         <chr>   <chr>      <chr>              <chr>    <chr>   
#>  1 394924N ILLES BALEARS 490     B013X      ESCORCA, LLUC      "08304"  025309E 
#>  2 394744N BALEARES      5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N ILLES BALEARS 60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N BALEARES      52      B103B      ANDRATX - SANT ELM ""       022208E 
#>  5 393305N BALEARES      50      B158X      CALVIÀ, ES CAPDEL… ""       022759E 
#>  6 393315N BALEARES      3       B228       PALMA, PUERTO      "08301"  023731E 
#>  7 393832N ILLES BALEARS 95      B236C      PALMA, UNIVERSITAT ""       023838E 
#>  8 394406N ILLES BALEARS 1030    B248       SIERRA DE ALFABIA… "08303"  024247E 
#>  9 393621N BALEARES      47      B275E      SON BONET, AEROPU… "08302"  024224E 
#> 10 393339N BALEARES      5       B278       PALMA DE MALLORCA… "08306"  024412E 
#> # ℹ 910 more rows

# Metadata

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

# Plain text

plain <- get_data_aemet("/api/prediccion/nacional/hoy")
#> ℹ Results are MIME type: "text/plain".
#> → Returning data as UTF-8 string.

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 08 DE JUNIO DE 2026 A LAS 08:26 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL LUNES 8
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Posibilidad de chubascos localmente fuertes en Teruel y en los
#> Pirineos orientales. Rachas muy fuertes (superiores a 70 km/h) de
#> alisio en zonas expuestas de Canarias, sin descartarlas también
#> de cierzo en el Ebro. Temperaturas máximas en descenso notable
#> (más de 6 grados) en el Cantábrico oriental y alto Ebro y en
#> aumento notable en el interior de la Comunidad Valenciana y en las
#> zonas aledañas.
#> 
#> B.- PREDICCIÓN
#> Predominará el tiempo estable en la mayor parte del país con
#> cielos poco nubosos o despejados. No obstante, en Galicia y el
#> área cantábrica el paso de un frente poco activo dejará cielos
#> nubosos o cubiertos y precipitaciones débiles. Asimismo, también
#> se prevén cielos nubosos en el norte de Canarias, alto Ebro y,
#> durante las primeras horas de la mañana, en el área del Estrecho
#> y Melilla; por la tarde, se espera el desarrollo de nubes de
#> evolución en interiores del tercio oriental y chubascos en los
#> Pirineos y en Teruel que podrían ser localmente fuertes.
#> 
#> Son probables las nieblas matinales en Galicia y el interior del
#> área cantábrica.
#> 
#> Máximas en ascenso en Baleares, el extremo sur y el tercio
#> oriental,  de forma notable (más de 6 grados) en el interior de
#> la Comunidad Valenciana y aledaños. Por el contrario, bajarán en
#> el oeste y el norte, de forma notable e incluso localmente
#> extraordinario (más de 10 grados) en el Cantábrico oriental y el
#> alto Ebro. Se superarán los 34 grados en depresiones del nordeste
#> y zonas bajas de la mitad sur, alcanzando los 37 grados en el
#> Guadalquivir. Mínimas en aumento en la mitad norte en descenso en
#> el oeste de Extremadura y sin cambios en el resto. Noches
#> tropicales (mínimas de más de 20 grados) en La Mancha y el
#> Guadalquivir. Sin cambios en Canarias.
#> 
#> Se espera un predominio del viento del norte o del oeste en la
#> Península, salvo durante las primeras horas en litorales del
#> sureste peninsular y en el Estrecho, donde será de componente
#> este antes de rolar a poniente, y en el Ampurdán, donde será de
#> sur. El régimen de brisas dominará el resto de los litorales
#> mediterráneos. El viento será flojo en el interior, más intenso
#> en los litorales y con intervalos de fuerte en Castilla y León
#> por la tarde; en el valle del Ebro no se descartan rachas muy
#> fuertes (más de 70 km/h) de cierzo. En Baleares el viento será
#> flojo y del este, y en Canarias el alisio será moderado, con
#> rachas muy fuertes en zonas expuestas.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read.
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
