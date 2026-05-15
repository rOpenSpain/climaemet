# Client tool for the AEMET API

Client tool to get data and metadata from AEMET and convert JSON to a
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
#>  6 393315N ILLES BALEARS 3       B228       PALMA, PUERTO      "08301"  023731E 
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
#> DÍA 03 DE ABRIL DE 2026 A LAS 08:15 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL VIERNES 3
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Rachas muy fuertes de viento del norte en Pirineos, bajo Ebro,
#> Ampurdán y norte de Baleares.
#> 
#> B.- PREDICCIÓN
#> Las altas presiones se irán extendiendo desde el Atlántico hacia
#> Europa y dejarán un tiempo estable en la Península y en Baleares
#> con predominio de cielos poco nubosos o despejados, si bien con
#> abundante nubosidad en el tercio norte que a lo largo del día
#> irá a menos. Se prevén precipitaciones débiles en la cara norte
#> del Pirineo, pudiendo afectar también al Cantábrico oriental, y
#> con tendencia a cesar durante la madrugada. Serán en forma de
#> nieve por encima de 1200/1400 metros. Poco nuboso o despejado
#> también en Canarias, con tendencia a nublarse con nubes medias y
#> altas al final.
#> 
#> Probables bancos de niebla matinales en montañas del norte
#> peninsular, así como en interiores de Galicia y puntos de la
#> meseta Norte.
#> 
#> Temperaturas máximas en aumento, exceptuando Canarias y tercio
#> sur peninsular con pocos cambios, e incluso con descensos en
#> litorales del sur. Los aumentos podrán ser notables en montañas
#> del norte. Las mínimas descenderán en la mayor parte de los
#> tercios norte y este peninsulares, con pocos cambios en el resto.
#> Heladas débiles en montañas de la mitad norte y sureste.
#> 
#> Soplará viento moderado de norte y nordeste en Canarias,
#> litorales de Galicia, cuadrante nordeste peninsular y Baleares,
#> con intervalos fuertes y rachas muy fuertes en Pirineos, bajo
#> Ebro, Ampurdán y norte de Baleares. Viento moderado, del oeste en
#> el Cantábrico amainando, y arreciando de levante en el Estrecho.
#> Viento flojo de componentes norte y este en el resto.
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
