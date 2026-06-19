# Query the AEMET API

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

See examples of how to use these functions in
[`vignette("extending-climaemet", package = "climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md).

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
#> DÍA 18 DE JUNIO DE 2026 A LAS 09:05 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL JUEVES 18
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos y tormentas localmente fuertes en el interior del tercio
#> occidental peninsular, sin descartar que afecten a puntos del
#> Pirineo. Temperaturas máximas que pueden superar los 34-37 grados
#> en el interior del País Vasco, los 35-36 grados en Mallorca, los
#> 36-38 grados en el tercio nororiental y los 38-39 grados en los
#> valles del Tajo, Guadiana y del Guadalquivir.
#> 
#> B.- PREDICCIÓN
#> La influencia de las altas presiones estabilizará el tiempo en
#> buena parte de la Península y Baleares. Habrá cielos poco
#> nubosos o despejados en Andalucía, el tercio este, Baleares y el
#> Cantábrico oriental. En cambio, en los litorales del norte y de
#> Cataluña se esperan nubes bajas desde la mañana, aunque con
#> tendencia a despejar. A partir del mediodía, se espera el
#> desarrollo el desarrollo de nubosidad de evolución en el
#> interior. Se prevén chubascos y tormentas, con posibles rachas de
#> viento muy fuertes, en la cordillera Cantábrica, el oeste de la
#> meseta norte, Extremadura, sierra Morena y, con menor
#> probabilidad, los Pirineos y puntos de la meseta sur. En Canarias,
#> los cielos estarán con intervalos de nubes en el norte, que
#> pueden dejar algo de precipitación, y despejados en el sur.
#> 
#> Las temperaturas máximas subirán ligeramente en la cornisa
#> cantábrica, más acusadamente en el interior de la zona oriental;
#> descenderán en el litoral atlántico gallego, el interior de
#> Cataluña y de la Comunidad Valenciana y el oeste de Castilla y
#> León, y se mantendrán sin cambios en el resto. Las mínimas
#> subirán ligeramente de forma generalizada. Se podrán superar los
#> 34-37 grados en el interior del País Vasco, los 35-36 grados en
#> Mallorca, los 36-38 grados en el tercio nororiental y los 38-39
#> grados en los valles del Tajo, Guadiana y del Guadalquivir; en
#> este último podrían llegar localmente a los 40. Se prevén
#> noches tropicales, sin bajar de 20 grados, en los valles fluviales
#> del suroeste y los litorales mediterráneos. En los archipiélagos
#> se esperan pocos cambios en las temperaturas.
#> 
#> El viento en los litorales estará determinado por el régimen de
#> brisas y será flojo en general, siendo moderado del nordeste en
#> el sureste y con posibles rachas muy fuertes de levante en el
#> Estrecho. En el tercio oriental será de componente este y flojo,
#> y en el resto, variable y también flojo. En Canarias el viento
#> será de componente norte, moderado en zonas expuestas.
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
