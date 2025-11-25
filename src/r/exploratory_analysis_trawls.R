#### Imports ####
library(here) # For robust file paths

library(tidyverse) # Data wrangling and visualization
library(patchwork) # Arranging plots easily

# Making maps
library(sf)
library(ggsflabel)
library(rnaturalearth)
library(marmap)
library(suncalc)

#### Loading data ####
root <- here()

## ABRAÇOS data
# Biological data (trawl samples, identified and measured)
biodata_A1 <- read_delim(file.path(root, "data/raw/catch-data/abracos/Demersal_Deep_Pelagic_Biological_Data_Abracos1.csv"), delim = ";", escape_double = FALSE, trim_ws = TRUE, col_types = cols(Reg = col_character()))
biodata_A2 <- read_delim(file.path(root, "data/raw/catch-data/abracos/Demersal_Deep_Pelagic_Biological_Data_Abracos2.csv"), delim = ";", escape_double = FALSE, trim_ws = TRUE, col_types = cols(Reg = col_character()))
biodata <- biodata_A1 |> bind_rows(biodata_A2)

# Fishing operations
stations_A1 <- read_delim(file.path(root, "data/raw/catch-data/abracos/Demersal_Deep_Pelagic_Survey_Station_Abracos1.csv"), delim = ";", escape_double = FALSE, trim_ws = TRUE, col_types = cols(Station = col_character()))
stations_A2 <- read_delim(file.path(root, "data/raw/catch-data/abracos/Demersal_Deep_Pelagic_Survey_Station_Abracos2.csv"), delim = ";", escape_double = FALSE, trim_ws = TRUE, col_types = cols(Station = col_character()))
stations <- stations_A1 |> bind_rows(stations_A2)

# Species list
species <- read_delim(file.path(root, "data/raw/catch-data/abracos/Demersal_Deep_Pelagic_Species_List_Abracos.csv"), delim = ";", escape_double = FALSE, trim_ws = TRUE)

## Map data
countries <- ne_countries(country="brazil", scale="large") |> st_set_crs(value=4326)

#### Pre-processing ####
# DateTimes (UTC tz assumed)
stations <- stations |> mutate(DateFull_mn = dmy_hm(DateFull_mn))
biodata <- biodata |> mutate(DateFull_mn = dmy_hm(DateFull_mn))

# Night times
stations <- stations |> 
  rowwise() |> 
  mutate(Sun_Altitude_Rad = getSunlightPosition(DateFull_mn, Latitude, Longitude, keep="altitude")$altitude) |>  # UTC assumed again
  ungroup() |> 
  mutate(
    Sun_Altitude_Deg = (180*Sun_Altitude_Rad/pi),
    Is_Night = Sun_Altitude_Deg < -18
  )
  
biodata <- biodata |> 
  left_join(stations |> distinct(Operation_Code, Is_Night),
            by = "Operation_Code")

# Positions 
stations <- stations |> st_as_sf(coords=c("Longitude", "Latitude"), crs=4326)
biodata <- biodata |> st_as_sf(coords=c("Longitude", "Latitude"), crs=4326)

bbox <- st_bbox(stations)

# Isobaths
bathy <- getNOAA.bathy(
  lon1 = bbox["xmin"] - 1,
  lon2 = bbox["xmax"] + 1,
  lat1 = bbox["ymin"] - 1,
  lat2 = bbox["ymax"] + 1,
  resolution = 1
)
bathy_df <- fortify.bathy(bathy)

### Plots ####

save_path <- "reports/figures/exploratory-analysis/"

# Map sampling sites
stations |> 
  ggplot() +
  # Bathymetry
  geom_contour(data=bathy_df, aes(x=x, y=y, z=z), breaks=c(-200, -1000), color="black", linewidth=0.3) +
  # Stations
  geom_sf(aes(shape=Operation), size=2, alpha=0.7) +
  # Coast
  geom_sf(data=countries) +
  facet_wrap(~Id_Survey) +
  coord_sf(xlim=c(bbox["xmin"], bbox["xmax"]), ylim=c(bbox["ymin"], bbox["ymax"])) +
  theme_minimal()
ggsave(
  file.path(save_path, "trawling_stations_all_abracos.png"),
  width=11,
  height=8.5
)

# Map catch per minimal compartment
biodata|> 
  summarize(
    N_Samples = n(),
    .by=c(Id_Survey, Id_Station, Operation, Fishing_Depth_Lower, Compartment, geometry)
  ) |> 
  ggplot() +
  # Bathymetry
  geom_contour(data=bathy_df, aes(x=x, y=y, z=z), breaks=c(-100, -1000), color="black", linewidth=0.3) +
  # Stations
  geom_sf(aes(size=N_Samples, shape=Operation, color=Compartment), alpha=0.7) +
  # Coast
  geom_sf(data=countries) +
  # Plot params
  facet_grid(Id_Survey~Compartment) +
  coord_sf(xlim=c(bbox["xmin"], bbox["xmax"]), ylim=c(bbox["ymin"], bbox["ymax"])) +
  scale_size_binned(breaks=c(10, 100, 500, 1000)) +
  theme_minimal()
