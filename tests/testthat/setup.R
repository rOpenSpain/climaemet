# Testing only

withr::local_options(
  list(climaemet_timeout = 300),
  .local_envir = testthat::teardown_env()
)
