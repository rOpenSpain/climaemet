library(hexSticker)
library(climaemet)
library(ggplot2)
library(dplyr)

data <- climaemet::climaemet_9434_temp
st <- aemet_stations(return_sf = TRUE) |>
  # Exclude Islands from analysis
  filter(
    !provincia %in%
      c(
        "LAS PALMAS",
        "STA. CRUZ DE TENERIFE"
      )
  )

stripbackground <- ggstripes(
  data,
  plot_title = "Zaragoza Airport",
  plot_type = "background"
) +
  theme_void() +
  labs(
    title = "",
    caption = ""
  ) +
  theme(legend.position = "none")

# Save plot as image on temporary directory
ggplot2::ggsave(
  plot = stripbackground,
  filename = "stripbrackground.jpeg",
  path = tempdir(),
  device = "jpeg",
  scale = 1,
  width = 310,
  height = 210,
  units = "mm",
  dpi = 300,
  limitsize = TRUE
)
# Read stripes plot for background

background <-
  jpeg::readJPEG(file.path(tempdir(), "stripbrackground.jpeg"))

# Map
s <- ggplot(st) +
  ggplot2::annotation_raster(background, -Inf, Inf, -Inf, Inf) +
  geom_sf(
    alpha = 0.7,
    fill = "yellow",
    shape = 21,
    color = "black",
    size = 0.95,
    stroke = 0.1
  ) +
  coord_sf(xlim = c(-27, 12), ylim = c(25, 53)) +
  theme_void()

s


library(hexSticker)


sticker(
  s,
  package = "climaemet",
  filename = "man/figures/logo.png",
  s_width = 3,
  s_height = 3,
  s_x = 0.75,
  h_color = NA,
  p_color = "black",
  p_y = 1.4,
  p_size = 22,
  p_fontface = "bold",
  white_around_sticker = TRUE
)
