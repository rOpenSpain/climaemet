% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aemet_forecast_daily.R,
%   R/aemet_forecast_hourly.R
\name{aemet_forecast_daily}
\alias{aemet_forecast_daily}
\alias{aemet_forecast_hourly}
\title{Forecast database by municipality}
\usage{
aemet_forecast_daily(x, verbose = FALSE, extract_metadata = FALSE)

aemet_forecast_hourly(x, verbose = FALSE, extract_metadata = FALSE)
}
\arguments{
\item{x}{A vector of municipality codes to extract. For convenience,
\CRANpkg{climaemet} provides this data on the dataset \link{aemet_munic}
(see \code{municipio} field) as of January 2020.}

\item{verbose}{Logical \code{TRUE/FALSE}. Provides information about the flow of
information between the client and server.}

\item{extract_metadata}{Logical \code{TRUE/FALSE}. On \code{TRUE} the output is
a \link[tibble:tibble]{tibble} with the description of the fields. See also
\code{\link[=get_metadata_aemet]{get_metadata_aemet()}}.}
}
\value{
A nested \link[tibble:tibble]{tibble}. Forecasted values can be
extracted with \code{\link[=aemet_forecast_tidy]{aemet_forecast_tidy()}}. See also \strong{Details}.
}
\description{
Get a database of daily or hourly weather forecasts for a given municipality.
}
\details{
Forecasts format provided by the AEMET API have a complex structure.
Although \CRANpkg{climaemet} returns a \link[tibble:tibble]{tibble}, each
forecasted value is provided as a nested \link[tibble:tibble]{tibble}.
\code{\link[=aemet_forecast_tidy]{aemet_forecast_tidy()}} helper function can unnest these values an provide a
single unnested \link[tibble:tibble]{tibble} for the requested variable.

If \code{extract_metadata = TRUE} a simple \link[tibble:tibble]{tibble} describing
the value of each field of the forecast is returned.
}
\section{API Key}{
You need to set your API Key globally using \code{\link[=aemet_api_key]{aemet_api_key()}}.
}

\examples{
\dontshow{if (aemet_detect_api_key()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}

# Select a city
data("aemet_munic")
library(dplyr)
munis <- aemet_munic \%>\%
  filter(municipio_nombre \%in\% c(
    "Santiago de Compostela",
    "Lugo"
  )) \%>\%
  pull(municipio)

daily <- aemet_forecast_daily(munis)

# Metadata
meta <- aemet_forecast_daily(munis, extract_metadata = TRUE)
glimpse(meta$campos)

# Vars available
aemet_forecast_vars_available(daily)


# This is nested
daily \%>\%
  select(municipio, fecha, nombre, temperatura)

# Select and unnest
daily_temp <- aemet_forecast_tidy(daily, "temperatura")

# This is not
daily_temp

# Wrangle and plot
daily_temp_end <- daily_temp \%>\%
  select(
    elaborado, fecha, municipio, nombre, temperatura_minima,
    temperatura_maxima
  ) \%>\%
  tidyr::pivot_longer(cols = contains("temperatura"))

# Plot
library(ggplot2)
ggplot(daily_temp_end) +
  geom_line(aes(fecha, value, color = name)) +
  facet_wrap(~nombre, ncol = 1) +
  scale_color_manual(
    values = c("red", "blue"),
    labels = c("max", "min")
  ) +
  scale_x_date(
    labels = scales::label_date_short(),
    breaks = "day"
  ) +
  scale_y_continuous(
    labels = scales::label_comma(suffix = "º")
  ) +
  theme_minimal() +
  labs(
    x = "", y = "",
    color = "",
    title = "Forecast: 7-day temperature",
    subtitle = paste(
      "Forecast produced on",
      format(daily_temp_end$elaborado[1], usetz = TRUE)
    )
  )
\dontshow{\}) # examplesIf}
}
\seealso{
\link{aemet_munic} for municipality codes.

Other aemet_api_data: 
\code{\link{aemet_daily_clim}()},
\code{\link{aemet_extremes_clim}()},
\code{\link{aemet_last_obs}()},
\code{\link{aemet_monthly}},
\code{\link{aemet_normal}},
\code{\link{aemet_stations}()}

Other forecasts: 
\code{\link{aemet_forecast_tidy}()}
}
\concept{aemet_api_data}
\concept{forecasts}
