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
#>    latitud provincia             altitud indicativo nombre     indsinop longitud
#>    <chr>   <chr>                 <chr>   <chr>      <chr>      <chr>    <chr>   
#>  1 395934N ILLES BALEARS         20      B860X      CIUTADELLA ""       035114E 
#>  2 394406N ILLES BALEARS         1030    B248       SIERRA DE… "08303"  024247E 
#>  3 393621N BALEARES              47      B275E      SON BONET… "08302"  024224E 
#>  4 394121N ILLES BALEARS         60      B087X      BANYALBUF… ""       023046E 
#>  5 395641N BALEARES              43      B870C      CIUTADELL… ""       035724E 
#>  6 283914N STA. CRUZ DE TENERIFE 844     C126A      EL PASO    ""       175111W 
#>  7 385747N BALEARES              32      B925       SANT ANTO… ""       011917E 
#>  8 281327N STA. CRUZ DE TENERIFE 1654    C423R      CITFAGRO_… ""       163116W 
#>  9 282222N STA. CRUZ DE TENERIFE 551     C456R      CITFAGRO_… ""       163231W 
#> 10 394041N ILLES BALEARS         105     B662X      BINISSALEM ""       025226E 
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
#> DÍA 04 DE MARZO DE 2026 A LAS 08:35 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MIÉRCOLES 4
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos y tormentas con probabilidad de ser fuertes en regiones
#> de Andalucía, Castilla-La Mancha y Madrid, también posibles en
#> Extremadura y este de Canarias, y con acumulados significativos en
#> el entorno del Estrecho. Descenso notable de las temperaturas
#> máximas en áreas de Andalucía. Rachas muy fuertes de viento en
#> Canarias y zonas del tercio sureste peninsular.
#> 
#> B.- PREDICCIÓN
#> Situación de inestabilidad en la mayor parte del país debido a
#> una dana situada sobre Marruecos con tendencia a desplazarse a
#> Alborán. Predominarán los cielos nubosos o cubiertos en la mitad
#> sureste peninsular y los poco nubosos en el resto, tendiendo a
#> nublarse a lo largo del día a excepción del Cantábrico y tercio
#> noroeste. Las precipitaciones, principalmente en forma de
#> chubascos extendiéndose de sur a norte, afectarán a la mitad
#> sur, fachada oriental y zona centro peninsular, siendo posibles
#> también en el Pirineo. Estos chubascos irán con tormenta y
#> granizo ocasional y es probable que sean fuertes en regiones de
#> Andalucía, Castilla-La Mancha y Madrid, sin descartar
#> Extremadura. Asimismo se prevén acumulados significativos en el
#> entorno del Estrecho. Cielos nubosos o con intervalos nubosos en
#> Baleares con posibilidad de algún chubasco ocasional. En Canarias
#> cielos nubosos con precipitaciones, más abundantes en el norte de
#> las islas y con posibilidad de ser locamente fuertes e ir con
#> tormenta en las orientales. Nevará por encima de 1800/2000 metros
#> en las islas y sureste peninsular.
#> 
#> Bancos de niebla en interiores del tercio este peninsular, entorno
#> de la Ibérica y alto Ebro, con calima en la Península y Baleares
#> extendiéndose al este de Canarias.
#> 
#> Temperaturas máximas en descenso en la mitad sur peninsular,
#> notable en regiones de Andalucía, con aumentos Canarias y Sistema
#> Central. Mínimas en descenso en el tercio sur peninsular y zonas
#> de meseta aledañas al Sistema Central, aumentando en la mitad
#> norte del área mediterránea. Pocos cambios térmicos en el
#> resto. Heladas débiles en Pirineos.
#> 
#> Soplará viento de componente norte con intervalos de fuerte y
#> probables rachas muy fuertes en Canarias y fachada oriental
#> peninsular tendiendo en general a amainar. Predominio de viento de
#> componente este en el resto, moderado en Baleares, meseta Sur y
#> mitad oriental y litorales peninsulares, con probables las rachas
#> muy fuertes en regiones del tercio sureste.
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
