# Client tool for the AEMET API

Client tool to retrieve data and metadata from AEMET and convert JSON to
a [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).

## Usage

``` r
get_data_aemet(apidest, verbose = FALSE)

get_metadata_aemet(apidest, verbose = FALSE)
```

## Source

<https://opendata.aemet.es/dist/index.html>.

## Arguments

- apidest:

  Character string with a destination URL. See
  <https://opendata.aemet.es/dist/index.html>.

- verbose:

  Logical. If `TRUE`, provides information about the flow of information
  between the client and server.

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
#>  6 393315N BALEARES      3       B228       PALMA, PUERTO      "08301"  023731E 
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
#> DÍA 10 DE JUNIO DE 2026 A LAS 08:38 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 10
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Temperaturas que pueden superar puntualmente los 38 grados en el
#> valle del Guadalquivir.
#> 
#> B.- PREDICCIÓN
#> La influencia del anticiclón dejará una situación de
#> estabilidad y un predominio de cielos poco nubosos o despejados.
#> Solamente se esperan cielos con nubes bajas en el norte de las
#> islas Canarias, el área cantábrica, los Pirineos y, durante la
#> mañana, el Estrecho y los litorales de Alborán y del área
#> mediterránea. Podrían darse precipitaciones débiles y aisladas
#> en el norte. Por la tarde, se espera el desarrollo de nubes de
#> evolución en zonas de interior del tercio oriental y la
#> posibilidad de alguna tormenta o chubasco aislado, más probables
#> en el sur del Sistema Ibérico y en las Béticas.
#> 
#> Posibles brumas matinales en la cordillera Cantábrica, los
#> Pirineos, las sierras del sureste y el Estrecho.
#> 
#> Las temperaturas máximas descenderán en Baleares, el tercio este
#> y el extremo sur peninsular, subirán en el norte y noroeste y se
#> mantendrán sin cambios en el resto. Se pueden superar los 35
#> grados en zonas bajas del suroeste y, puntualmente, los 38 grados
#> en el valle del Guadalquivir. Las temperaturas mínimas subirán
#> en el suroeste y descenderán en el resto, de forma más acusada
#> en la meseta norte y las depresiones del noreste. Se prevén
#> noches tropicales, sin bajar de 20 grados, en el Guadalquivir y en
#> el litoral sureste. En Canarias no se esperan cambios.
#> 
#> En cuanto al viento, en Canarias se mantendrá el alisio moderado,
#> con rachas muy fuertes en zonas expuestas. Asimismo, se esperan
#> intervalos de viento fuerte de levante en el Estrecho, de
#> tramontana en el Ampurdán y del norte en los litorales
#> atlánticos de Galicia. Por su parte, el cierzo en el valle del
#> Ebro y el levante en el sureste peninsular serán moderados. En el
#> resto del territorio, el viento será, en general, flojo;
#> predominará la componente norte en el tercio norte, Extremadura y
#> Castilla y León, la componente oeste en Andalucía occidental y
#> el viento de dirección variable en la meseta sur.
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
