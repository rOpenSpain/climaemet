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
#> DÍA 24 DE NOVIEMBRE DE 2025 A LAS 08:17 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL LUNES 24
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Lluvias localmente fuertes y persistentes en la vertiente
#> cantábrica y Galicia. Calima con altas concentraciones en
#> Fuerteventura y Lanzarote y, durante la primera parte del día, en
#> Tenerife y Gran Canaria. Ascenso notable de las temperaturas
#> mínimas en zonas de la meseta Sur, localmente en la fachada
#> mediterránea y Mallorca. Probables rachas muy fuertes en el
#> sistema Ibérico y tercio suroriental peninsular.
#> 
#> B.- PREDICCIÓN
#> Un frente dejará cielos nubosos a cubiertos en la Península y
#> abundantes nubes altas en Baleares. A su paso dejará
#> precipitaciones moderadas o localmente fuertes en la vertiente
#> cantábrica y Galicia, ocasionalmente con tormenta y persistentes
#> en zonas de montaña. Durante la tarde se irán extendiendo hacia
#> el sur de forma más débil, con acumulados mayores en zonas del
#> sistema Central e Ibérica norte, pudiendo llegar al final del
#> día a las islas Baleares. Al final del día pueden darse
#> chubascos localmente fuertes y persistentes en zonas del
#> Cantábrico oriental. En Canarias, intervalos nubosos sin
#> descartar de lluvias débiles ocasionales en las islas centrales.
#> Se espera calima con altas concentraciones en las islas más
#> orientales y, durante la primera parte del día, en las centrales.
#> 
#> Probables brumas y nieblas en zonas altas del interior asociadas
#> al paso del frente.
#> 
#> Máximas en descenso en el extremo norte y en zonas altas de la
#> mitad sur peninsular y ascensos en el noroeste, litoral
#> mediterráneo y Baleares. Mínimas en descenso en el noroeste y
#> Pirineos, donde se producirán al final del día, y en ascenso en
#> el resto de la Península, que podrá ser notable en amplias zonas
#> de la meseta Sur y localmente en la fachada mediterránea y
#> Mallorca. En Canarias, ascensos de las temperaturas, pudiendo
#> subir las mínimas de forma notable en cumbres y medianías de
#> Gran Canaria y Tenerife.
#> 
#> Viento del oeste y suroeste excepto en los litorales cantábrico y
#> occidental gallego, en donde será del nororeste a partir del
#> mediodía. Soplarán moderados a fuertes en el litoral
#> cantábrico, Alborán, golfo de Valencia y sur de las islas
#> Baleares con probables rachas muy fuertes en Ibiza. En el interior
#> peninsular, flojo a moderado con probables rachas muy fuertes en
#> la Ibérica y tercio suroriental peninsular. En Canarias,
#> predominará la componente este con intensidad moderada y
#> amainando.
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
#> Error in shell.exec(url): file association for 'C:\Users\RUNNER~1\AppData\Local\Temp\RtmpsRG5eY\filebb413d35ed.gif' not available or invalid
```
