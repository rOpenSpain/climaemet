#' Display a message on startup
#'
#' @param libname,pkgname libname,pkgname
#'
#' @noRd
.onAttach <- function(libname, pkgname) {
  apikey <- aemet_detect_api_key()

  msg <- paste0(
    "\nWelcome to climaemet (", packageVersion("climaemet"), ")",
    "\nNote that since climaemet (>=1.0.0) the results are provided ",
    "on tibble format. Run `climaemet_news()` to see the changelog.",
    "\nIf you experience any problem open an issue on ",
    "https://github.com/rOpenSpain/climaemet/issues\n"
  )

  if (!apikey) {
    msg <- paste0(
      msg, "\n\nCheck aemet_api_key() to see how you can ",
      "set you AEMET API Key\n"
    )
    
    packageStartupMessage(msg)
  } 
}
