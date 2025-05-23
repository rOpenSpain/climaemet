% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aemet_forecast_fires.R
\name{aemet_forecast_fires}
\alias{aemet_forecast_fires}
\title{AEMET fires forecast}
\source{
\url{https://www.aemet.es/en/eltiempo/prediccion/incendios}.
}
\usage{
aemet_forecast_fires(
  area = c("p", "c"),
  verbose = FALSE,
  extract_metadata = FALSE
)
}
\arguments{
\item{area}{The area, being:
\itemize{
\item \code{"p"} for Mainland Spain and Balearic Islands.
\item \code{"c"} for Canary Islands.
}}

\item{verbose}{Logical \code{TRUE/FALSE}. Provides information about the flow of
information between the client and server.}

\item{extract_metadata}{Logical \code{TRUE/FALSE}. On \code{TRUE} the output is
a \code{\link[tibble:tibble]{tibble}} with the description of the fields. See also
\code{\link[=get_metadata_aemet]{get_metadata_aemet()}}.}
}
\value{
A \code{\link[tibble:tibble]{tibble}} or a \code{\link[terra:rast]{SpatRaster}}
object.
}
\description{
Get a \code{\link[terra:rast]{SpatRaster}} as provided by \CRANpkg{terra} with the
daily meteorological risk level for wildfires.
}
\details{
The \code{SpatRaster} provides 5 (\code{\link[=factor]{factor()}})levels with the following meaning:
\itemize{
\item \code{"1"}: Low risk.
\item \code{"2"}: Moderate risk.
\item \code{"3"}: High risk.
\item \code{"4"}: Very high risk.
\item \code{"5"}: Extreme risk.
}

The resulting object has several layers, each one representing the forecast
for the upcoming 7 days. It also has additional attributes provided by the
\CRANpkg{terra} package, such as \code{\link[terra:time]{terra::time()}} and \code{\link[terra:colors]{terra::coltab()}}.
}
\examples{
\dontshow{if (aemet_detect_api_key()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
aemet_forecast_fires(extract_metadata = TRUE)

# Extract alerts
alerts <- aemet_forecast_fires()

alerts

# Nice plotting with terra
library(terra)
plot(alerts, all_levels = TRUE)

# Zoom in an area
cyl <- mapSpain::esp_get_ccaa("Castilla y Leon", epsg = 4326)

# SpatVector
cyl <- vect(cyl)

fires_cyl <- crop(alerts, cyl)
fires_cyl <- crop(alerts, cyl)
title <- names(fires_cyl)[1]

plot(fires_cyl[[1]], main = title, all_levels = TRUE)
plot(cyl, add = TRUE)
\dontshow{\}) # examplesIf}
}
\seealso{
Other aemet_api_data: 
\code{\link{aemet_alert_zones}()},
\code{\link{aemet_alerts}()},
\code{\link{aemet_beaches}()},
\code{\link{aemet_daily_clim}()},
\code{\link{aemet_extremes_clim}()},
\code{\link{aemet_forecast_beaches}()},
\code{\link{aemet_forecast_daily}()},
\code{\link{aemet_last_obs}()},
\code{\link{aemet_monthly}},
\code{\link{aemet_normal}},
\code{\link{aemet_stations}()}

Other forecasts: 
\code{\link{aemet_forecast_beaches}()},
\code{\link{aemet_forecast_daily}()},
\code{\link{aemet_forecast_tidy}()}
}
\concept{aemet_api_data}
\concept{forecasts}
