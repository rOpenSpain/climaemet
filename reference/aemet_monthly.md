# Monthly/annual climatology

Get monthly/annual climatology values for a station or all the stations.
`aemet_monthly_period()` and `aemet_monthly_period_all()` allows
requests that span several years.

## Usage

``` r
aemet_monthly_clim(
  station = NULL,
  year = as.integer(format(Sys.Date(), "%Y")),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)

aemet_monthly_period(
  station = NULL,
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)

aemet_monthly_period_all(
  start = as.integer(format(Sys.Date(), "%Y")),
  end = start,
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)
```

## Arguments

- station:

  Character string with station identifier code(s) (see
  [`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)).

- year:

  Numeric value as date (format: `YYYY`).

- verbose:

  Logical `TRUE/FALSE`. Provides information about the flow of
  information between the client and server.

- return_sf:

  Logical `TRUE` or `FALSE`. Should the function return an
  [`sf`](https://r-spatial.github.io/sf/reference/sf.html) spatial
  object? If `FALSE` (the default value) it returns a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html).
  Note that you need to have the
  [sf](https://CRAN.R-project.org/package=sf) package installed.

- extract_metadata:

  Logical `TRUE/FALSE`. On `TRUE` the output is a
  [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html)
  with the description of the fields. See also
  [`get_metadata_aemet()`](https://ropenspain.github.io/climaemet/reference/get_data_aemet.md).

- progress:

  Logical, display a
  [`cli::cli_progress_bar()`](https://cli.r-lib.org/reference/cli_progress_bar.html)
  object. If `verbose = TRUE` won't be displayed.

- start:

  Numeric value as start year (format: `YYYY`).

- end:

  Numeric value as end year (format: `YYYY`).

## Value

A [tibble](https://tibble.tidyverse.org/reference/tbl_df-class.html) or
a [sf](https://CRAN.R-project.org/package=sf) object.

## API Key

You need to set your API Key globally using
[`aemet_api_key()`](https://ropenspain.github.io/climaemet/reference/aemet_api_key.md).

## See also

Other aemet_api_data:
[`aemet_alert_zones()`](https://ropenspain.github.io/climaemet/reference/aemet_alert_zones.md),
[`aemet_alerts()`](https://ropenspain.github.io/climaemet/reference/aemet_alerts.md),
[`aemet_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_beaches.md),
[`aemet_daily_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_daily.md),
[`aemet_extremes_clim()`](https://ropenspain.github.io/climaemet/reference/aemet_extremes_clim.md),
[`aemet_forecast_beaches()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_beaches.md),
[`aemet_forecast_daily()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast.md),
[`aemet_forecast_fires()`](https://ropenspain.github.io/climaemet/reference/aemet_forecast_fires.md),
[`aemet_last_obs()`](https://ropenspain.github.io/climaemet/reference/aemet_last_obs.md),
[`aemet_normal`](https://ropenspain.github.io/climaemet/reference/aemet_normal.md),
[`aemet_stations()`](https://ropenspain.github.io/climaemet/reference/aemet_stations.md)

## Examples

``` r
library(tibble)
obs <- aemet_monthly_clim(station = c("9434", "3195"), year = 2000)
glimpse(obs)
#> Rows: 26
#> Columns: 45
#> $ indicativo <chr> "9434", "9434", "9434", "9434", "9434", "9434", "9434", "94…
#> $ p_max      <chr> "8.0(15)", "0.0(--)", "5.4(22)", "22.2(26)", "23.4(05)", "1…
#> $ n_cub      <dbl> 8, 0, 4, 8, 6, 2, 1, 1, 0, 6, 6, 7, 49, 5, 1, 4, 14, 8, 0, …
#> $ hr         <dbl> 77, 60, 58, 61, 61, 57, 48, 53, 53, 67, 73, 78, 62, 75, 62,…
#> $ n_gra      <dbl> 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 3, 0, 0, 0, 1, 0, 0, 0,…
#> $ n_fog      <dbl> 6, 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 4, 14, 3, 0, 0, 0, 1, 0, 0…
#> $ inso       <dbl> 5.4, 7.7, 7.8, 6.2, 8.7, 11.3, 11.2, 10.5, 9.4, 5.6, 5.2, 3…
#> $ q_max      <chr> "1003.5(11)", "1004.9(04)", "1001.0(09)", "991.5(07)", "991…
#> $ nw_55      <dbl> 5, 9, 8, 7, NA, NA, 5, 8, 3, 4, 5, 3, NA, 0, 0, 0, 5, 0, 0,…
#> $ q_mar      <dbl> 1026.0, 1027.1, 1020.3, 1008.0, 1014.4, 1017.1, 1013.6, 101…
#> $ q_med      <dbl> 994.1, 996.0, 989.5, 977.8, 984.7, 987.6, 984.4, 986.3, 984…
#> $ tm_min     <dbl> -0.1, 4.8, 6.0, 8.4, 13.2, 16.0, 17.7, 18.2, 15.0, 11.2, 6.…
#> $ ta_max     <chr> "16.3(31)", "20.8(27)", "24.0(11)", "27.2(25)", "33.0(30)",…
#> $ ts_min     <dbl> 6.2, 10.7, 11.0, 14.9, 18.8, 20.3, 21.4, 21.5, 20.0, 14.9, …
#> $ nt_30      <dbl> 0, 0, 0, 0, 5, 19, 19, 21, 12, 0, 0, 0, 76, 0, 0, 0, 0, 2, …
#> $ nv_0050    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,…
#> $ n_des      <dbl> 12, 8, 8, 1, 1, 18, 14, 12, 9, 3, 1, 1, 88, 15, 8, 11, 0, 3…
#> $ w_racha    <chr> "32/22.2(22)", "33/21.4(17)", "32/20.0(15)", "10/20.0(02)",…
#> $ np_100     <dbl> 0, 0, 0, 1, 3, 1, 0, 0, 0, 4, 3, 0, 12, 1, 0, 2, 2, 2, 2, 1…
#> $ n_nub      <dbl> 11, 21, 19, 21, 24, 10, 16, 18, 21, 22, 23, 23, 229, 11, 20…
#> $ p_sol      <dbl> 56, 72, 65, 46, 59, 75, 76, 76, 75, 51, 53, 39, 62, 65, 70,…
#> $ nw_91      <dbl> 0, 0, 0, 0, NA, NA, 0, 0, 0, 0, 0, 1, NA, 0, 0, 0, 0, 0, 0,…
#> $ ts_20      <dbl> 4.9, 11.8, 14.9, 16.7, 23.5, 27.7, 30.8, 31.3, 27.0, 17.8, …
#> $ np_001     <dbl> 3, 0, 7, 10, 13, 6, 4, 4, 3, 10, 14, 14, 88, 6, 1, 5, 21, 1…
#> $ ta_min     <chr> "-5.8(12)", "-1.5(06)", "-0.8(03)", "1.7(06)", "9.2(01)", "…
#> $ e          <dbl> 65, 79, 83, 99, 143, 164, 153, 172, 139, 116, 91, 90, 116, …
#> $ np_300     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,…
#> $ nv_1000    <dbl> 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 7, 2, 0, 0, 0, 0, 0, 0,…
#> $ evap       <dbl> 861, 1638, 2062, 1730, 2116, 2955, 3494, 3584, 2846, 2111, …
#> $ p_mes      <dbl> 14.9, 0.0, 11.1, 49.1, 67.5, 34.9, 4.7, 2.4, 1.9, 104.5, 61…
#> $ n_llu      <dbl> 3, 0, 7, 14, 11, 8, 4, 6, 7, 12, 14, 17, 103, 4, 1, 5, 21, …
#> $ n_tor      <dbl> 0, 0, 0, 1, 8, 4, 1, 5, 3, 0, 1, 0, 23, 0, 0, 1, 1, 3, 3, 1…
#> $ ts_10      <dbl> 5.0, 12.7, 15.7, 17.5, 24.8, 29.2, 32.3, 32.1, 27.6, 17.7, …
#> $ w_med      <dbl> 15, 16, 18, 17, 13, 21, 19, 18, 14, 15, 15, 14, 16, 5, 5, 7…
#> $ nt_00      <dbl> 16, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 23, 13, 0, 0, 0, 0, 0,…
#> $ ti_max     <dbl> 1.0, 13.4, 12.1, 11.7, 21.5, 16.5, 22.5, 25.5, 21.2, 14.5, …
#> $ n_nie      <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0,…
#> $ tm_mes     <dbl> 4.3, 10.8, 12.0, 13.7, 19.5, 23.0, 24.4, 25.3, 21.8, 15.8, …
#> $ tm_max     <dbl> 8.7, 16.9, 17.9, 18.9, 25.7, 29.8, 31.0, 32.4, 28.5, 20.4, …
#> $ nv_0100    <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0,…
#> $ ts_50      <dbl> 5.6, 10.6, 13.6, 15.2, 20.8, 26.1, 28.3, 28.9, 25.9, 18.4, …
#> $ q_min      <chr> "979.7(14)", "988.6(17)", "976.5(28)", "959.5(02)", "977.5(…
#> $ np_010     <dbl> 2, 0, 4, 6, 8, 5, 3, 1, 1, 7, 9, 8, 54, 3, 1, 4, 13, 9, 3, …
#> $ fecha      <chr> "2000-01", "2000-02", "2000-03", "2000-04", "2000-05", "200…
#> $ w_rec      <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 144, 14…
```
