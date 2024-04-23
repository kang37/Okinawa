library(dplyr)
library(readr)
library(sf)
library(mapview)

okinawa_raw <- fs::dir_ls(
  "data_raw/AgoopOkinawa/sophia_PDP_PDP_001_20230801_20230831/",
  regexp = "PDP.+.csv$"
) %>%
  head() %>%
  read_csv(col_select = c(
    dailyid, year, month, day, dayofweek, hour, minute,
    latitude, longitude, home_prefcode, home_citycode, accuracy
  )) %>%
  head(10000)

okinawa_gis <- okinawa_raw %>%
  st_as_sf(coords = c("longitude", "latitude")) %>%
  st_set_crs(4326) %>%
  st_transform(6676)

mapview(okinawa_gis)
