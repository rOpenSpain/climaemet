# Data set with all the municipalities of Spain

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
with all the municipalities of Spain as defined by the INE (Instituto
Nacional de Estadistica) as of January 2025.

## Format

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
with 8,132 rows and fields:

- municipio:

  INE code of the municipality.

- municipio_nombre:

  INE name of the municipality.

- cpro:

  INE code of the province.

- cpro_nombre:

  INE name of the province.

- codauto:

  INE code of the autonomous community.

- codauto_nombre:

  INE code of the autonomous community.

## Source

INE,Municipality codes by province:

<https://www.ine.es/daco/daco42/codmun/diccionario25.xlsx>

## See also

[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_hourly()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md)

Other dataset:
[`climaemet_9434_climatogram`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_climatogram.md),
[`climaemet_9434_temp`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_temp.md),
[`climaemet_9434_wind`](https://ropenspain.github.io/climaemet/reference/climaemet_9434_wind.md)

## Examples

``` r
data(aemet_munic)

aemet_munic
#> # A tibble: 8,132 × 6
#>    municipio municipio_nombre      cpro  cpro_nombre codauto codauto_nombre
#>    <chr>     <chr>                 <chr> <chr>       <chr>   <chr>         
#>  1 01001     Alegría-Dulantzi      01    Araba/Álava 16      País Vasco    
#>  2 01002     Amurrio               01    Araba/Álava 16      País Vasco    
#>  3 01003     Aramaio               01    Araba/Álava 16      País Vasco    
#>  4 01004     Artziniega            01    Araba/Álava 16      País Vasco    
#>  5 01006     Armiñón               01    Araba/Álava 16      País Vasco    
#>  6 01008     Arratzua-Ubarrundia   01    Araba/Álava 16      País Vasco    
#>  7 01009     Asparrena             01    Araba/Álava 16      País Vasco    
#>  8 01010     Ayala/Aiara           01    Araba/Álava 16      País Vasco    
#>  9 01011     Baños de Ebro/Mañueta 01    Araba/Álava 16      País Vasco    
#> 10 01013     Barrundia             01    Araba/Álava 16      País Vasco    
#> # ℹ 8,122 more rows
```
