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
#> DÍA 19 DE ABRIL DE 2026 A LAS 09:01 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL DOMINGO 19
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Tormentas y chubascos localmente fuertes, con probables rachas de
#> viento muy fuertes y granizo en el sistema Ibérico, valle del
#> Ebro, Pirineos y puntos de la Cantábrica. En Canarias, calima y
#> rachas muy fuertes de viento en zonas altas de Tenerife y La
#> Palma.
#> 
#> B.- PREDICCIÓN
#> La inestabilidad continuará en el norte y nordeste peninsular,
#> especialmente en el Cantábrico, Ibérica, Navarra y valle de
#> Ebro. Se esperan nubes bajas matinales en Galicia, Cantábrico,
#> litorales de la Comunidad Valenciana y oeste de Alborán. Por la
#> tarde se desarrollará nubosidad de evolución en amplias zonas
#> del norte y noreste peninsulares; en el resto del territorio, los
#> cielos se mantendrán despejados o con alguna nube alta. Se
#> prevén tormentas y chubascos localmente fuertes, con posibilidad
#> de granizo y rachas muy fuertes de viento, en el sistema Ibérico,
#> valle del Ebro, Navarra y Pirineos; más aisladamente, las
#> tormentas podrían afectar al sistema Central, Serranía de Cuenca
#> y a la cordillera Cantábrica. En Canarias, cielos con abundantes
#> nubes medias y altas al principio del día, tendiendo a despejar.
#> 
#> No se descartan brumas y nieblas en el interior de Galicia y de
#> las comunidades del Cantábrico. La calima empezará a remitir en
#> las islas Canarias más occidentales.
#> 
#> Las temperaturas apenas variarán; solo subirán las máximas en
#> el extremo norte, pudiendo ser estos ascensos notables en el norte
#> de Galicia. En Canarias las temperaturas subirán en las islas
#> orientales y bajarán en las occidentales.
#> 
#> El viento soplará flojo y variable en el interior y en régimen
#> de brisas en general en los litorales, excepto en el Cantábrico
#> donde el viento será moderado del este y nordeste, con posibles
#> intervalos de fuerte al norte de Galicia; se espera levante
#> moderado en el Estrecho, sin descartar rachas muy fuertes. El
#> viento en el archipiélago canario será moderado y variable, y
#> con rachas muy fuertes del sur en zonas altas y medianías de las
#> islas occidentales.
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
