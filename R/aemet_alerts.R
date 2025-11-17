#' AEMET Meteorological warnings
#'
#' @description
#'
#' `r lifecycle::badge("experimental")` Get a database of current meteorological
#' alerts.
#'
#' @family aemet_api_data
#'
#' @param ccaa A vector of names for autonomous communities or `NULL` to get all
#'   the autonomous communities.
#' @inheritParams get_data_aemet
#' @inheritParams aemet_daily
#' @param lang Language of the results. It can be `"es"` (Spanish) or `"en"`
#'   (English).
#'
#' @source
#'
#' <https://www.aemet.es/en/eltiempo/prediccion/avisos>.
#'
#' @return A [`tibble`][tibble::tibble()] or a \CRANpkg{sf} object.
#'
#' @source
#'
#' <https://www.aemet.es/es/eltiempo/prediccion/avisos/ayuda>. See also
#' Annex 2 and Annex 3 docs, linked in this page.
#'
#' @export
#' @seealso
#' [aemet_alert_zones()]. See also [mapSpain::esp_codelist],
#' [mapSpain::esp_dict_region_code()] to get the names of the
#' autonomous communities.
#'
#' @examplesIf aemet_detect_api_key()
#' # Display names of CCAAs
#' library(dplyr)
#' aemet_alert_zones() %>%
#'   select(NOM_CCAA) %>%
#'   distinct()
#'
#' # Base map
#' cbasemap <- mapSpain::esp_get_ccaa(ccaa = c(
#'   "Galicia", "Asturias", "Cantabria",
#'   "Euskadi"
#' ))
#'
#' # Alerts
#' alerts_north <- aemet_alerts(
#'   ccaa = c("Galicia", "Asturias", "Cantabria", "Euskadi"),
#'   return_sf = TRUE
#' )
#'
#' # If any alert
#' if (inherits(alerts_north, "sf")) {
#'   library(ggplot2)
#'   library(lubridate)
#'
#'
#'   alerts_north$day <- date(alerts_north$effective)
#'
#'   ggplot(alerts_north) +
#'     geom_sf(data = cbasemap, fill = "grey60") +
#'     geom_sf(aes(fill = `AEMET-Meteoalerta nivel`)) +
#'     geom_sf(
#'       data = cbasemap, fill = "transparent", color = "black",
#'       linewidth = 0.5
#'     ) +
#'     facet_grid(vars(`AEMET-Meteoalerta fenomeno`), vars(day)) +
#'     scale_fill_manual(values = c(
#'       "amarillo" = "yellow", naranja = "orange",
#'       "rojo" = "red"
#'     ))
#' }
#'
#' @export
aemet_alerts <- function(
  ccaa = NULL,
  lang = c("es", "en"),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs----
  lang <- match.arg(lang)
  stopifnot(is.logical(return_sf))
  stopifnot(is.logical(verbose))
  stopifnot(is.logical(progress))

  # 2. Call API----

  ## Metadata ----
  if (extract_metadata) {
    apidest <- "/api/avisos_cap/ultimoelaborado/area/esp"
    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
    return(final_result)
  }

  ## Normal call ----

  # Extract links using a master table

  df_links <- aemet_hlp_alerts_master(verbose = verbose)

  # nocov start
  if (is.null(df_links)) {
    message("No upcoming alerts")
    return(NULL)
  }
  # nocov end

  # Filter by CCAAs if requested
  if (!is.null(ccaa)) {
    # Get codauto
    # Extra for Ceuta and Melilla
    ccaa <- gsub("Ciudad de ", "", ccaa, ignore.case = TRUE)

    ccaa_code <- unique(mapSpain::esp_dict_region_code(
      ccaa,
      destination = "codauto"
    ))

    ccaa_code <- ccaa_code[!is.na(ccaa_code)]
    ccaa_code <- unique(ccaa_code[nchar(ccaa_code) > 1])
    if (length(ccaa_code) < 1) {
      stop("In ccaa param: No matches")
    }

    # Unique map
    df_links <- df_links[df_links$codauto %in% ccaa_code, ]
    if (nrow(df_links) == 0) {
      message("No upcoming alerts for ccaas selected")
      return(NULL)
    }

    df_links <- dplyr::as_tibble(df_links)

    # Order
    df_links$sort <- factor(df_links$codauto, levels = ccaa_code)
    df_links <- df_links[order(df_links$sort, df_links$link), ]

    df_links <- df_links[, setdiff(names(df_links), "sort")]
  }

  # Done

  # Make calls on loop for progress bar
  # Rename to adapt to other funs
  db_cuts <- df_links
  final_result <- list() # Store results

  ln <- seq_len(nrow(db_cuts))

  # Deactive progressbar if verbose
  if (verbose) {
    progress <- FALSE
  }
  if (!cli::is_dynamic_tty()) {
    progress <- FALSE
  }

  # nolint start
  # nocov start
  if (progress) {
    opts <- options()
    options(
      cli.progress_bar_style = "fillsquares",
      cli.progress_show_after = 3,
      cli.spinner = "clock"
    )

    cli::cli_progress_bar(
      format = paste0(
        "{cli::pb_spin} AEMET API ({cli::pb_current}/{cli::pb_total}) ",
        "| {cli::pb_bar} {cli::pb_percent}  ",
        "| ETA:{cli::pb_eta} [{cli::pb_elapsed}]"
      ),
      total = nrow(db_cuts),
      clear = FALSE
    )
  }
  # nocov end
  # nolint end

  ### API Loop ----
  for (id in ln) {
    this <- db_cuts[id, ]
    if (progress) {
      cli::cli_progress_update()
    } # nocov

    df <- aemet_hlp_single_alert(this, lang)

    final_result <- c(final_result, list(df))
  }

  # nolint start
  # nocov start
  if (progress) {
    cli::cli_progress_done()
    options(
      cli.progress_bar_style = opts$cli.progress_bar_style,
      cli.progress_show_after = opts$cli.progress_show_after,
      cli.spinner = opts$cli.spinner
    )
  }

  # nocov end
  # nolint end

  # Final tweaks
  final_result <- dplyr::bind_rows(final_result)
  final_result <- dplyr::as_tibble(final_result)
  final_result <- dplyr::distinct(final_result)
  final_result <- aemet_hlp_guess(
    final_result,
    c(
      "AEMET-Meteoalerta zona",
      "COD_Z"
    )
  )

  # Check spatial----
  if (return_sf) {
    # Geoms of zones
    sf_zones <- aemet_alert_zones(return_sf = TRUE)
    final_result <- dplyr::left_join(final_result, sf_zones, by = "COD_Z")

    final_result <- sf::st_as_sf(final_result)
  } else {
    # data of zones
    data_zones <- aemet_alert_zones(return_sf = FALSE)
    final_result <- dplyr::left_join(final_result, data_zones, by = "COD_Z")
  }

  vnames <- unique(c(
    "NOM_CCAA",
    "COD_CCAA",
    "NOM_PROV",
    "COD_PROV",
    "NOM_Z",
    "COD_Z",
    names(final_result)
  ))

  # Relocate
  final_result <- final_result[, vnames]

  final_result
}


