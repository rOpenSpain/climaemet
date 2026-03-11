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
#> DÍA 08 DE MARZO DE 2026 A LAS 08:00 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL DOMINGO 8
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probables precipitaciones localmente fuertes y con abundantes
#> acumulados en el nordeste y sudeste peninsular. Probable ascenso
#> localmente notable de las temperaturas máximas en zonas
#> occidentales del Cantábrico.
#> 
#> B.- PREDICCIÓN
#> Se mantendrá la inestabilidad en la Península y Baleares bajo la
#> influencia de una dana que se rellenará al norte de la
#> Península. Predominarán los cielos nubosos o cubiertos con una
#> tendencia a abrirse claros en amplias áreas del suroeste y de la
#> meseta Sur. Se esperan precipitaciones generalizadas, débiles y
#> ocasionales en el oeste de la meseta y más intensas hacia el
#> nordeste y sudeste peninsular con probables chubascos localmente
#> fuertes. Ocasionalmente los chubascos irán acompañados por
#> tormenta y granizo. Nevará en el Pirineo, pudiendo hacerlo de
#> forma débil en otras montañas de la mitad norte y del sureste,
#> con la cota entre 1400/1700 metros. En Canarias, cielos nubosos en
#> los nortes de las islas montañosas con posibles precipitaciones
#> débiles y cielos poco nubosos o con intervalos en el resto.
#> 
#> Probables bancos de niebla matinales en entornos de montaña, en
#> litorales mediterráneos y del golfo de Cádiz.
#> 
#> Se espera un descenso de las temperaturas máximas en Pirineos y
#> la Ibérica meridional, mientras que en el resto predominarán los
#> ascensos ligeros, más acusados en Galicia y Cantábrico donde
#> incluso puede ser localmente notable. Las mínimas en ligero
#> ascenso en el noroeste y ligeros descensos en el resto más
#> intensos en depresiones del noreste y zonas del oeste de la
#> meseta. Sin cambios en Canarias. Heladas débiles en cumbres de
#> los principales entornos de montaña.
#> 
#> Predominará viento flojo en el interior, rolando a componente
#> oeste y sur en la vertiente atlántica y cantábrica y
#> predominando las componentes sur y este en la mediterránea.
#> Soplará más intenso en los litorales atlánticos de componente
#> norte rolando en los gallegos al final del día a suroeste.
#> Intervalos de moderado de oeste en Alborán y de componente este y
#> noreste en el resto del Mediterráneo. En Canarias soplará un
#> alisio con intervalos de fuerte y posibles rachas muy fuertes en
#> zonas expuestas.
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
