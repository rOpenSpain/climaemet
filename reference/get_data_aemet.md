# Client tool for AEMET API

Client tool to get data and metadata from AEMET and convert json to
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html).

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

A [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) (if
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
#>  2 394744N ILLES BALEARS 5       B051A      SÓLLER, PUERTO     "08316"  024129E 
#>  3 394121N ILLES BALEARS 60      B087X      BANYALBUFAR        ""       023046E 
#>  4 393446N ILLES BALEARS 52      B103B      ANDRATX - SANT ELM ""       022208E 
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
#> DÍA 16 DE DICIEMBRE DE 2025 A LAS 08:51 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MARTES 16
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos fuertes y/o persistentes acompañados de tormenta y
#> ocasionalmente granizo en la fachada oriental peninsular y
#> Asturias, así como a primeras horas en el norte de Galicia,
#> Cádiz, Ceuta, Alborán y zonas del Pirineo. Probables
#> acumulaciones significativas de nieve en cotas altas del Sistema
#> Central. Nieblas densas en zonas de montaña de la mitad norte.
#> 
#> B.- PREDICCIÓN
#> Un frente atlántico, unido a la formación de un sistema de bajas
#> presiones al sureste de la Península dejarán cielos nubosos o
#> cubiertos con precipitaciones generalizadas en la Península y
#> Baleares, tendiendo en general a menos de oeste a este. Se prevén
#> fuertes y/o persistentes en la fachada oriental peninsular y
#> Asturias, así como a primeras horas en el norte de Galicia,
#> Cádiz, Ceuta, Alborán y zonas del Pirineo, pudiendo darse
#> también chubascos localmente fuertes en zonas aledañas del
#> Cantábrico e islas Pitiusas, o ser persistentes en el Sistema
#> Central. Con incertidumbre, los mayores acumulados se prevén en
#> el entorno de Castellón y sur de Tarragona, y se espera que vayan
#> con tormenta y probable granizo ocasional en regiones del
#> Mediterráneo y en el Estrecho. Cota de nieve: 1500/1800 metros,
#> bajando a 1300/1600 m. en el cuadrante noroeste con probables
#> acumulados significativos en el Sistema Central. La cola del
#> frente también llegará a Canarias, con cielos nubosos y
#> precipitaciones débiles en los nortes de las islas.
#> 
#> Bancos de niebla en entornos de montaña e interiores del tercio
#> este peninsular.
#> 
#> Salvo algunos aumentos en el entorno pirenaico, Ampurdán, sur de
#> Galicia y noroeste de Castilla y León, las temperaturas máximas
#> descenderán en la Península y Baleares, con pocos cambios en
#> Canarias. Mínimas en aumento en la meseta Norte y nordeste de la
#> Sur, en descenso en Andalucía y Mediterráneo y pocos cambios en
#> el resto. Heladas débiles en entornos de montaña.
#> 
#> Soplará poniente con intervalos fuertes en el Estrecho y
#> Alborán, con viento moderado del norte en Galicia con intervalos
#> fuertes en litorales, del sur y oeste rolando a norte y oeste en
#> el Cantábrico y del suroeste en Baleares y litorales del sureste
#> peninsular. Viento flojo de componente sur y este en el resto,
#> rolando a norte y oeste en la mitad occidental peninsular y
#> arreciando el este en el Levante. Viento moderado del norte en
#> Canarias arreciando a fuerte con probables rachas muy fuertes.
#> 

# An image

image <- get_data_aemet("/api/mapasygraficos/analisis")
#> ℹ Results are MIME type: "image/gif".
#> → Returning <raw> bytes. See also `base::writeBin()`.

# Write and read
tmp <- tempfile(fileext = ".gif")

writeBin(image, tmp)

gganimate::gif_file(tmp)
#> Error in shell.exec(url): file association for 'C:\Users\RUNNER~1\AppData\Local\Temp\RtmpARoBRY\file6d477386b4d.gif' not available or invalid
```
