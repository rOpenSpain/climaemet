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
#> DÍA 10 DE ABRIL DE 2026 A LAS 09:01 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL VIERNES 10
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Probables tormentas en el tercio sur peninsular a partir del
#> mediodía, sin descartar que afecten también al oeste de la
#> meseta norte, acompañadas de rachas muy fuertes de viento. Rachas
#> muy fuertes en las islas Canarias occidentales. Aumento notable de
#> las temperaturas máximas en el Cantábrico (más de 6 grados) y
#> de las mínimas en Cáceres y oeste de la meseta sur.
#> 
#> B.- PREDICCIÓN
#> La borrasca situada al suroeste de la Península se acercará de
#> nuevo y dejará los cielos nubosos o cubiertos en buena parte del
#> centro y del sur peninsular. En el resto del territorio los cielos
#> estarán poco nubosos o despejados. En Andalucía se esperan
#> tormentas a partir del mediodía, secas o de escasa
#> precipitación, que es probable que se extiendan hacia Extremadura
#> y el oeste meseta sur, pudiendo ir acompañadas de rachas de
#> viento muy fuertes. Con baja probabilidad, también pueden darse
#> en la meseta norte. En Canarias se prevén cielos nubosos y
#> precipitaciones en general débiles o moderadas.
#> 
#> Podrán aparecer brumas y nieblas matinales en el interior de
#> Galicia y de Asturias, en el valle del Guadalquivir y en el
#> litoral valenciano y balear. Seguirá habiendo abundante polvo en
#> suspensión, principalmente en el sur peninsular.
#> 
#> Se espera una subida generalizada de las temperaturas máximas,
#> notable en el Cantábrico (de más de 6 grados). Las mínimas
#> también subirán en buena parte del territorio, de forma notable
#> en Cáceres y en el oeste de la meseta sur; solo bajarán en el
#> norte, ligeramente. En Canarias las temperaturas subirán
#> ligeramente.
#> 
#> Predominarán los vientos, en general flojos, de componente sur en
#> el interior peninsular, del este en el Mediterráneo y en el
#> Cantábrico, y del oeste en las costas atlánticas. Podrán darse
#> rachas muy fuertes asociadas a las tormentas. En Canarias los
#> vientos serán del noroeste, moderados y con rachas muy fuertes.
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
