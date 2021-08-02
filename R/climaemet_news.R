#' @title climaemet_news
#'
#' @description Show the NEWS file of the **climaemet** package.
#'
#' @concept helpers
#'
#' @details (See description)
#'
#' @return Open NEWS from `climaemet`.
#'
#' @export
#'
climaemet_news <- function() {
  file <- file.path(system.file(package = "climaemet"), "NEWS.md")
  file.show(file)
}
