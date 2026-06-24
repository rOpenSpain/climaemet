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
#> DÍA 23 DE JUNIO DE 2026 A LAS 11:29 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MARTES 23
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Temperaturas muy altas, pudiendo alcanzarse los 38 grados en
#> amplias zonas de la Península y Baleares, los 40-42 grados en el
#> interior del Cantábrico, zonas bajas del nordeste y en los valles
#> del Ebro, Tajo y Guadiana; en el Guadalquivir se podrán superar
#> los 44 grados en su curso medio-alto. Ascensos notables en los
#> litorales del Cantábrico occidental. Tormentas y/o chubascos
#> localmente fuertes en el norte peninsular.
#> 
#> B.- PREDICCIÓN
#> Continúa la ola de calor con una situación de estabilidad y
#> entrada de aire cálido del sur. En la Península y Baleares los
#> cielos estarán poco nubosos, aunque con nubes altas, excepto por
#> la presencia de nubes bajas matinales en los litorales del
#> noroeste y del Ampurdán. Se espera el desarrollo de nubes de
#> evolución en los sistemas montañosos de la mitad norte,
#> especialmente en el noroeste, con la formación de tormentas
#> aisladas y chubascos puntuales; sin descartarlas en zonas de la
#> Ibérica. En Canarias se esperan nubes en el norte de las islas
#> con precipitaciones débiles, sobre todo a primeras horas, y poco
#> nuboso o despejado en el sur.
#> 
#> Son probables las brumas o los bancos de niebla matinales en los
#> litorales de Galicia y en el Cantábrico occidental. Calima débil
#> que afectará a la Península.
#> 
#> Se espera que continúen las temperaturas muy altas, con ligeros
#> descensos de las máximas en el litoral de la mitad este y
#> Baleares y ascensos en la mitad oeste, que en los litorales del
#> Cantábrico occidental se esperan notables. Predominio de ascensos
#> ligeros de las mínimas. Es probable que se superen los 35 grados
#> de forma generalizada en la Península y Baleares, salvo en
#> algunos litorales y montañas; los 38-40 grados en amplias zonas
#> del interior peninsular, y los 40-42 grados, puntualmente en el
#> interior del Cantábrico, zonas bajas del nordeste y en los valles
#> del Ebro, Tajo, Guadiana y Guadalquivir. Se prevén noches
#> tropicales (mínimas por encima de los 20 grados), o incluso
#> tórridas (por encima de los 25 grados), en amplias zonas del
#> centro-sur, el suroeste, el valle del Ebro, Baleares y los
#> litorales mediterráneos. Ligeros descensos de las máximas en
#> Canarias.
#> 
#> Viento en general flojo de dirección variable en el interior
#> peninsular, con predominio de la componente sur. Flojo del este en
#> el Mediterráneo y Baleares, con levante moderado y con intervalos
#> de fuerte en el Estrecho y Alborán. Viento moderado del nordeste
#> en las costas gallegas. En Canarias, alisio moderado.
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
