% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aemet_api_key.R
\name{aemet_api_key}
\alias{aemet_api_key}
\title{Install an AEMET API Key}
\usage{
aemet_api_key(apikey, overwrite = FALSE, install = FALSE)
}
\arguments{
\item{apikey}{The API key provided to you from the AEMET formatted in quotes.
A key can be acquired at
\url{https://opendata.aemet.es/centrodedescargas/inicio}. You can install
several API Keys as a vector of characters, see \strong{Details}.}

\item{overwrite}{If this is set to \code{TRUE}, it will overwrite an existing
\code{AEMET_API_KEY} that you already have in local machine.}

\item{install}{if \code{TRUE}, will install the key in your local machine for
use in future sessions.  Defaults to \code{FALSE.}}
}
\value{
None
}
\description{
This function will store your AEMET API key on your local machine so it can
be called securely without being stored in your code.

Alternatively, you can install the API Key manually:
\itemize{
\item Run \code{Sys.setenv(AEMET_API_KEY = "Your_Key")}. You would need to run this
command on each session (Similar to \code{install = FALSE}).
\item Write this line on your .Renviron file: \code{AEMET_API_KEY = "Your_Key"}
(same behavior than \code{install = TRUE}). This would store your API key
permanently.
}
}
\details{
You can pass several \code{apikey} values as a vector \code{c(api1, api2)}, in this
case several \code{AEMET_API_KEY} values would be generated. In each subsequent
api call \CRANpkg{climaemet} would choose the API Key with the highest
remaining quota.

This is useful when performing batch queries to avoid API throttling.
}
\note{
To locate your API Key on your local machine, run
\code{rappdirs::user_cache_dir("climaemet", "R")}.
}
\examples{
# Don't run these examples!

if (FALSE) {
  aemet_api_key("111111abc", install = TRUE)

  # You can check it with:
  Sys.getenv("AEMET_API_KEY")
}

if (FALSE) {
  # If you need to overwrite an existing key:
  aemet_api_key("222222abc", overwrite = TRUE, install = TRUE)

  # You can check it with:
  Sys.getenv("AEMET_API_KEY")
}
}
\seealso{
Other aemet_auth: 
\code{\link{aemet_detect_api_key}()}
}
\concept{aemet_auth}
