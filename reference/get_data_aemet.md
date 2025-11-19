# Client tool for AEMET API

Client tool to get data and metadata from AEMET and convert json to
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html).

## Usage

``` r
get_data_aemet(apidest, verbose = FALSE)

get_metadata_aemet(apidest, verbose = FALSE)
```

## Source

<https://opendata.aemet.es/dist/index.html>.

## Arguments

- apidest:

  Character string as destination URL. See
  <https://opendata.aemet.es/dist/index.html>.

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

## Value

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) (if
possible) or the results of the query as provided by
[`httr2::resp_body_raw()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`httr2::resp_body_string()`](https://httr2.r-lib.org/reference/resp_body_raw.html).

## See also

Some examples on how to use these functions on
[`vignette("extending-climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md).

## Examples

``` r
# Run this example only if AEMET_API_KEY is detected

url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"

get_data_aemet(url)
#> # A tibble: 947 × 7
#>    latitud provincia     altitud indicativo nombre             indsinop longitud
#>    <chr>   <chr>         <chr>   <chr>      <chr>              <chr>    <chr>   
#>  1 394924N ILLES BALEARS 490     B013X      ESCORCA, LLUC      "08304"  025309E 
#>  2 394744N ILLES BALEARS 5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N ILLES BALEARS 60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N ILLES BALEARS 52      B103B      ANDRATX - SANT ELM ""       022208E 
#>  5 393305N BALEARES      50      B158X      CALVIÀ, ES CAPDEL… ""       022759E 
#>  6 393315N ILLES BALEARS 3       B228       PALMA, PUERTO      "08301"  023731E 
#>  7 393832N ILLES BALEARS 95      B236C      PALMA, UNIVERSITAT ""       023838E 
#>  8 394406N ILLES BALEARS 1030    B248       SIERRA DE ALFABIA… "08303"  024247E 
#>  9 393621N BALEARES      47      B275E      SON BONET, AEROPU… "08302"  024224E 
#> 10 393339N BALEARES      5       B278       PALMA DE MALLORCA… "08306"  024412E 
#> # ℹ 937 more rows


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

# We can get data from any API endpoint

# Plain text

plain <- get_data_aemet("/api/prediccion/nacional/hoy")
#> 
#> Results are MIME type: text/plain
#> Returning data as string

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 14 DE NOVIEMBRE DE 2025 A LAS 08:33 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL VIERNES 14
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probables precipitaciones fuertes y persistentes en Andalucía,
#> Pirineo, sistema Central, oeste de Galicia, cordillera Cantábrica
#> y Alborán, acompañadas de tormentas en el oeste de Andalucía.
#> Rachas muy fuertes de viento de componente sur en montañas de
#> Mallorca y del centro y mitad norte peninsular, así como en el
#> Cantábrico oriental y litorales atlánticos. Descensos notables
#> de las temperaturas máximas en el Pirineo y zonas de Andalucía
#> oriental y Castilla-La Mancha.
#> 
#> B.- PREDICCIÓN
#> La borrasca Claudia permanece estacionaria al noroeste de la
#> Península dejando un predominio de cielos nubosos o cubiertos y
#> tendiendo a abrirse claros en la fachada oriental por la tarde. Se
#> darán precipitaciones en la mayor parte de la Península, aunque
#> siendo poco probables y de carácter ocasional en los litorales
#> cantábricos, Ebro y extremo este, así como en Baleares con
#> intervalos de nubes altas tendiendo a cubrirse. Por el contrario,
#> serán más abundantes en el resto de Andalucía, Pirineo, sistema
#> Central y oeste de Galicia, cordillera Cantábrica y Alborán,
#> donde es probable que sean fuertes y persistentes. Además irán
#> con tormenta y posible granizo ocasional en el oeste de
#> Andalucía, así como, de forma aislada, en el oeste de Galicia y
#> entorno pirenaico oriental. En Canarias, predominio de cielos poco
#> nubosos o con intervalos y posibilidad de algún chubasco
#> ocasional en las islas de mayor relieve. Nevará en cumbres de
#> Pirineos, sistema Central y Sierra Nevada.
#> 
#> Bancos de niebla en entornos de montaña y en Alborán, con brumas
#> frontales al principio en amplias zonas de los tercios central y
#> occidental. Calima en el este peninsular y Baleares.
#> 
#> Temperaturas en descenso en la mayor parte del país, localmente
#> notable para las máximas en el Pirineo y zonas de Andalucía
#> oriental y Castilla-La Mancha, y con aumentos en el Ebro y fachada
#> oriental peninsular, extendiéndose también para las mínimas a
#> Baleares. Heladas débiles en cumbres del Pirineo.
#> 
#> Soplarán vientos flojos del este en el tercio nordeste
#> peninsular, con poniente moderado en el Estrecho y Alborán y
#> viento moderado del sur y suroeste en el resto. Se darán
#> intervalos fuertes en los litorales atlánticos y del sureste
#> peninsular y en Baleares, con rachas muy fuertes en el Cantábrico
#> oriental y en los principales entornos de montaña de la
#> Península y Mallorca, pudiendo ser localmente huracanadas en
#> cumbres de montañas del norte. Viento moderado de componente
#> oeste en Canarias amainando.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> 
#> Results are MIME type: image/gif
#> Returning raw data

# Write and read
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
#> Error in shell.exec(url): file association for 'C:\Users\RUNNER~1\AppData\Local\Temp\RtmpYxi5YL\file5dc34e0d56.gif' not available or invalid
```
