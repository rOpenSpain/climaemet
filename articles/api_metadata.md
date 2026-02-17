# AEMET API Metadata

The following table shows the metadata provided by AEMET for each of the
functions included on **climaemet** (Last update: **17-February-2026**).

## Session info

    #> ─ Session info ───────────────────────────────────────────────────────────────
    #>  setting  value
    #>  version  R version 4.5.2 (2025-10-31)
    #>  os       Ubuntu 24.04.3 LTS
    #>  system   x86_64, linux-gnu
    #>  ui       X11
    #>  language en
    #>  collate  C.UTF-8
    #>  ctype    C.UTF-8
    #>  tz       UTC
    #>  date     2026-02-17
    #>  pandoc   3.1.11 @ /opt/hostedtoolcache/pandoc/3.1.11/x64/ (via rmarkdown)
    #>  quarto   1.8.27 @ /usr/local/bin/quarto
    #>
    #> ─ Packages ───────────────────────────────────────────────────────────────────
    #>  package      * version    date (UTC) lib source
    #>  bit            4.6.0      2025-03-06 [1] RSPM
    #>  bit64          4.6.0-1    2025-01-16 [1] RSPM
    #>  cli            3.6.5      2025-04-23 [1] RSPM
    #>  climaemet    * 1.5.0.9000 2026-02-17 [1] local
    #>  crayon         1.5.3      2024-06-20 [1] RSPM
    #>  crosstalk      1.2.2      2025-08-26 [1] RSPM
    #>  curl           7.0.0      2025-08-19 [1] RSPM
    #>  digest         0.6.39     2025-11-19 [1] RSPM
    #>  dplyr        * 1.2.0      2026-02-03 [1] RSPM
    #>  evaluate       1.0.5      2025-08-27 [1] RSPM
    #>  farver         2.1.2      2024-05-13 [1] RSPM
    #>  fastmap        1.2.0      2024-05-15 [1] RSPM
    #>  generics       0.1.4      2025-05-09 [1] RSPM
    #>  ggplot2        4.0.2      2026-02-03 [1] RSPM
    #>  glue           1.8.0      2024-09-30 [1] RSPM
    #>  gtable         0.3.6      2024-10-25 [1] RSPM
    #>  hms            1.1.4      2025-10-17 [1] RSPM
    #>  htmltools      0.5.9      2025-12-04 [1] RSPM
    #>  htmlwidgets    1.6.4      2023-12-06 [1] RSPM
    #>  httr2          1.2.2      2025-12-08 [1] RSPM
    #>  jsonlite       2.0.0      2025-03-27 [1] RSPM
    #>  knitr          1.51       2025-12-20 [1] RSPM
    #>  lifecycle      1.0.5      2026-01-08 [1] RSPM
    #>  magrittr       2.0.4      2025-09-12 [1] RSPM
    #>  otel           0.2.0      2025-08-29 [1] RSPM
    #>  pillar         1.11.1     2025-09-17 [1] RSPM
    #>  pkgconfig      2.0.3      2019-09-22 [1] RSPM
    #>  purrr          1.2.1      2026-01-09 [1] RSPM
    #>  R.cache        0.17.0     2025-05-02 [1] RSPM
    #>  R.methodsS3    1.8.2      2022-06-13 [1] RSPM
    #>  R.oo           1.27.1     2025-05-02 [1] RSPM
    #>  R.utils        2.13.0     2025-02-24 [1] RSPM
    #>  R6             2.6.1      2025-02-15 [1] RSPM
    #>  ragg           1.5.0      2025-09-02 [1] RSPM
    #>  rappdirs       0.3.4      2026-01-17 [1] RSPM
    #>  RColorBrewer   1.1-3      2022-04-03 [1] RSPM
    #>  reactable    * 0.4.5      2025-12-01 [1] RSPM
    #>  reactR         0.6.1      2024-09-14 [1] RSPM
    #>  readr          2.1.6      2025-11-14 [1] RSPM
    #>  rlang          1.1.7      2026-01-09 [1] RSPM
    #>  rmarkdown      2.30       2025-09-28 [1] RSPM
    #>  S7             0.2.1      2025-11-14 [1] RSPM
    #>  scales         1.4.0      2025-04-24 [1] RSPM
    #>  sessioninfo    1.2.3      2025-02-05 [1] any (@1.2.3)
    #>  styler         1.11.0     2025-10-13 [1] RSPM
    #>  systemfonts    1.3.1      2025-10-01 [1] RSPM
    #>  textshaping    1.0.4      2025-10-10 [1] RSPM
    #>  tibble         3.3.1      2026-01-11 [1] RSPM
    #>  tidyr          1.3.2      2025-12-19 [1] RSPM
    #>  tidyselect     1.2.1      2024-03-11 [1] RSPM
    #>  tzdb           0.5.0      2025-03-15 [1] RSPM
    #>  utf8           1.2.6      2025-06-08 [1] RSPM
    #>  vctrs          0.7.1      2026-01-23 [1] RSPM
    #>  vroom          1.7.0      2026-01-27 [1] RSPM
    #>  withr          3.0.2      2024-10-28 [1] RSPM
    #>  xfun           0.56       2026-01-18 [1] RSPM
    #>  yaml           2.3.12     2025-12-10 [1] RSPM
    #>
    #>  [1] /home/runner/work/_temp/Library
    #>  [2] /opt/R/4.5.2/lib/R/site-library
    #>  [3] /opt/R/4.5.2/lib/R/library
    #>  * ── Packages attached to the search path.
    #>
    #> ──────────────────────────────────────────────────────────────────────────────
