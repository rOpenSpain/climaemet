# AEMET Stations

This annex shows an interactive and searchable version of the results
given by
[`climaemet::aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)
as of **17 Dec 2025**:

## Session info

Details

    #> ─ Session info ───────────────────────────────────────────────────────────────
    #>  setting  value
    #>  version  R version 4.5.2 (2025-10-31 ucrt)
    #>  os       Windows Server 2022 x64 (build 26100)
    #>  system   x86_64, mingw32
    #>  ui       RTerm
    #>  language en
    #>  collate  English_United States.utf8
    #>  ctype    English_United States.utf8
    #>  tz       UTC
    #>  date     2025-12-17
    #>  pandoc   3.1.11 @ C:/HOSTED~1/windows/pandoc/31F387~1.11/x64/PANDOC~1.11/ (via rmarkdown)
    #>  quarto   NA
    #> 
    #> ─ Packages ───────────────────────────────────────────────────────────────────
    #>  package      * version    date (UTC) lib source
    #>  bslib          0.9.0      2025-01-30 [1] RSPM
    #>  cachem         1.1.0      2024-05-16 [1] RSPM
    #>  class          7.3-23     2025-01-01 [3] CRAN (R 4.5.2)
    #>  classInt       0.4-11     2025-01-08 [1] RSPM
    #>  cli            3.6.5      2025-04-23 [1] RSPM
    #>  climaemet    * 1.4.2.9000 2025-12-17 [1] local
    #>  countrycode    1.6.1      2025-03-31 [1] RSPM
    #>  crosstalk    * 1.2.2      2025-08-26 [1] RSPM
    #>  curl           7.0.0      2025-08-19 [1] RSPM
    #>  DBI            1.2.3      2024-06-02 [1] RSPM
    #>  desc           1.4.3      2023-12-10 [1] RSPM
    #>  digest         0.6.39     2025-11-19 [1] RSPM
    #>  dplyr        * 1.1.4      2023-11-17 [1] RSPM
    #>  e1071          1.7-16     2024-09-16 [1] RSPM
    #>  evaluate       1.0.5      2025-08-27 [1] RSPM
    #>  farver         2.1.2      2024-05-13 [1] RSPM
    #>  fastmap        1.2.0      2024-05-15 [1] RSPM
    #>  fs             1.6.6      2025-04-12 [1] RSPM
    #>  generics       0.1.4      2025-05-09 [1] RSPM
    #>  ggplot2        4.0.1      2025-11-14 [1] RSPM
    #>  glue           1.8.0      2024-09-30 [1] RSPM
    #>  gtable         0.3.6      2024-10-25 [1] RSPM
    #>  hms            1.1.4      2025-10-17 [1] RSPM
    #>  htmltools      0.5.9      2025-12-04 [1] RSPM
    #>  htmlwidgets    1.6.4      2023-12-06 [1] RSPM
    #>  httpuv         1.6.16     2025-04-16 [1] CRAN (R 4.5.2)
    #>  httr2          1.2.2      2025-12-08 [1] RSPM
    #>  jquerylib      0.1.4      2021-04-26 [1] RSPM
    #>  jsonlite       2.0.0      2025-03-27 [1] RSPM
    #>  KernSmooth     2.23-26    2025-01-01 [3] CRAN (R 4.5.2)
    #>  knitr          1.50       2025-03-16 [1] RSPM
    #>  later          1.4.4      2025-08-27 [1] CRAN (R 4.5.2)
    #>  leaflet      * 2.2.3      2025-09-04 [1] RSPM
    #>  lifecycle      1.0.4      2023-11-07 [1] RSPM
    #>  magrittr       2.0.4      2025-09-12 [1] RSPM
    #>  mapSpain     * 0.10.0     2024-12-15 [1] RSPM
    #>  mime           0.13       2025-03-17 [1] RSPM
    #>  otel           0.2.0      2025-08-29 [1] RSPM
    #>  pillar         1.11.1     2025-09-17 [1] RSPM
    #>  pkgconfig      2.0.3      2019-09-22 [1] RSPM
    #>  pkgdown        2.2.0      2025-11-06 [1] any (@2.2.0)
    #>  promises       1.5.0      2025-11-01 [1] RSPM
    #>  proxy          0.4-28     2025-12-11 [1] RSPM
    #>  R6             2.6.1      2025-02-15 [1] RSPM
    #>  ragg           1.5.0      2025-09-02 [1] RSPM
    #>  rappdirs       0.3.3      2021-01-31 [1] RSPM
    #>  RColorBrewer   1.1-3      2022-04-03 [1] RSPM
    #>  Rcpp           1.1.0      2025-07-02 [1] CRAN (R 4.5.2)
    #>  reactable    * 0.4.5      2025-12-01 [1] RSPM
    #>  reactR         0.6.1      2024-09-14 [1] RSPM
    #>  readr          2.1.6      2025-11-14 [1] RSPM
    #>  rlang          1.1.6      2025-04-11 [1] RSPM
    #>  rmarkdown      2.30       2025-09-28 [1] RSPM
    #>  S7             0.2.1      2025-11-14 [1] RSPM
    #>  sass           0.4.10     2025-04-11 [1] RSPM
    #>  scales         1.4.0      2025-04-24 [1] RSPM
    #>  sessioninfo  * 1.2.3      2025-02-05 [1] any (@1.2.3)
    #>  sf           * 1.0-23     2025-11-28 [1] CRAN (R 4.5.2)
    #>  shiny          1.12.1     2025-12-09 [1] RSPM
    #>  systemfonts    1.3.1      2025-10-01 [1] RSPM
    #>  textshaping    1.0.4      2025-10-10 [1] RSPM
    #>  tibble         3.3.0      2025-06-08 [1] RSPM
    #>  tidyselect     1.2.1      2024-03-11 [1] RSPM
    #>  tzdb           0.5.0      2025-03-15 [1] RSPM
    #>  units          1.0-0      2025-10-09 [1] CRAN (R 4.5.2)
    #>  vctrs          0.6.5      2023-12-01 [1] RSPM
    #>  withr          3.0.2      2024-10-28 [1] RSPM
    #>  xfun           0.55       2025-12-16 [1] RSPM
    #>  xtable         1.8-4      2019-04-21 [1] RSPM
    #>  yaml           2.3.12     2025-12-10 [1] RSPM
    #> 
    #>  [1] D:/a/_temp/Library
    #>  [2] C:/R/site-library
    #>  [3] C:/R/library
    #>  * ── Packages attached to the search path.
    #> 
    #> ──────────────────────────────────────────────────────────────────────────────
