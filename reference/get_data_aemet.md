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
#> DÍA 29 DE JUNIO DE 2026 A LAS 09:28 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL LUNES 29
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos y tormentas localmente fuertes y con probable granizo en
#> el sistema Ibérico de Teruel y de la Comunidad Valenciana, el
#> este de Castilla-La Mancha, Pirineo oriental, el este de
#> Andalucía y el norte de Murcia. Temperaturas máximas que pueden
#> superar los 34 grados en el interior de Gran Canaria, los 36-38
#> grados en el cuadrante suroeste peninsular y el sur de Mallorca y
#> los 38-40 grados en los valles del Guadalquivir y Guadiana. Rachas
#> muy fuertes de alisio en Canarias y, durante la madrugada, de
#> tramontana en el Ampurdán.
#> 
#> B.- PREDICCIÓN
#> El anticiclón dejará un predominio de tiempo estable en la
#> Península y en Baleares, con cielos despejados o con alguna nube
#> alta. Sin embargo, se espera que durante la tarde se desarrollen
#> nubes de evolución en la mitad este, que darán lugar a chubascos
#> y tormentas localmente fuertes y con probable granizo en el
#> sistema Ibérico de Teruel y de la Comunidad Valenciana, el este
#> de Castilla-La Mancha, el este de Andalucía, el norte de Murcia
#> y, en menor medida, en los Pirineos. En el Cantábrico, se esperan
#> nubes bajas y, durante la primera mitad del día, precipitaciones
#> débiles. También son probables las nubes bajas por la mañana en
#> la meseta norte, en algunos puntos de la Ibérica sur y del
#> sureste y en Cádiz. En Canarias, los cielos estarán nubosos en
#> el norte de las islas más montañosas y poco nubosos en el resto.
#> 
#> Son probables las brumas matinales en el Cantábrico y Galicia. En
#> Canarias, se prevé la entrada de calima en altura.
#> 
#> Las temperaturas máximas bajarán en el sistema Ibérico, el
#> noreste de la meseta norte, el noreste y el sureste peninsular,
#> Baleares y el Estrecho, y subirán en el resto. Las mínimas
#> bajarán en el País Vasco, el sistema Ibérico, el valle del Ebro
#> y algunos puntos del interior. Se prevén noches tropicales, con
#> mínimas de más de 20 grados, en puntos de Andalucía y del
#> litoral mediterráneo. En Canarias se espera un ascenso de las
#> temperaturas en el interior de las islas. Se superarán los 34
#> grados en el interior de Gran Canaria, los 36 -38 grados en el
#> oeste de la meseta sur, el sur de Mallorca y Extremadura y los
#> 38-40 grados en el valle del Guadalquivir.
#> 
#> El viento será en general flojo o moderado, con predominio de la
#> componente norte en el Cantábrico y en Castilla y León, de
#> cierzo en el valle del Ebro y del este en el interior peninsular,
#> y estará bajo régimen de brisas en los litorales del
#> Mediterráneo y del sur. El alisio en Canarias y, durante la
#> madrugada, la tramontana en el Ampurdán, vendrán acompañados de
#> rachas muy fuertes.
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