ggsave(
  file.path(save_path, "trawling_stations_all_by_compartment_abracos.png"),
  width=16,
  height=8.5
)

# Only relevant stations
biodata |> 
  filter(
    Bottom_Depth > 1000, # Migration possible
    Is_Night,
    Fishing_Depth_Lower < 200
  ) |> 
  summarize(
    N_Samples = n(),
    .by=c(Id_Survey, Id_Station, Operation, Fishing_Depth_Lower, Compartment, geometry)
  ) |> 
  ggplot() +
  # Bathymetry
  geom_contour(data=bathy_df, aes(x=x, y=y, z=z), breaks=c(-100, -1000), color="black", linewidth=0.3) +
  # Stations
  geom_sf(aes(size=N_Samples, shape=Operation, color=Compartment), alpha=0.7) +
  geom_sf_text_repel(aes(label = Id_Station)) +
  # Coast
  geom_sf(data=countries) +
  # Plot params
  facet_grid(Id_Survey~Compartment) +
  coord_sf(xlim=c(bbox["xmin"], bbox["xmax"]), ylim=c(bbox["ymin"], bbox["ymax"])) +
  scale_size_binned(breaks=c(10, 100, 500, 1000)) +
  theme_minimal()
ggsave(
  file.path(save_path, "trawling_stations_valid_by_compartment_abracos.png"),
  width=16,
  height=8.5
)

# Size distributions
# Select taxa by checking abundances

taxo_level <- "Compartment"

taxa_ranking_plot <- function(taxo_level, fill_with="Compartment", pct_thresh=100){
  
  x = unique(biodata[[fill_with]])
  colors <- scale_fill_hue()$palette(length(x))
  values <- setNames(colors, x)
  
  biodata |> 
    filter(
      Bottom_Depth > 1000, 
      Is_Night,
      Fishing_Depth_Lower < 200
    ) |> 
    st_drop_geometry() |> 
    mutate(
      Taxa = .data[[taxo_level]],
      Fill_with = .data[[fill_with]]
    ) |> 
    summarize(
      N_samples = n(),
      .by = c(Id_Survey, Compartment, Taxa, Fill_with)
    ) |> 
    arrange(Id_Survey, desc(N_samples)) |>
    group_by(Id_Survey) |> 
    mutate(Pct = 100 * N_samples / sum(N_samples)) |> 
    mutate(Cumulated = cumsum(Pct)) |> 
    ungroup() |> 
    filter(Cumulated < pct_thresh) |> 
    ggplot(aes(x=fct_reorder(Taxa, N_samples), y=N_samples, fill=Fill_with)) +
    geom_bar(stat="identity") +
    facet_wrap(~Id_Survey) +
    coord_flip() +
    labs(x="", title=taxo_level) +
    scale_fill_manual(values=values,  drop = FALSE) +
    theme_minimal() +
    theme(legend.position="none")
}

p1 <- taxa_ranking_plot("Compartment")
p2 <- taxa_ranking_plot("Phylum")
p3 <- taxa_ranking_plot("Class")
p4 <- taxa_ranking_plot("Order", pct_thresh=90)
p5 <- taxa_ranking_plot("Family", pct_thresh=90)

(p1 / p2 / p3) | (p4 / p5)

ggsave(
  file.path(save_path, "trawling_abundances_abracos_by_taxolevel.png"),
  width=16,
  height=8.5
)

# Size distributions for families of mesopelagic fishes

plot_size_dists <- function(taxo_level="Family", taxo_id="Myctophidae", facet_scale="free_y", binwidth=1){
  biodata |> 
    st_drop_geometry() |> 
    mutate(
      Taxa = .data[[taxo_level]]
    ) |> 
    filter(
      Bottom_Depth > 1000,
      Is_Night,
      Fishing_Depth_Lower < 200,
      Taxa == taxo_id,
    ) |> 
    pivot_longer(cols=c(TL, FL, SL, ML, CL, DL),
                 names_to="Measurement") |> 
    ggplot(aes(x=value, fill=Measurement)) +
    geom_histogram(binwidth=binwidth, alpha=0.4, position="identity", na.rm = FALSE) +
    facet_wrap(~ Id_Station, scale=facet_scale) +
    theme_minimal() +
    labs(title=taxo_id)
}

p_mycto <- plot_size_dists("Family", "Myctophidae", binwidth=0.5, facet_scale="fixed")
p_mycto
p_sterno <- plot_size_dists("Family", "Sternoptychidae", binwidth=0.5, facet_scale="fixed")
p_sterno
p_stomii <- plot_size_dists("Family", "Stomiidae", binwidth=0.5, facet_scale="fixed")
p_stomii

# Size distributions of Euphausiidae
p_euphau <- plot_size_dists("Family", "Euphausiidae")
#p_euphau # No size measurements...

# For the only abundant family of pelagic molluscs
p_eno <- plot_size_dists("Family", "Enoploteuthidae", binwidth=0.5) 
p_eno

biodata |> 
  filter(Family=="Euphausiidae") |> 
  ggplot(aes(x=TL, y=TW, color=Genus)) +
  geom_point(alpha=0.7) +
  scale_color_discrete()
