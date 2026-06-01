#' Show the latest news of \CRANpkg{climaemet}
#'
#' @description
#' Open the `NEWS` file of the \CRANpkg{climaemet} package.
#'
#' @keywords internal
#'
#' @family helpers
#' @return Nothing, this function is called by its side effects.
#'
#' @examples
#' \dontrun{
#' climaemet_news()
#' }
#'
#' @export
#' @encoding UTF-8
#'
climaemet_news <- function() {
  # nocov start
  file <- file.path(system.file(package = "climaemet"), "NEWS.md")
  file.show(file)
  # nocov end
}