# Helpers for alerts
ccaa_to_aemet <- function(...) {
  df <- data.frame(
    codauto = c(
      "01",
      "02",
      "03",
      "04",
      "05",
      "06",
      "07",
      "08",
      "09",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19"
    ),
    COD_CCAA = c(
      "61",
      "62",
      "63",
      "64",
      "65",
      "66",
      "67",
      "68",
      "69",
      "77",
      "70",
      "71",
      "72",
      "73",
      "74",
      "75",
      "76",
      "78",
      "79"
    )
  )

  # Add name of ccaa
  full_zones <- aemet_alert_zones()[, c("COD_CCAA", "NOM_CCAA")]
  full_zones <- dplyr::distinct(full_zones)

  # Add codauto for interfacing with mapSpain
  df <- merge(df, full_zones)

  # Re-arrange
  df <- df[, c("COD_CCAA", "NOM_CCAA", "codauto")]

  dplyr::as_tibble(df)
}

aemet_hlp_alerts_master <- function(verbose = FALSE) {
  # RSS url for Spain

  url_all <- paste0(
    "https://www.aemet.es/documentos_d/eltiempo/prediccion/",
    "avisos/rss/CAP_AFAE_wah_RSS.xml"
  )

  req1 <- httr2::request(url_all)
  req1 <- httr2::req_error(req1, is_error = function(x) {
    FALSE
  })

  # Perform request
  if (verbose) {
    message("\nRequesting ", req1$url)
  }

  response <- httr2::req_perform(req1)

  # Parse
  response <- httr2::resp_body_xml(response)
  response <- xml2::as_list(response)

  # Extract links
  links <- response$rss$channel
  links <- links[names(links) == "item"]
  links <- unname(unlist(lapply(links, "[", "link")))
  # Keep only xml links
  links <- links[grepl("xml$", links)]

  # nocov start
  if (length(links) == 0) {
    message("No current alerts as of ", Sys.time())
    return(NULL)
  }
  # nocov end

  # Create df with id of CCAAs
  # Get codes from links
  ccaa_alert <- unlist(lapply(links, function(x) {
    ident <- unlist(strsplit(x, "_AFAZ"))[2]
    substr(ident, 1, 2)
  }))

  df_links <- data.frame(link = links, COD_CCAA = ccaa_alert)

  df_links <- merge(df_links, ccaa_to_aemet())
  df_links <- dplyr::as_tibble(df_links)

  # Rearrange
  df_links <- df_links[, c("COD_CCAA", "NOM_CCAA", "codauto", "link")]

  df_links
}


aemet_hlp_single_alert <- function(this, lang) {
  link <- as.vector(this$link)

  # Perform req
  req1 <- httr2::request(link)

  response <- httr2::req_perform(req1)
  response <- httr2::resp_body_xml(response)
  response <- xml2::as_list(response)

  # Extract info in required language
  info <- response$alert[names(response$alert) == "info"]
  getlang <- unlist(lapply(info, "[", "language"))
  info <- info[grepl(lang, getlang)]$info

  # Extract and parse

  lng_parse <- seq_len(length(info))

  parsed <- lapply(lng_parse, function(x) {
    id_list <- info[x]
    values_list <- unlist(id_list)

    if (length(values_list) == 1) {
      df <- tibble::tibble(id = as.character(values_list))
      names(df) <- names(id_list)
      return(df)
    }

    if (length(values_list) == 2) {
      name_pos <- grep("name", names(values_list), ignore.case = TRUE)
      df <- tibble::tibble(id = as.character(values_list[-name_pos]))
      names(df) <- values_list[name_pos]
      return(df)
    }

    # Area, the shp would be extracted latter for speeding
    if (names(id_list) == "area") {
      df_area <- tibble::tibble(
        dsc = as.character(id_list$area$areaDesc),
        id = as.character(id_list$area$geocode$value),
        # Add COD_Z for merges
        id2 = as.character(id_list$area$geocode$value)
      )
      names(df_area) <- c(
        "areaDesc",
        as.character(id_list$area$geocode$valueName),
        "COD_Z"
      )
      return(df_area)
    }

    NULL # nocov
  })

  parsed <- dplyr::bind_cols(parsed)

  parsed
}
