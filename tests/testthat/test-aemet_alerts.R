test_that("Errors", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  expect_snapshot(aemet_alerts("Idonotexist"), error = TRUE)
  expect_snapshot(aemet_alerts(lang = "frr"), error = TRUE)
})


test_that("In no alerts", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  df <- aemet_hlp_alerts_master()

  seehere <- sort(unique(df$aemet))

  # Check if there is any CCAA without alert to perform test

  df_map <- ccaa_to_aemet()
  df_map <- df_map[!df_map$aemet %in% seehere, ]

  skip_if(nrow(df_map) == 0,
    message = "All CCAA with alerts, can't perform test"
  )

  smp <- df_map[1, ]$codauto

  ca <- mapSpain::esp_dict_region_code(smp, "codauto")


  expect_snapshot(aemet_alerts(ca))
})

test_that("In alerts", {
  skip_on_cran()
  skip_if_offline()
  skip_if_not(aemet_detect_api_key(), message = "No API KEY")

  df <- aemet_hlp_alerts_master()

  seehere <- sort(unique(df$aemet))

  # Check if there is any CCAA with alert to perform test

  df_map <- ccaa_to_aemet()
  df_map <- df_map[df_map$aemet %in% seehere, ]

  skip_if(nrow(df_map) == 0,
    message = "All CCAA without alerts, can't perform test"
  )

  smp <- df_map[1, ]$codauto

  ca <- mapSpain::esp_dict_region_code(smp, "codauto")

  expect_message(res <- aemet_alerts(ca, verbose = TRUE))
  expect_s3_class(res, c("sf", "tbl_df", "tbl", "data.frame"), exact = TRUE)

  # Now lang
  res2 <- aemet_alerts(ca, verbose = TRUE, lang = "en")

  expect_identical(res$areaDesc, res2$areaDesc)
  expect_identical(res$effective, res2$effective)

  expect_false(any(res$language == res2$language))
})
