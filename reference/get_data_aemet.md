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
#> # A tibble: 920 × 7
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
#> # ℹ 910 more rows

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
#> DÍA 05 DE JULIO DE 2026 A LAS 09:26 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL DOMINGO 5
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Temperaturas muy altas, por encima de 34 grados en la provincia de
#> Gran Canaria y de los 36-39 grados en buena parte de la
#> Península, excepto en el Cantábrico, litorales mediterráneos y
#> en zonas altas. Se alcanzarán los 39-41 grados en los valles del
#> Tajo, Guadiana, Guadalquivir, oeste de Andalucía y puntualmente
#> en Galicia y en el Ebro. Rachas muy fuertes de levante en el
#> Estrecho.
#> 
#> B.- PREDICCIÓN
#> Situación de estabilidad y comienzo del episodio de ola de calor,
#> con ello, los cielos estarán despejados o poco nubosos, aunque
#> con algunas nubes altas, en prácticamente toda la Península y
#> Baleares. Crecerán nubes de evolución en el centro y mitad sur
#> peninsular, que podrían dejar algún chubasco aislado en zonas de
#> montaña. En Canarias, intervalos nubosos en el norte de las islas
#> más montañosas y poco nuboso en las orientales y al sur.
#> 
#> Ascenso de las máximas en el tercio norte, que puede ser notable
#> en el norte de Galicia, el alto Ebro y Navarra. Descensos en el
#> este de la meseta sur y costa occidental gallega, con pocos
#> cambios en el resto. Mínimas sin cambios, salvo ligeros ascensos
#> en la mitad norte y Andalucía oriental. Se superarán los 36-39
#> grados en la mayor parte de la Península, excepto en el
#> Cantábrico, litorales mediterráneos y en zonas altas. En los
#> valles del Ebro, Tajo, Guadiana, Guadalquivir, oeste de Andalucía
#> y puntualmente en Galicia se pueden alcanzar los 39-41 grados.
#> Mínimas tropicales, por encima de 20 grados, en los litorales
#> mediterráneos, el sudoeste, el Ebro y puntualmente en Galicia,
#> que en los valles del Tajo, Guadiana y Guadalquivir se pueden dar
#> noches tórridas por encima de 25 grados. Ascensos de las mínimas
#> y máximas en Canarias, excepto en las más orientales, más
#> acusados en medianías y cumbres que en los litorales. Máximas
#> por encima de 34 en la provincia de Gran Canaria.
#> 
#> Vientos de componente este en general en los litorales, que serán
#> fuertes en el Estrecho con algunas rachas muy fuertes, moderado en
#> el Cantábrico y Alborán, y flojo, con brisas en el resto del
#> Mediterráneo y en el oeste de Galicia. En el interior peninsular
#> predominarán los vientos flojos de dirección variable a primeras
#> y últimas horas, intensificándose algo en las horas centrales
#> del este. Viento de componente norte moderado en Canarias.
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
