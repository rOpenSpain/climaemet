% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aemet_alerts.R
\name{aemet_alerts}
\alias{aemet_alerts}
\title{AEMET Meteorological warnings}
\source{
\url{https://www.aemet.es/en/eltiempo/prediccion/avisos}.

\url{https://www.aemet.es/es/eltiempo/prediccion/avisos/ayuda}. See also
Annex 2 and Annex 3 docs, linked in this page.
}
\usage{
aemet_alerts(
  ccaa = NULL,
  lang = c("es", "en"),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
)
}
\arguments{
\item{ccaa}{A vector of names for autonomous communities or \code{NULL} to get all
the autonomous communities.}

\item{lang}{Language of the results. It can be \code{"es"} (Spanish) or \code{"en"}
(English).}

\item{verbose}{Logical \code{TRUE/FALSE}. Provides information about the flow of
information between the client and server.}

\item{return_sf}{Logical \code{TRUE} or \code{FALSE}.
Should the function return an \code{\link[sf:sf]{sf}} spatial object? If \code{FALSE}
(the default value) it returns a \code{\link[tibble:tibble]{tibble}}. Note that
you need to have the \CRANpkg{sf} package installed.}

\item{extract_metadata}{Logical \code{TRUE/FALSE}. On \code{TRUE} the output is
a \code{\link[tibble:tibble]{tibble}} with the description of the fields. See also
\code{\link[=get_metadata_aemet]{get_metadata_aemet()}}.}

\item{progress}{Logical, display a \code{\link[cli:cli_progress_bar]{cli::cli_progress_bar()}} object. If
\code{verbose = TRUE} won't be displayed.}
}
\value{
A \code{\link[tibble:tibble]{tibble}} or a \CRANpkg{sf} object.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}} Get a database of current meteorological
alerts.
}
\examples{
\dontshow{if (aemet_detect_api_key()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# Display names of CCAAs
library(dplyr)
aemet_alert_zones() \%>\%
  select(NOM_CCAA) \%>\%
  distinct()

# Base map
cbasemap <- mapSpain::esp_get_ccaa(ccaa = c(
  "Galicia", "Asturias", "Cantabria",
  "Euskadi"
))

# Alerts
alerts_north <- aemet_alerts(
  ccaa = c("Galicia", "Asturias", "Cantabria", "Euskadi"),
  return_sf = TRUE
)

# If any alert
if (inherits(alerts_north, "sf")) {
  library(ggplot2)
  library(lubridate)


  alerts_north$day <- date(alerts_north$effective)

  ggplot(alerts_north) +
    geom_sf(data = cbasemap, fill = "grey60") +
    geom_sf(aes(fill = `AEMET-Meteoalerta nivel`)) +
    geom_sf(
      data = cbasemap, fill = "transparent", color = "black",
      linewidth = 0.5
    ) +
    facet_grid(vars(`AEMET-Meteoalerta fenomeno`), vars(day)) +
    scale_fill_manual(values = c(
      "amarillo" = "yellow", naranja = "orange",
      "rojo" = "red"
    ))
}
\dontshow{\}) # examplesIf}
}
\seealso{
\code{\link[=aemet_alert_zones]{aemet_alert_zones()}}. See also \link[mapSpain:esp_codelist]{mapSpain::esp_codelist},
\code{\link[mapSpain:esp_dict]{mapSpain::esp_dict_region_code()}} to get the names of the
autonomous communities.

Other aemet_api_data: 
\code{\link{aemet_alert_zones}()},
\code{\link{aemet_beaches}()},
\code{\link{aemet_daily_clim}()},
\code{\link{aemet_extremes_clim}()},
\code{\link{aemet_forecast_beaches}()},
\code{\link{aemet_forecast_daily}()},
\code{\link{aemet_forecast_fires}()},
\code{\link{aemet_last_obs}()},
\code{\link{aemet_monthly}},
\code{\link{aemet_normal}},
\code{\link{aemet_stations}()}
}
\concept{aemet_api_data}
