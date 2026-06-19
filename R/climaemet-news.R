#' Show the latest \CRANpkg{climaemet} news
#'
#' @description
#' Opens the `NEWS` file for \CRANpkg{climaemet}.
#'
#' @returns `NULL`, invisibly. This function is called for its side effect.
#'
#' @concept helpers
#'
#' @export
#' @encoding UTF-8
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
