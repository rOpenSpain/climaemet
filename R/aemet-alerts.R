#' AEMET meteorological alerts
#'
#' @description
#' `r lifecycle::badge("experimental")` Retrieves current meteorological
#' alerts issued by AEMET.
#'
#' @param ccaa Character vector with names for autonomous communities or `NULL`
#'   to get all autonomous communities.
#' @param lang Language of the results. It can be `"es"` (Spanish) or `"en"`
#'   (English).
#'
#' @inheritParams get_data_aemet
#' @inheritParams aemet_daily
#' @inherit aemet_last_obs return
#'
#' @source
#' <https://www.aemet.es/en/eltiempo/prediccion/avisos> and
#' <https://www.aemet.es/es/eltiempo/prediccion/avisos/ayuda> for API status
#' and alerts reference, including Annex 2 and Annex 3 documentation.
#'
#' @seealso
#' [aemet_alert_zones()] for alert zones. See
#' [mapSpain::esp_codelist] and [mapSpain::esp_dict_region_code()] for
#' autonomous community names.
#'
#' @family aemet_api_data
#'
#' @export
#' @encoding UTF-8
#' @examplesIf aemet_detect_api_key()
#' # Display CCAA names.
#' library(dplyr)
#' aemet_alert_zones() |>
#'   select(NOM_CCAA) |>
#'   distinct()
#'
#' # Base map.
#' cbasemap <- mapSpain::esp_get_ccaa(ccaa = c(
#'   "Galicia", "Asturias", "Cantabria",
#'   "Euskadi"
#' ))
#'
#' # Alerts.
#' alerts_north <- aemet_alerts(
#'   ccaa = c("Galicia", "Asturias", "Cantabria", "Euskadi"),
#'   return_sf = TRUE
#' )
#'
#' # Plot if there are alerts.
#' if (inherits(alerts_north, "sf")) {
#'   library(ggplot2)
#'   library(lubridate)
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
aemet_alerts <- function(
  ccaa = NULL,
  lang = c("es", "en"),
  verbose = FALSE,
  return_sf = FALSE,
  extract_metadata = FALSE,
  progress = TRUE
) {
  # 1. Validate inputs ----
  lang <- rlang::arg_match(lang)
  aemet_hlp_validate_logical(return_sf, "return_sf")
  aemet_hlp_validate_logical(verbose, "verbose")
  aemet_hlp_validate_logical(progress, "progress")

  # 2. Call API ----

  ## Metadata ----
  if (extract_metadata) {
    apidest <- "/api/avisos_cap/ultimoelaborado/area/esp"
    final_result <- get_metadata_aemet(apidest = apidest, verbose = verbose)
    return(final_result)
  }

  ## Normal call ----

  # Extract links using a master table.

  df_links <- aemet_hlp_alerts_master(verbose = verbose)

  if (is.null(df_links)) {
    cli::cli_alert_success("No current alerts.")
    return(NULL)
  }

  # Filter by CCAAs if requested.
  if (!is.null(ccaa)) {
    # Get codauto.
    # Remove the prefix used for Ceuta and Melilla.
    ccaa <- gsub("Ciudad de ", "", ccaa, ignore.case = TRUE)

    ccaa_code <- unique(mapSpain::esp_dict_region_code(
      ccaa,
      destination = "codauto"
    ))

    ccaa_code <- ccaa_code[!is.na(ccaa_code)]
    ccaa_code <- unique(ccaa_code[nchar(ccaa_code) > 1])
    if (length(ccaa_code) < 1) {
      cli::cli_abort("No match found for {.arg ccaa}.")
    }

    # Keep a unique map.
    df_links <- df_links[df_links$codauto %in% ccaa_code, ]
    if (nrow(df_links) == 0) {
      cli::cli_alert_success(
        "No current alerts for the selected {.arg ccaa} values."
      )
      return(NULL)
    }

    df_links <- dplyr::as_tibble(df_links)

    # Order results.
    df_links$sort <- factor(df_links$codauto, levels = ccaa_code)
    df_links <- df_links[order(df_links$sort, df_links$link), ]

    df_links <- df_links[, setdiff(names(df_links), "sort")]
  }

  # Prepare alert downloads.

  # Rename to match the structure used by other functions.
  db_cuts <- df_links

  ln <- seq_len(nrow(db_cuts))

  final_result <- aemet_hlp_fetch_loop(
    ln,
    function(id) {
      this <- db_cuts[id, ]
      aemet_hlp_single_alert(this, lang)
    },
    progress,
    verbose
  )

  # Apply final tweaks.
  final_result <- aemet_hlp_finalize(
    final_result,
    c("AEMET-Meteoalerta zona", "COD_Z")
  )

  # Check spatial output ----
  if (return_sf) {
    # Get zone geometries.
    sf_zones <- aemet_alert_zones(return_sf = TRUE)
    final_result <- dplyr::left_join(final_result, sf_zones, by = "COD_Z")

    final_result <- sf::st_as_sf(final_result)
  } else {
    # Get zone data.
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

  # Relocate columns.
  final_result <- final_result[, vnames]

  final_result
}

# Helpers for alerts.
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

  # Add CCAA names.
  full_zones <- aemet_alert_zones()[, c("COD_CCAA", "NOM_CCAA")]
  full_zones <- dplyr::distinct(full_zones)

  # Add codauto for mapSpain compatibility.
  df <- merge(df, full_zones)

  # Reorder columns.
  df <- df[, c("COD_CCAA", "NOM_CCAA", "codauto")]

  dplyr::as_tibble(df)
}

