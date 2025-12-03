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
#> DÍA 30 DE NOVIEMBRE DE 2025 A LAS 09:22 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL DOMINGO 30
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Nevadas en cotas que pueden bajar a los 1000m en la Cordillera
#> Cantábrica y Pirineo. Viento fuerte con rachas muy fuertes en el
#> Ampurdán. Chubascos fuertes, ocasionalmente acompañados de
#> tormentas, en el extremo sur de Andalucía, Estrecho y Baleares.
#> 
#> B.- PREDICCIÓN
#> Se prevé que un frente frío cruce la Península moviéndose
#> hacia el Mediterráneo, dejando cielos nubosos o cubiertos, con
#> nubosidad baja en el interior peninsular y más persistente en la
#> Cordillera Cantábrica y Andalucía oriental. Dejará
#> precipitaciones débiles a moderadas a su paso, con probables
#> acumulados significativos en litorales del Cantábrico y Pirineos
#> occidentales, que tenderán a remitir por la tarde, excepto en
#> Baleares, área del Estrecho y sureste peninsular. En el extremo
#> sur de Andalucía y área del Estrecho pueden ser localmente
#> fuertes y acompañadas de tormenta. Nevará en las montañas de la
#> mitad norte por encima de 1000-1200 m y en las del sureste por
#> encima de 1600-1800m. En Canarias, intervalos nubosos con lluvias
#> débiles en el norte de las islas de mayor relieve, calima ligera
#> en el este.
#> 
#> Nieblas en zonas altas del interior al paso del frente.
#> 
#> Temperaturas máximas en descenso en la Península y Baleares
#> excepto en depresiones de las mesetas con ligeros ascensos. Los
#> descensos pueden ser notables en zonas altas en general, mayores
#> en el tercio oriental. Mínimas en ligero o moderado ascenso en
#> general y en ligero descenso en el cuadrante noroeste y Pirineos,
#> produciéndose al final del día. En Canarias pocos cambios.
#> Heladas débiles en Castilla y León, montañas del interior y
#> zonas próximas.
#> 
#> Vientos de componente norte y noroeste rolando a componente sur en
#> Galicia y en el Cantábrico. Soplará moderado en los litorales
#> con intervalos de poniente fuerte en Alborán, tramontana fuerte
#> en Ampurdán y cierzo moderado en el Ebro. Soplará flojo en la
#> mitad oeste peninsular y con intervalos de moderado en el resto.
#> En Canarias, alisio moderado.
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
#> Error in shell.exec(url): file association for 'C:\Users\RUNNER~1\AppData\Local\Temp\RtmpI7Yq7C\file364471356c.gif' not available or invalid
```
