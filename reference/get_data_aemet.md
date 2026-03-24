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
#> DÍA 22 DE MARZO DE 2026 A LAS 08:42 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL DOMINGO 22
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos localmente fuertes y persistentes, acompañados de
#> tormenta y granizo, en las islas occidentales de Canarias, sin
#> descartar que afecten también a las orientales. Rachas muy
#> fuertes en Canarias, y puntualmente en el prelitoral de Tarragona
#> al final del día.
#> 
#> B.- PREDICCIÓN
#> La borrasca Therese mantendrá un ambiente de inestabilidad en las
#> islas Canarias, con cielos nubosos o cubiertos y precipitaciones
#> en forma de chubascos con probabilidad de ser localmente fuertes,
#> especialmente en las vertientes oeste y sur de las islas
#> occidentales, que pueden ir acompañados de tormenta y granizo, y
#> sin descartar que afecten también a las islas orientales. En la
#> mitad sur de la Península también aumentará la inestabilidad,
#> con precipitaciones en general débiles y de carácter ocasional,
#> y nubosidad de evolución en las sierras que podría dejar
#> chubascos vespertinos moderados. Cielos poco nubosos en general en
#> el resto de la Península y en Baleares, con nubosidad baja
#> matinal en el extremo norte y posibles precipitaciones débiles o
#> moderadas en el nordeste de Cataluña al final del día.
#> 
#> Es probable la formación de bancos de niebla matinales en zonas
#> bajas del suroeste de la meseta norte y el este de la meseta sur.
#> 
#> Las temperaturas máximas disminuirán en el extremo norte
#> peninsular predominando los aumentos en el resto, sobre todo en el
#> centro este peninsular. Pocos cambios en los archipiélagos.
#> Mínimas en descenso en la Península y Baleares y con pocos
#> cambios en Canarias. Son probables las heladas, débiles en
#> general en zonas altas de los Pirineos y la Ibérica.
#> 
#> En el interior de la Península viento flojo variable con
#> tendencia a predominar la componente norte y algo más intenso por
#> la tarde; cierzo moderado en el Ebro, con probables rachas muy
#> fuertes al final del día en los prelitorales de Tarragona. Viento
#> moderado del este en litorales del sur y del noroeste, con
#> posibles intervalos fuertes en los litorales atlánticos gallegos.
#> Nordeste moderado al sur de Baleares y suroeste moderado al norte
#> de este archipiélago. En Canarias soplará viento del suroeste
#> con intervalos fuertes y probables rachas muy fuertes, tendiendo a
#> amainar.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ! HTTP 429:
#>   Límite de peticiones o caudal por minuto excedido para este usuario. Espere
#>   al siguiente minuto.
#> ℹ Retrying...
#> 
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
