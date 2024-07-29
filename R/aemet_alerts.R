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
#' @param lang Language of the results. It can be `"es"` (Spanish) or `"en"`
#'   (English).
#'
#' @source
#'
#' <https://www.aemet.es/en/eltiempo/prediccion/avisos>.
#'
#' @return A \CRANpkg{sf} object.
#'
#' @export
#' @seealso
#' [mapSpain::esp_get_ccaa()]. See also [mapSpain::esp_codelist],
#' [mapSpain::esp_dict_region_code()] and **Examples** to get the names of the
#' autonomous communities.
#'
#' @examplesIf aemet_detect_api_key()
#'
#' # Display names of CCAAs
#' unique(mapSpain::esp_codelist$ine.ccaa.name)
#'
#' # Base map
#' cbasemap <- mapSpain::esp_get_ccaa(ccaa = c(
#'   "Galicia",
#'   "Asturias, Principado de"
#' ))
#'
#' # Alerts
#' alerts_north <- aemet_alerts(ccaa = c("Galicia", "Asturias, Principado de"))
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
#'     facet_wrap(vars(day, `AEMET-Meteoalerta fenomeno`)) +
#'     scale_fill_manual(values = c(
#'       "amarillo" = "yellow", naranja = "orange",
#'       "rojo" = "red"
#'     ))
#' }
#'
#' @export
aemet_alerts <- function(ccaa = NULL, lang = c("es", "en"), verbose = FALSE) {
  lang <- match.arg(lang)

  df_links <- aemet_hlp_alerts_master(verbose = verbose)

  # nocov start
  if (is.null(df_links)) {
    message("No upcoming alerts for ccaas selected")
    return(NULL)
  }
  # nocov end


  # Filter by CCAAs if requested
  if (!is.null(ccaa)) {
    # Get AEMET Code
    ccaa_code <- unique(mapSpain::esp_dict_region_code(ccaa,
      destination = "codauto"
    ))

    ccaa_code <- ccaa_code[!is.na(ccaa_code)]
    ccaa_code <- unique(ccaa_code[nchar(ccaa_code) > 1])
    df_map <- ccaa_to_aemet()
    aemet_code <- df_map[df_map$codauto %in% ccaa_code, ]
    if (nrow(aemet_code) == 0) stop("In ccaa param: No matches")


    df_links <- merge(aemet_code[, "aemet"], df_links, by = c("aemet"))
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

  if (verbose) message(nrow(df_links), " alert(s) found")

  # Start loop here
  ntot <- seq_len(nrow(df_links))


  get_results <- lapply(ntot, function(i) {
    iter <- df_links[i, ]

    link <- as.vector(iter$link)


    # Perform req
    req1 <- httr2::request(link)

    response <- httr2::req_perform(req1)
    response <- httr2::resp_body_xml(response)
    response <- xml2::as_list(response)

    # Extract info in required language
    info <- response$alert[names(response$alert) == "info"]
    getlang <- unlist(lapply(info, "[", "language"))
    info <- info[grepl(lang, getlang)]$info
    the_area <- aemet_hlp_area_alert(info)

    # Extra labs
    labs <- info[names(info) != "area"]
    labs_df <- aemet_hlp_labs_alert(labs)

    # Join everything

    the_df <- dplyr::bind_cols(
      iter[, c("codauto", "ccaa_name")],
      sf::st_drop_geometry(the_area),
      labs_df
    )

    geometry <- sf::st_geometry(the_area)
    final_sf <- sf::st_sf(the_df, geometry)

    final_sf <- aemet_hlp_sf_to_tbl(final_sf)

    final_sf
  })

  get_results <- dplyr::bind_rows(get_results)

  get_results <- aemet_hlp_guess(get_results,
    preserve = c(
      "AEMET-Meteoalerta zona",
      "geometry"
    )
  )

  get_results
}




# Helpers for alerts
ccaa_to_aemet <- function(...) {
  df <- data.frame(
    codauto = c(
      "01", "02", "03", "04", "05", "06", "07", "08", "09", "10",
      "11", "12", "13", "14", "15", "16", "17", "18", "19"
    ),
    aemet = c(
      "61", "62", "63", "64", "65", "66", "67", "68", "69", "77",
      "70", "71", "72", "73", "74", "75", "76", "78", "79"
    )
  )



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

  df_links <- data.frame(link = links, aemet = ccaa_alert)

  # Add ine code and name of ccaa
  df_links <- merge(df_links, ccaa_to_aemet())


  nms <- mapSpain::esp_dict_region_code(df_links$codauto, "codauto", "text")
  nms <- mapSpain::esp_dict_translate(nms, lang = "es")
  df_links$ccaa_name <- nms
  df_links <- dplyr::as_tibble(df_links)

  df_links
}


aemet_hlp_area_alert <- function(info) {
  # Geometries
  area <- info$area

  polys <- area[names(area) == "polygon"]
  to_sf <- lapply(polys, function(x) {
    coords <- unlist(strsplit(unlist(x), ",| "))
    coords <- as.double(coords)
    pol <- matrix(coords, ncol = 2, byrow = TRUE)
    pol <- sf::st_polygon(list(pol[, c(2, 1)]))
    geometry <- sf::st_sfc(pol, crs = 4326)

    df <- sf::st_sf(x = 1, geometry)
    df
  })

  to_sf <- dplyr::bind_rows(to_sf)
  if (nrow(to_sf) > 1) {
    geometry <- sf::st_geometry(to_sf)
    geometry <- sf::st_combine(geometry)
  } else {
    geometry <- sf::st_geometry(to_sf)
  }

  # Labels
  labs <- area[names(area) != "polygon"]

  labs_df <- aemet_hlp_labs_alert(labs)

  final_sf <- sf::st_sf(labs_df, geometry)

  final_sf
}

aemet_hlp_labs_alert <- function(labs) {
  labs_n <- names(labs)

  labs_df <- lapply(labs_n, function(x) {
    dat <- labs[[x]]

    if (length(dat) == 1) {
      df <- data.frame(xname = unlist(dat))
      names(df) <- x
      df <- dplyr::as_tibble(df)
      return(df)
    }

    nm <- grepl("Name", names(dat))
    name_is <- unname(unlist(dat[nm])[1])
    value_is <- unname(unlist(dat[!nm])[1])

    df <- data.frame(v = value_is)

    df <- dplyr::as_tibble(df)
    names(df) <- name_is



    df
  })

  labs_df <- dplyr::bind_cols(unique(labs_df))

  labs_df
}
