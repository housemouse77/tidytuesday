
# LOAD LIBRARIES ------------------------------------------------------------------------------
library(tidyverse)
library(dplyr)
library(ggplot2)
library(usmap)
library(ggthemes)
library(gridExtra)
library(grid)
library(ggpubr)

# Install "scales" package if required - scale functions for visualisation
if (!require(scales)) {
  install.packages("scales")
}
library(scales)

# DATA ----------------------------------------------------------------------------------------
data_raw <- read.csv("national_parks.csv", stringsAsFactors = FALSE)
data_raw$year = as.numeric(data_raw$year)

# TIDY DATA -----------------------------------------------------------------------------------
data_year <- data_raw %>%
  janitor::clean_names() %>%
  filter(year != "Total") %>%
  mutate(data_year = as.numeric(year),
         date = lubridate::ymd(paste(year, 1, 1, sep = "-"))) %>%
  select(year, date, gnis_id:visitors)


data_summary <- data_year %>%
  filter(unit_type == "National Park") %>% #only national parks
  filter(state!="AK") %>% #filter out non continuous states, DC and a parkway 
  filter(state!="HI") %>%
  filter(region!="NT") %>%
  filter(region!="NC") %>%
  group_by(region, year) %>%
  summarise(total_visitors_mil = sum(visitors)/10^6)

g <- ggplot(data_summary, aes(x = year, y = total_visitors_mil)) +
  geom_area(aes(y=total_visitors_mil, fill=region))
g
#AK = Alaska IM = Intermountain MW = midwest NC = NAtional Capital
#NE = North East PW = Pacific West SE = SOuth East NT = national parkway
g <- g +
  geom_area(stat = "identity", fill = "#396D39", alpha = 0.4) +
  scale_x_continuous(breaks = seq(1910, 2010, 50)) +
  scale_y_continuous(breaks = seq(0, 500, 20),
                     labels = scales::unit_format(unit = "M")) +
  labs(title = "U.S. national parks visitors (continental states, excl. DC)",
       subtitle = "Annual recreational visits since 1904",
       x = "", y = "") + theme_classic()
g


library(maps)
library(mapproj)
us_states <- map_data("state")

us_states$reg = ifelse(us_states$region == "alaska", "AK",
                  ifelse(us_states$region == "arizona", "IM",
                    ifelse(us_states$region == "colorado", "IM",
                     ifelse(us_states$region == "montana", "IM",
                      ifelse(us_states$region == "new mexico", "IM",
                       ifelse(us_states$region == "utah", "IM",
                        ifelse(us_states$region == "wyoming", "IM",
                          ifelse(us_states$region == "texas", "IM",
                            ifelse(us_states$region == "oklahoma", "IM",
                             ifelse(us_states$region == "california", "PW",
                              ifelse(us_states$region == "nevada", "PW",
                               ifelse(us_states$region == "oregon", "PW",
                                 ifelse(us_states$region == "washington", "PW",
                                  ifelse(us_states$region == "hawaii", "PW",
                                    ifelse(us_states$region == "idaho", "PW",
                                     ifelse(us_states$region == "florida", "SE",
                                      ifelse(us_states$region == "georgia", "SE",
                                       ifelse(us_states$region == "north carolina", "SE",
                                         ifelse(us_states$region == "south carolina", "SE",
                                           ifelse(us_states$region == "alabama", "SE",
                                            ifelse(us_states$region == "kentucky", "SE",
                                             ifelse(us_states$region == "mississippi", "SE",
                                               ifelse(us_states$region == "tennessee", "SE",
                                                ifelse(us_states$region == "louisiana", "SE",
ifelse(us_states$region == "connecticut", "NE",
ifelse(us_states$region == "new hampshire", "NE",
ifelse(us_states$region == "rhode island", "NE",
ifelse(us_states$region == "vermont", "NE",
ifelse(us_states$region == "new jersey", "NE",
ifelse(us_states$region == "new york", "NE",
ifelse(us_states$region == "pennsylvania", "NE",
ifelse(us_states$region == "delaware", "NE",
ifelse(us_states$region == "maryland", "NE",
ifelse(us_states$region == "virginia", "NE",
ifelse(us_states$region == "west virginia", "NE",
ifelse(us_states$region == "massachusetts", "NE",
ifelse(us_states$region == "maine", "NE", "Other")))))))))))))))))))))))))))))))))))))

p <- ggplot(data = us_states,
            mapping = aes(x = long, y = lat,
                          group = group, fill = reg))

p<- p + geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  guides(fill = FALSE)
p

grid.arrange(g, p, ncol=1)