aemet_hlp_alerts_master <- function(verbose = FALSE) {
  # RSS URL for Spain.

  url_all <- paste0(
    "https://www.aemet.es/documentos_d/eltiempo/prediccion/",
    "avisos/rss/CAP_AFAE_wah_RSS.xml"
  )

  req1 <- aemet_hlp_request(url_all)
  req1 <- httr2::req_error(req1, is_error = function(x) {
    FALSE
  })

  # Perform the request.
  if (verbose) {
    cli::cli_alert_info("Requesting {.url {req1$url}}.")
  }

  response <- httr2::req_perform(req1)

  # Parse the response.
  response <- httr2::resp_body_xml(response)
  response <- xml2::as_list(response)

  # Extract links.
  links <- response$rss$channel
  links <- links[names(links) == "item"]
  links <- unname(unlist(lapply(links, "[", "link")))
  # Keep only XML links.
  links <- links[grepl("xml$", links)]

  # nocov start
  if (length(links) == 0) {
    cli::cli_alert_success(
      "No current alerts as of {.time {format(Sys.time(), usetz = TRUE)}}."
    )

    return(NULL)
  }
  # nocov end

  # Create a data frame with CCAA ids.
  # Get codes from links.
  ccaa_alert <- unlist(lapply(links, function(x) {
    ident <- unlist(strsplit(x, "_AFAZ"))[2]
    substr(ident, 1, 2)
  }))

  df_links <- data.frame(link = links, COD_CCAA = ccaa_alert)

  df_links <- merge(df_links, ccaa_to_aemet())
  df_links <- dplyr::as_tibble(df_links)

  # Rearrange columns.
  df_links <- df_links[, c("COD_CCAA", "NOM_CCAA", "codauto", "link")]

  df_links
}

aemet_hlp_single_alert <- function(this, lang) {
  link <- as.vector(this$link)

  # Perform the request.
  req1 <- aemet_hlp_request(link)

  response <- httr2::req_perform(req1)
  response <- httr2::resp_body_xml(response)
  response <- xml2::as_list(response)

  # Extract information in the requested language.
  info <- response$alert[names(response$alert) == "info"]
  getlang <- unlist(lapply(info, "[", "language"))
  info <- info[grepl(lang, getlang)]$info

  # Extract and parse alert fields.

  lng_parse <- seq_along(info)

  parsed <- lapply(lng_parse, function(x) {
    id_list <- info[x]
    values_list <- unlist(id_list)

    if (length(values_list) == 1) {
      df <- dplyr::tibble(id = as.character(values_list))
      names(df) <- names(id_list)
      return(df)
    }

    if (length(values_list) == 2) {
      name_pos <- grep("name", names(values_list), ignore.case = TRUE)
      df <- dplyr::tibble(id = as.character(values_list[-name_pos]))
      names(df) <- values_list[name_pos]
      return(df)
    }

    # Extract the shapefile later for performance.
    if (names(id_list) == "area") {
      df_area <- dplyr::tibble(
        dsc = as.character(id_list$area$areaDesc),
        id = as.character(id_list$area$geocode$value),
        # Add COD_Z for joins.
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
