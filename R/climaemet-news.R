#' Show the latest news of \CRANpkg{climaemet}
#'
#' @description
#' Open the `NEWS` file of the \CRANpkg{climaemet} package.
#'
#' @family helpers
#' @keywords internal
#'
#' @return Nothing, this function is called by its side effects.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' climaemet_news()
#' }
#'
climaemet_news <- function() {
  # nocov start
  file <- file.path(system.file(package = "climaemet"), "NEWS.md")
  file.show(file)
  # nocov end
}
