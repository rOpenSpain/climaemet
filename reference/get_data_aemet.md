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
#> DÍA 04 DE AGOSTO DE 2026 A LAS 08:36 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MARTES 4
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probables chubascos y tormentas fuertes acompañadas de granizo
#> que pueden afectar al nordeste peninsular e interior de Mallorca.
#> Temperaturas muy altas en Canarias, y significativamente altas en
#> zonas de Baleares, Alborán y tercio este peninsular. Alisio con
#> rachas muy fuertes en Canarias
#> 
#> B.- PREDICCIÓN
#> Se prevé una situación de estabilidad en la mayor parte del
#> país con predominio de cielos poco nubosos o despejados.
#> Únicamente en Galicia y área cantábrica predominarán los
#> nubosos o cubiertos, con precipitaciones débiles y dispersas que
#> podrían ser más intensas y afectar a más zonas por la tarde en
#> forma de chubascos. Asimismo, por la tarde se formará nubosidad
#> de evolución en otras zonas de la mitad norte peninsular, con
#> chubascos y tormentas en el cuadrante nordeste que podrían ser
#> localmente fuertes e ir con granizo en puntos de Cataluña,
#> Aragón, norte de la Comunidad Valenciana e interior de Mallorca.
#> 
#> Probables bancos de niebla matinales en Galicia, área cantábrica
#> y puntos del Levante. Calima en altura en Canarias.
#> 
#> Las temperaturas máximas descenderán en el oeste peninsular,
#> Pirineos y Alborán, predominando los ascensos en el resto de la
#> mitad oriental de la Península y permaneciendo sin cambios en el
#> resto. Se prevé superar los 35 grados en los tercios sur y este
#> peninsulares, así como en Baleares y en Canarias, donde se
#> podrán alcanzar localmente los 40. Las mínimas descenderán en
#> el centro peninsular, manteniéndose con pocos cambios en el
#> resto. Con ello se darán noches tropicales, sin bajar de 20
#> grados, en amplias zonas de la mitad sureste peninsular y en
#> Baleares, quedando por encima de 25 en puntos del litoral
#> mediterráneo y en Canarias, donde incluso localmente podrían no
#> bajar de 30 grados.
#> 
#> Soplará el alisio con intervalos fuertes y rachas muy fuertes en
#> Canarias, con viento moderado de componente norte en los litorales
#> de Cataluña y de componente oeste en los del sur peninsular y
#> norte de Galicia. Viento flojo en general en el resto con un
#> predominio de la componente oeste en la Península, la norte en
#> Baleares y con régimen de brisas en litorales.
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
