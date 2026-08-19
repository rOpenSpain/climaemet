# Query the AEMET OpenData API

Retrieves data and metadata from AEMET and converts JSON responses to a
[tibble](https://tibble.tidyverse.org/reference/tibble.html) when
possible.

## Usage

``` r
get_data_aemet(apidest, verbose = FALSE)

get_metadata_aemet(apidest, verbose = FALSE)
```

## Source

<https://opendata.aemet.es/dist/index.html>.

## Arguments

- apidest:

  A character string containing the destination URL. See
  <https://opendata.aemet.es/dist/index.html>.

- verbose:

  A logical value. If `TRUE`, displays information about the exchange
  between the client and server.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) (if
possible) or the results of the query as provided by
[`httr2::resp_body_raw()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`httr2::resp_body_string()`](https://httr2.r-lib.org/reference/resp_body_raw.html).

## See also

- [`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md)
  configures API authentication.

- [`vignette("extending-climaemet", package = "climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md)
  provides usage examples.

## Examples

``` r
# Run only when AEMET_API_KEY is detected.

url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"

get_data_aemet(url)
#> # A tibble: 921 × 7
#>    latitud provincia     altitud indicativo nombre             indsinop longitud
#>    <chr>   <chr>         <chr>   <chr>      <chr>              <chr>    <chr>   
#>  1 394924N ILLES BALEARS 490     B013X      ESCORCA, LLUC      "08304"  025309E 
#>  2 394744N BALEARES      5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N ILLES BALEARS 60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N BALEARES      52      B103B      ANDRATX - SANT ELM ""       022208E 
#>  5 393305N BALEARES      50      B158X      CALVIÀ, ES CAPDEL… ""       022759E 
#>  6 393315N BALEARES      3       B228       PALMA, PUERTO      "08301"  023731E 
#>  7 393832N ILLES BALEARS 95      B236C      PALMA, UNIVERSITAT ""       023838E 
#>  8 394406N ILLES BALEARS 1030    B248       SIERRA DE ALFABIA… "08303"  024247E 
#>  9 393621N BALEARES      47      B275E      SON BONET, AEROPU… "08302"  024224E 
#> 10 393339N BALEARES      5       B278       PALMA DE MALLORCA… "08306"  024412E 
#> # ℹ 911 more rows

# Metadata.

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

# Plain text.

plain <- get_data_aemet("/api/prediccion/nacional/hoy")
#> ℹ Response MIME type: "text/plain".
#> → Returning a UTF-8 <character> string.

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 19 DE AGOSTO DE 2026 A LAS 08:47 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 19
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Temperaturas muy elevadas en el tercio oriental peninsular, puntos
#> del centro y Málaga. Probabilidad de tormentas fuertes o muy
#> fuertes en el Pirineo y cordillera Cantábrica, sin descartar que
#> puedan afectar también a puntos de la Ibérica norte y norte de
#> la meseta norte.
#> 
#> B.- PREDICCIÓN
#> Se esperan cielos nubosos o cubiertos y precipitaciones en el
#> Cantábrico y algunas nubes bajas matinales en los litorales de
#> Andalucía. A partir del mediodía, se espera el desarrollo de
#> nubes de evolución en el interior peninsular, con posibles
#> chubascos y tormentas en los Pirineos y extremo nordeste, así
#> como en la cordillera Cantábrica, sin descartarse en los sistemas
#> Béticos, Ibérico y zonas aledañas. Las tormentas podrían ser
#> de intensidad fuerte y venir acompañadas de rachas muy fuertes de
#> viento y de granizo en el nordeste peninsular y puntos de la
#> Cantábrica. En Canarias, se prevén intervalos nubosos que pueden
#> dejar alguna precipitación en el norte de las islas montañosas.
#> 
#> Las temperaturas máximas bajarán de forma generalizada, salvo en
#> la vertiente mediterránea y Baleares, donde subirán, pudiendo
#> ser los aumentos notables en el litoral de Valencia. Se superarán
#> los 36 grados en puntos del centro, el valle del Ebro y en zonas
#> bajas del noreste, Baleares, el sureste y de la Comunidad
#> Valenciana, pudiendo superarse los 40 grados en el bajo Ebro,
#> interiores de las provincias de Valencia, Alicante y Murcia. Las
#> mínimas bajarán en Cataluña y en el cuadrante suroeste, y
#> subirán en el resto. Seguiremos con noches tropicales, sin bajar
#> de 20 grados, en los litorales mediterráneos. En Canarias las
#> temperaturas mínimas subirán ligeramente.
#> 
#> Viento del suroeste en general, flojo o moderado. Será del norte
#> o noroeste, rolando a oeste en el Cantábrico y Galicia, más
#> intenso en los litorales de esta última. En el litoral del mar de
#> Alborán y Estrecho soplará el viento de poniente moderado, con
#> algunos intervalos fuertes, y en el tercio este y Baleares, del
#> sur, también moderado. Viento del oeste flojo a moderado en el
#> interior. En Canarias continuará el alisio moderado.
#> 

# An image.

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Response MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read.
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
