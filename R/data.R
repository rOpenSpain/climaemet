#' Wind conditions for Zaragoza Airport ("9434"), 2000-2020
#'
#' @description
#' Daily observations of wind speed and direction for Zaragoza Airport
#' (2000-2020). This is an example dataset.
#'
#' @name climaemet_9434_wind
#'
#' @docType data
#'
#' @format A [tibble][dplyr::tibble] with columns:
#'
#' \describe{
#'   \item{fecha}{Date of observation.}
#'   \item{dir}{Wind direction (0-360 degrees).}
#'   \item{velmedia}{Average wind speed (km/h).}
#' }
#'
#' @source AEMET.
#'
#' @family dataset
#' @family wind
#'
#' @encoding UTF-8
#'
#' @examples
#' data(climaemet_9434_wind)
NULL

#' Average annual temperatures for Zaragoza Airport ("9434"), 1950-2020
#'
#' @description
#' Yearly observations of average temperature for Zaragoza Airport
#' (1950-2020). This is an example dataset.
#' @name climaemet_9434_temp
#'
#' @docType data
#'
#' @format A [tibble][dplyr::tibble] with columns:
#' \describe{
#'   \item{year}{Year of reference.}
#'   \item{indicativo}{Identifier of the station.}
#'   \item{temp}{Average temperature (Celsius).}
#' }
#'
#' @inherit climaemet_9434_wind source
#'
#' @family dataset
#' @family stripes
#'
#' @encoding UTF-8
#'
#' @examples
#' data(climaemet_9434_temp)
NULL

#' Climatogram data for Zaragoza Airport ("9434"), 1981-2010
#'
#' @description
#' Climatological normal data for Zaragoza Airport (1981-2010). This example
#' dataset is used to plot climatograms.
#'
#' @name climaemet_9434_climatogram
#' @docType data
#'
#' @format A [data.frame] with 12 month columns and four rows:
#' \describe{
#'   \item{p_mes_md}{Precipitation (mm).}
#'   \item{tm_max_md}{Maximum temperature (Celsius).}
#'   \item{tm_min_md}{Minimum temperature (Celsius).}
#'   \item{ta_min_md}{Absolute monthly minimum temperature (Celsius).}
#' }
#'
#' @inherit climaemet_9434_wind source
#'
#' @seealso [ggclimat_walter_lieth()], [climatogram_period()],
#' [climatogram_normal()]
#'
#' @family dataset
#' @family climatogram
#'
#' @encoding UTF-8
#'
#' @examples
#' data(climaemet_9434_climatogram)
NULL

#' Municipalities of Spain
#'
#' @description
#' A [tibble][dplyr::tibble] containing all municipalities of Spain as defined
#' by the INE (Instituto Nacional de Estadistica) in January 2025.
#'
#' @name aemet_munic
#'
#' @docType data
#' @format A [tibble][dplyr::tibble] with
#' `r prettyNum(nrow(climaemet::aemet_munic), big.mark=",")` rows and fields:
#' \describe{
#'   \item{municipio}{INE code of the municipality.}
#'   \item{municipio_nombre}{INE name of the municipality.}
#'   \item{cpro}{INE code of the province.}
#'   \item{cpro_nombre}{INE name of the province.}
#'   \item{codauto}{INE code of the autonomous community.}
#'   \item{codauto_nombre}{INE name of the autonomous community.}
#' }
#' @source INE municipality codes by province:
#'   <https://www.ine.es/daco/daco42/codmun/diccionario25.xlsx>.
#' @seealso [aemet_forecast_daily()],
#' [aemet_forecast_hourly()]
#' @family dataset
#' @family forecast
#'
#' @encoding UTF-8
#'
#' @examples
#'
#' data(aemet_munic)
#'
#' aemet_munic
NULL
