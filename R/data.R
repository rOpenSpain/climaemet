#' Wind conditions for Zaragoza Airport ("9434") period 2000-2020
#'
#'
#' @description
#' Daily observations of wind speed and directions for Zaragoza Airport
#' (2000-2020). This is an example dataset.
#'
#' @concept dataset
#'
#' @name climaemet_9434_wind
#'
#' @docType data
#'
#' @format A tibble with columns:
#'   * **fecha**: Date of observation.
#'   * **dir**: Wind directions (0-360).
#'   * **velmedia**: Avg wind speed (km/h).
#'
#' @source AEMET.
NULL

#' Average annual temperatures for Zaragoza Airport ("9434") period 1950-2020
#'
#'
#' @description
#' Yearly observations of average temperature for Zaragoza Airport
#' (1950-2020). This is an example dataset.
#'
#' @concept dataset
#'
#' @name climaemet_9434_temp
#'
#' @docType data
#'
#' @format A tibble with columns:
#'   * **year**: Year of reference.
#'   * **indicativo**: Identifier of the station.
#'   * **temp**: Avg temperature (Celsius).
#'
#' @source AEMET.
NULL

#' Climatogram data for Zaragoza Airport ("9434") period 1981-2010
#'
#'
#' @description
#' Normal data for Zaragoza Airport (1981-2010). This is an example dataset
#' used to plot climatograms.
#'
#' @concept dataset
#'
#' @name climaemet_9434_climatogram
#'
#' @docType data
#'
#' @format A data.frame with columns 1 to 12 (months) and rows:
#'   * **p_mes_md**: Precipitation (mm).
#'   * **tm_max_md**: Maximum temperature (Celsius).
#'   * **tm_min_md**: Minimum temperature (Celsius).
#'   * **ta_min_md**: Absolute monthly minimum temperature (Celsius).
#'
#' @seealso [ggclimat_walter_lieth()], [climatogram_period()],
#' [climatogram_normal()]
#'
#' @source AEMET.
NULL
