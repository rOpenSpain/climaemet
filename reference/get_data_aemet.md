# Client tool for AEMET API

Client tool to get data and metadata from AEMET and convert json to
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).

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

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) (if
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
#>  2 394744N BALEARES      5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N ILLES BALEARS 60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N BALEARES      52      B103B      ANDRATX - SANT ELM ""       022208E 
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
#> ℹ Results are MIME type: "text/plain".
#> → Returning data as UTF-8 string.

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 07 DE ABRIL DE 2026 A LAS 08:41 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MARTES 7
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Tormentas localmente fuertes, con probable granizo, rachas muy
#> fuertes y precipitaciones puntualmente fuertes (superiores a 15
#> mm/h) en zonas de Galicia, Castilla y León, Extremadura y zonas
#> limítrofes, sin descartarlas también en el oeste de Andalucía.
#> Precipitaciones con acumulados significativos en el oeste del
#> Sistema Central. Probables rachas muy fuertes (superiores a 70
#> km/h) en la Cordillera Cantábrica y en Extremadura.
#> 
#> B.- PREDICCIÓN
#> La entrada de una vaguada asociada a una masa de aire frío y sus
#> frentes asociados dejarán cielos muy nubosos con precipitaciones
#> en la mitad occidental y abundantes nubes altas en la mitad
#> oriental y Baleares. Se espera que las precipitaciones puedan
#> dejar acumulados importantes en el oeste del Sistema Central y de
#> la Cantábrica, en forma de chubascos tormentosos localmente
#> fuertes, que pueden ir acompañados de granizo y de rachas muy
#> fuertes de viento. En Canarias se esperan cielos nubosos o
#> cubiertos en el norte de las islas más montañosas, con
#> precipitaciones, sobre todo a partir de la tarde. En el resto de
#> zonas, intervalos nubosos.
#> 
#> Se prevén bancos de niebla costeros en los litorales del norte
#> del Mediterráneo y en Baleares, así como brumas y nieblas en
#> zonas altas de la mitad occidental; también se espera polvo en
#> suspensión en el centro y oeste peninsular que, con la
#> precipitación, puede dar lugar a chubascos de barro puntuales.
#> 
#> Se prevé un descenso de las temperaturas máximas en la mitad
#> occidental de la Península, que puede ser notable, y pocos
#> cambios en el tercio oriental y el Estrecho. Mínimas en ascenso
#> ligero en la Península, que puede ser notable en el Cantábrico
#> oriental, y descensos en el cuadrante nordeste. Aumento de las
#> máximas y pocos cambios de las mínimas en Baleares. En Canarias,
#> descenso general, más acusado en cumbres y medianías.
#> 
#> Vientos de componentes sur y oeste, en general moderados en la
#> zona occidental peninsular, y vientos del este de flojos a
#> moderados en la vertiente mediterránea y el archipiélago balear.
#> Levante moderado rolando a poniente en Alborán. Probables rachas
#> muy fuerte en la Cordillera Cantábrica, oeste de Castilla y
#> León, Andalucía y en Extremadura. Viento del noroeste moderado
#> en Canarias, tendiendo a arreciar y a rolar a norte.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
