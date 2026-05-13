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
#> DÍA 05 DE ABRIL DE 2025 A LAS 09:11 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL SÁBADO 5
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Tormentas localmente fuertes acompañadas de granizo en Pirineos,
#> sin descartarlas en otras zonas del interior de Cataluña.
#> 
#> B.- PREDICCIÓN
#> El sábado será un día de descanso entre diferentes pasos
#> frontales, recuperándose parcialmente la estabilidad en la
#> Península. Así, los resquicios de la borrasca Nuria afectarán
#> al noroeste y noreste, sin descartar precipitaciones débiles al
#> sur de los principales sistemas montañosos durante las primeras
#> horas del día. Ademas, se esperan tormentas localmente fuertes
#> acompañadas de granizo en Pirineos, sin descartarlas en otras
#> zonas de interior de Cataluña. Se prevé abundante nubosidad en
#> el extremo norte y nubes bajas en el resto durante las primeras
#> horas del día, que tenderán a despejar, quedando nubes altas de
#> evolución durante la noche en la mitad sur. Se podría dar alguna
#> nevada por encima de los 1800/2200 metros en Pirineos,
#> principalmente hasta mediodía. En Canarias se esperan cielos
#> despejados con intervalos nubosos de nubes altas, que tenderán a
#> oscurecerse en el oeste al final del día tras la llegada de un
#> nuevo frente. Por ello, tendremos lluvias débiles en el norte de
#> las islas de mayor relieve que se intensificarán en La Palma al
#> final.
#> 
#> Las temperaturas máximas aumentarán de forma moderada en el
#> Valle del Ebro, litorales del levante y sur de los principales
#> sistemas montañosos de la mitad sur y descenderán también de
#> forma moderada en las mesetas y Pirineos. Las mínimas
#> descenderán de forma ligera o moderada de forma generalizada.
#> Heladas débiles en el Pirineo.
#> 
#> Predominarán los vientos ligeros o moderados de componentes oeste
#> o suroeste, siendo localmente fuertes en litorales de Alborán,
#> Levante y Galicia. En Canarias proseguirán los vientos del oeste
#> o suroeste, tendiendo a fortalecerse con el paso del día.
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
