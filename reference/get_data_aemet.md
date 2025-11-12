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
#> DÍA 04 DE NOVIEMBRE DE 2025 A LAS 08:35 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MARTES 4
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos localmente fuertes y persistentes al final del día en
#> el oeste de Galicia. Rachas muy fuertes de viento de sur en
#> Galicia y área cantábrica. Temperaturas significativamente
#> elevadas en Canarias.
#> 
#> B.- PREDICCIÓN
#> Se esperan cielos nubosos o cubiertos en el cuadrante noroeste
#> peninsular y Cantábrico, con precipitaciones afectando
#> especialmente a Galicia a últimas horas, sin descartar que puedan
#> ser localmente fuertes y persistentes en su extremo occidental y
#> ocasionalmente con tormenta. En el resto de la Península y en
#> Baleares se espera un tiempo más estable, con nubosidad baja
#> matinal en el cuadrante sureste, y cielos nubosos o con intervalos
#> nubosos en regiones del Mediterráneo, con posibles lloviznas en
#> el Estrecho y chubascos débiles y ocasionales en litorales de
#> Cataluña y en Baleares. Cielos despejados o con intervalos de
#> nubes altas en Canarias.
#> 
#> Probables nieblas matinales en interiores del tercio este
#> peninsular, este de la meseta Sur, así como en zonas bajas de
#> Castilla y León. Brumas frontales en el extremo noroeste a
#> últimas horas.
#> 
#> Las temperaturas máximas aumentarán litorales cantábricos,
#> meseta Norte y sistema Ibérico y, en menor medida, depresiones
#> del nordeste peninsular y de la meseta Sur. Pocos cambios en el
#> resto. Pocos cambios en Canarias excepto algún ascenso en las
#> islas más orientales. Se espera superar los 30 grados en
#> medianías de Canarias. Las mínimas ascenderán en la mayor parte
#> de la Península, salvo algunos descensos en la fachada oriental,
#> medio-bajo Ebro y este de Alborán. Los aumentos serán localmente
#> notables en el Estrecho, Galicia, oeste de Castilla y León y
#> Cantábrico. Heladas débiles en Pirineos.
#> 
#> Soplarán vientos moderados de componente este en litorales del
#> sur peninsular con intervalos fuertes en el Estrecho. Vientos
#> flojos de componentes sur y este en Canarias, y predominio de
#> vientos de componente sur en el resto; moderados en el
#> Cantábrico, alto Ebro y mitad norte de la vertiente atlántica y
#> de los litorales mediterráneos, que llegarán a fuertes con
#> rachas muy fuertes en Galicia y área cantábrica.
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
#> Error in shell.exec(url): file association for 'C:\Users\RUNNER~1\AppData\Local\Temp\RtmpyQsTWu\file24e459a4f89.gif' not available or invalid
```
