# Testing only

test_env <- testthat::teardown_env()

withr::local_options(
  list(climaemet_timeout = 300),
  .local_envir = test_env
)

withr::local_pdf(
  withr::local_tempfile(fileext = ".pdf", .local_envir = test_env),
  .local_envir = test_env
)
