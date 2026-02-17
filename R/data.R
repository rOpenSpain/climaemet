#' Wind conditions for Zaragoza Airport ("9434") period 2000-2020
#'
#' @description
#' Daily observations of wind speed and directions for Zaragoza Airport
#' (2000-2020). This is an example dataset.
#'
#' @family dataset
#' @family wind
#'
#' @name climaemet_9434_wind
#'
#' @docType data
#'
#' @format A [tibble][tibble::tbl_df] with columns:
#'
#' \describe{
#'   \item{fecha}{Date of observation.}
#'   \item{dir}{Wind directions (0-360).}
#'   \item{velmedia}{Average wind speed (km/h)}
#' }
#'
#' @source AEMET.
#'
#' @examples
#' data(climaemet_9434_wind)
NULL

#' Average annual temperatures for Zaragoza Airport ("9434") period 1950-2020
#'
#' @description
#' Yearly observations of average temperature for Zaragoza Airport
#' (1950-2020). This is an example dataset.
#' @examples
#' data(climaemet_9434_temp)
#' @family dataset
#' @family stripes
#'
#' @name climaemet_9434_temp
#'
#' @docType data
#'
#' @format A [tibble][tibble::tbl_df] with columns:
#' \describe{
#'   \item{year}{Year of reference.}
#'   \item{indicativo}{Identifier of the station.}
#'   \item{temp}{Average temperature (Celsius).}
#' }
#'
#' @source AEMET.
NULL

#' Climatogram data for Zaragoza Airport ("9434") period 1981-2010
#'
#' @description
#' Normal data for Zaragoza Airport (1981-2010). This is an example dataset
#' used to plot climatograms.
#'
#' @family dataset
#' @family climatogram
#'
#' @name climaemet_9434_climatogram
#' @examples
#' data(climaemet_9434_climatogram)
#' @docType data
#'
#' @format A data.frame with columns 1 to 12 (months) and rows:
#' \describe{
#'   \item{p_mes_md}{Precipitation (mm).}
#'   \item{tm_max_md}{Maximum temperature (Celsius).}
#'   \item{tm_min_md}{Minimum temperature (Celsius).}
#'   \item{ta_min_md}{Absolute monthly minimum temperature (Celsius).}
#' }
#' @seealso [ggclimat_walter_lieth()], [climatogram_period()],
#' [climatogram_normal()]
#'
#' @source AEMET.
NULL

#' Data set with all the municipalities of Spain
#'
#' @name aemet_munic
#'
#' @docType data
#' @family dataset
#' @family forecast
#'
#' @description
#' A [tibble][tibble::tbl_df] with all the municipalities of Spain as
#' defined by the INE (Instituto Nacional de Estadistica) as of January 2025.
#'
#' @source
#' INE,Municipality codes by province:
#'
#' <https://www.ine.es/daco/daco42/codmun/diccionario25.xlsx>
#' @encoding UTF-8
#'
#' @seealso [aemet_forecast_daily()],
#' [aemet_forecast_hourly()]
#' @format
#' A [tibble][tibble::tbl_df] with
#' `r prettyNum(nrow(climaemet::aemet_munic), big.mark=",")` rows and fields:
#' \describe{
#'   \item{municipio}{INE code of the municipality.}
#'   \item{municipio_nombre}{INE name of the municipality.}
#'   \item{cpro}{INE code of the province.}
#'   \item{cpro_nombre}{INE name of the province.}
#'   \item{codauto}{INE code of the autonomous community.}
#'   \item{codauto_nombre}{INE code of the autonomous community.}
#' }
#' @examples
#'
#' data(aemet_munic)
#'
#' aemet_munic
NULL
