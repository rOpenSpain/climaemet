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
#> DÍA 02 DE JUNIO DE 2026 A LAS 07:41 HORA OFICIAL
#> PREDICCIÓN VÁLIDA PARA EL MARTES 2
#> 
#> A.- FENÓMENOS SIGNIFICATIVOS
#> Chubascos y tormentas localmente fuertes en el Pirineo oriental.
#> Temperaturas máximas en descenso acusado y generalizado en casi
#> toda la Península, salvo en el área mediteránea donde subirán,
#> siendo este ascenso localmente notable en el extremo sureste y
#> costa del Sol. Se podrán superar los 36-38 grados en puntos del
#> Guadalquivir y Costa del Sol, y los 38-40 en el extremo sureste
#> peninsular.
#> 
#> B.- PREDICCIÓN
#> El paso de un frente por el norte dejará tras de sí una masa de
#> aire más fresca en casi toda la Península, a excepción del sur
#> y sureste, donde las temperaturas máximas serán muy altas. En el
#> extremo norte, debido al frente predominarán los cielos nubosos o
#> cubiertos, que dejarán precipitaciones débiles y dispersas. En
#> el Pirineo oriental, a partir del mediodía, se esperan chubascos
#> y tormentas localmente fuertes y con posible granizo. También
#> podrían darse algún chubasco o tormenta aislada en la Ibérica
#> oriental. En cuanto al resto de la Península y Baleares, los
#> cielos estarán poco nubosos o con intervalos de nubes altas. En
#> Canarias, se prevén cielos nubosos en el norte, con alguna
#> precipitación débil en las islas montañosas, y poco nubosos o
#> despejados en el sur.
#> 
#> Las temperaturas máximas descenderán de forma generalizada y
#> acusada en la casi toda la Península, de forma notable (más de 6
#> grados) en regiones del tercio norte. La excepción será el área
#> mediterránea, donde las máximas subirán, incluso de forma
#> notable en el extremo sureste y Costa del Sol. En cuanto a las
#> mínimas, aumentarán en el litoral cantábrico y el cuadrante
#> sureste, bajarán en los Pirineos y sufrirán pocos cambios en el
#> resto. En Baleares se esperan ligeros ascensos térmicos y en
#> Canarias habrá pocas variaciones. Durante el día, es probable
#> superar los 36-38 grados en el Guadalquivir y puntos de Alborán y
#> los 38-40 grados en el extremo sureste. Además, se registrarán
#> noches tropicales (sin bajar de los 20 grados) en el centro, el
#> tercio sur y el litoral mediterráneo. En las cumbres de los
#> Pirineos se producirán heladas.
#> 
#> Se espera viento moderado de componentes oeste y norte en la
#> Península, con intervalos fuertes y posibles rachas muy fuertes
#> de poniente en el Estrecho y Alborán, y, a últimas horas, de
#> tramontana en Ampurdán y de cierzo en el bajo Ebro. En Canarias,
#> el alisio podrá venir acompañado de intervalos fuertes y
#> probables rachas muy fuertes en zonas expuestas.
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
