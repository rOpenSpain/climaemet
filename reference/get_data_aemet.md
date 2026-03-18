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
#> DÍA 14 DE MARZO DE 2026 A LAS 08:46 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL SÁBADO 14
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Nevadas en las montañas de la mitad norte y precipitaciones
#> fuertes o persistentes en el Cantábrico oriental, nordeste
#> peninsular y Baleares, que pueden estar acompañadas de tormentas
#> o granizo menudo. Rachas muy fuertes en los Pirineos, Ibérica,
#> bajo Ebro, Béticas, así como en zonas costeras de Alborán y en
#> Canarias.
#> 
#> B.- PREDICCIÓN
#> Se prevé que un frente acabe de recorrer la Península y
#> Baleares, penetrando tras él una masa de aire de origen polar.
#> Con esto, se esperan cielos nubosos o cubiertos y precipitaciones
#> afectando a la mayor parte de la mitad norte peninsular y a
#> Baleares, y también a las Béticas. Los mayores acumulados se
#> darán en el Cantábrico oriental, así como en el nordeste de
#> Cataluña y en Baleares, donde podrían ser fuertes y persistentes
#> y acompañados de tormentas o granizo ocasional. Se prevén
#> nevadas con probables acumulados significativos en montañas de la
#> mitad norte, pudiendo afectar a otras regiones. La cota empezará
#> baja en el norte y hasta 1500/1800 metros en el resto, pudiendo
#> bajar hasta los 800/1000m en la zona oriental a lo largo del día.
#> En Canarias, cielos muy nubosos sin descartar alguna llovizna
#> débil en el norte de las islas montañosas y poco nuboso en el
#> resto.
#> 
#> Calima tendiendo a disminuir en Canarias.
#> 
#> Las temperaturas máximas descenderán de forma acusada para las
#> máximas en la Península y Baleares, donde se prevé que lo haga
#> notablemente en amplias zonas, incluso de forma extraordinaria en
#> zonas puntuales del extremo nordeste. Las mínimas descenderán
#> ligeramente en el nordeste y se darán ciertos ascensos en el
#> suroeste. En Canarias, ligeros descensos de las máximas y ligeros
#> ascensos de las mínimas. Heladas en zonas de montaña zonas altas
#> colindantes.
#> 
#> En general soplará viento intenso de componente noroeste en la
#> Península y Baleares, siendo inicialmente del suroeste al
#> principio en Baleares y fachada oriental. Se prevé que alcance
#> intensidad fuerte con rachas muy fuertes de poniente en el
#> Estrecho, Alborán y Béticas, de tramontana en Ampurdán y norte
#> de Baleares y de cierzo en el Ebro, con posibles rachas muy
#> fuertes en Pirineos, Ibérica, bajo Ebro, Béticas y Alborán.
#> Alisio con intervalos fuertes y rachas muy fuertes en Canarias.
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
