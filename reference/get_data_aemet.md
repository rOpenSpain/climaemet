# Query the AEMET OpenData API

Retrieves data and metadata from AEMET and converts JSON responses to a
[tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) when
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

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
when possible, otherwise a [raw](https://rdrr.io/r/base/raw.html) vector
or a [character](https://rdrr.io/r/base/character.html) string as
provided by
[`httr2::resp_body_raw()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`httr2::resp_body_string()`](https://httr2.r-lib.org/reference/resp_body_raw.html).

## See also

[`vignette("extending-climaemet", package = "climaemet")`](https://ropenspain.github.io/climaemet/articles/extending-climaemet.md)
provides usage examples.

AEMET OpenData API functions:
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md),
[`aemet_detect_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_detect_api_key.md)

## Examples

``` r
# Run only when AEMET_API_KEY is detected.

url <- "/api/valores/climatologicos/inventarioestaciones/todasestaciones"

get_data_aemet(url)
#> # A tibble: 926 × 7
#>    latitud provincia     altitud indicativo nombre             indsinop longitud
#>    <chr>   <chr>         <chr>   <chr>      <chr>              <chr>    <chr>   
#>  1 394924N ILLES BALEARS 490     B013X      ESCORCA, LLUC      "08304"  025309E 
#>  2 394744N BALEARES      5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N BALEARES      60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N BALEARES      52      B103B      ANDRATX - SANT ELM ""       022208E 
#>  5 393305N BALEARES      50      B158X      CALVIÀ, ES CAPDEL… ""       022759E 
#>  6 393315N BALEARES      3       B228       PALMA, PUERTO      "08301"  023731E 
#>  7 393832N BALEARES      95      B236C      PALMA, UNIVERSITAT ""       023838E 
#>  8 394406N ILLES BALEARS 1030    B248       SIERRA DE ALFABIA… "08303"  024247E 
#>  9 393621N BALEARES      47      B275E      SON BONET, AEROPU… "08302"  024224E 
#> 10 393339N BALEARES      5       B278       PALMA DE MALLORCA… "08306"  024412E 
#> # ℹ 916 more rows

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
#> → Returning a UTF-8 `character` string.

cat(plain)
#> AGENCIA ESTATAL DE METEOROLOGÍA
#> PREDICCIÓN GENERAL PARA ESPAÑA 
#> DÍA 28 DE OCTUBRE DE 2026 A LAS 08:58 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 28
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> No se descartan chubascos localmente fuertes en Murcia y el sur de
#> la Comunidad Valenciana. Descensos notables de las temperaturas
#> máximas en el interior de la Comunidad Valenciana y Pirineo
#> navarro.
#> 
#> B.- PREDICCIÓN
#> Se espera una jornada estable por la influencia de las altas
#> presiones en la Península y Baleares, con cielos poco nubosos o
#> despejados en general. Los restos de un frente dejarán los cielos
#> nubosos o cubiertos y algunas lloviznas en el tercio norte y en el
#> litoral catalán, aunque tenderán a despejar. En Murcia y el sur
#> de la Comunidad Valenciana, se prevén cielos nubosos y
#> precipitaciones en forma de chubasco, sin descartar que sean
#> localmente fuertes. En Canarias, los cielos estarán nubosos o
#> cubiertos aunque con tendencia a abrirse claros o a despejar y es
#> probable que haya alguna precipitación ocasional en los
#> interiores de las islas montañosas.
#> 
#> Son probables las brumas y los bancos de niebla matinales en el
#> tercio norte peninsular y el Estrecho. La calima en Canarias
#> empezará a remitir.
#> 
#> Las temperaturas máximas ascenderán en Galicia y la vertiente
#> atlántica sur y bajarán en el tercio este, el Cantábrico
#> oriental, el norte de Castilla y León y Baleares; los descensos
#> serán localmente notables en el interior de la Comunidad
#> Valenciana y Pirineo navarro. Las mínimas descenderán en el
#> centro peninsular y el Cantábrico oriental, subirán en los
#> litorales mediterráneos, Baleares y Melilla, y variarán poco en
#> el resto. En Canarias, las temperaturas bajarán ligeramente; solo
#> las máximas subirán ligeramente en la provincia occidental. Se
#> esperan heladas débiles en las zonas altas de los Pirineos.
#> 
#> Soplará un viento moderado del norte y nordeste en Baleares y en
#> los litorales de la fachada oriental peninsular, con intervalos
#> fuertes en el Ampurdán. El viento será moderado del este y
#> nordeste en los litorales de Galicia y, con intervalos fuertes, en
#> los del Cantábrico. Se espera una tendencia a establecerse el
#> levante moderado en Alborán y el Estrecho. En el resto, se espera
#> viento flojo y con predominio de la componente este, cierzo
#> moderado en el Ebro durante la primera mitad del día, y alisio
#> moderado en Canarias tendiendo a flojo.
#> 

# An image.

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Response MIME type: "image/gif".
#> → Returning `raw` bytes. See also `base::writeBin()`.

# Write and read.
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
```
