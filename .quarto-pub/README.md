# Geostatistical interpolation of minimum temperature in Spain

This directory contains the source and supporting files for the article
*Geostatistical interpolation of minimum temperature in Spain: A reproducible
comparison of ordinary kriging and inverse distance weighting*.

The published article is available on [Posit Connect
Cloud](https://dieghernan-geostatistical-interpolation-spain.share.connect.posit.cloud/).

## Contents

- `geostatistical-interpolation-spain.qmd` is the article source.
- `dealing.bib` contains the bibliography.
- `_brand.yml` and `custom.scss` define the visual identity.
- `epub.css` provides EPUB-specific typography and figure sizing.
- `geo.png`, `lattice.png`, `point.png` and `texture-bw.png` are source images.

## Generated and local files

The directory-specific `.gitignore` excludes:

- Rendered HTML, PDF and EPUB files.
- Quarto support directories ending in `_files`.
- Computation caches ending in `_cache`.
- LaTeX intermediate files.
- The local `rsconnect/` deployment record.

These files are generated locally or contain machine-specific publication
metadata and are not uploaded to GitHub.

## Requirements

Rendering requires Quarto, R and the R packages loaded by the article. PDF
output also requires a compatible LaTeX installation. Retrieving current AEMET
observations requires an AEMET OpenData API key.

## Render

From this directory, render every configured format with:

``` sh
quarto render geostatistical-interpolation-spain.qmd
```

Render an individual format with one of the following commands:

``` sh
quarto render geostatistical-interpolation-spain.qmd --to html
quarto render geostatistical-interpolation-spain.qmd --to pdf
quarto render geostatistical-interpolation-spain.qmd --to epub
```

The document uses cached computations. Remove or refresh the cache only when the
data or analysis must be recomputed.

## Publish

Publish the rendered document from a configured local environment. The
`rsconnect/` deployment record is intentionally ignored and is therefore not
available in a fresh clone. Confirm that the public URL remains aligned with the
canonical URL and citation URL in the article front matter.
