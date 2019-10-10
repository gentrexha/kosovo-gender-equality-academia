install.packages("pacman")
pacman::p_load(tidyverse, ggiraph, formatR, wbstats, rnaturalearth, rnaturalearthdata, rnaturalearthhires)
# ???
install.packages("rgeos")

# set wd
setwd("C:/Projects/Personal/kosovo-gender-equality-academia")

# load world map
world <- ne_countries(scale = "large", returnclass = "sf")

world %>%
  filter(geounit=='Albania' | geounit=='Andorra' | geounit=='Armenia' 
         | geounit=='Austria' | geounit=='Belarus' | geounit=='Russia' 
         | geounit=='Belgium' | geounit=='Bosnia and Herzegovina' | geounit=='Bulgaria' 
         | geounit=='Croatia' | geounit=='Cyprus' | geounit=='Czechia' 
         | geounit=='Denmark' | geounit=='Estonia' | geounit=='Finland' 
         | geounit=='France' | geounit=='Germany' | geounit=='Greece' 
         | geounit=='Hungary' | geounit=='Iceland' | geounit=='Ireland' 
         | geounit=='Italy' | geounit=='Latvia' | geounit=='Liechtenstein' 
         | geounit=='Lithuania' | geounit=='Luxembourg' | geounit=='Malta' 
         | geounit=='Moldova' | geounit=='Monaco' | geounit=='Kosovo' 
         | geounit=='Montenegro' | geounit=='Macedonia' | geounit=='Norway' 
         | geounit=='Poland' | geounit=='Portugal' | geounit=='Romania' 
         | geounit=='San Marino' | geounit=='Republic of Serbia' | geounit=='Slovakia' 
         | geounit=='Slovenia' | geounit=='Spain' | geounit=='Sweden' 
         | geounit=='Switzerland' | geounit=='Turkey' | geounit=='Ukraine' 
         | geounit=='United Kingdom' | geounit=='Italy' | geounit=='Netherlands') -> europe

europe %>%
  rename(country=geounit) -> europe

# match the country names with the WB data set
europe$country[7] <- "Czech Republic"
europe$country[35] <- "Serbia"
europe$country[25] <- "Slovak Republic"
europe$country[16] <- "North Macedonia"
europe$country[6] <- "Russian Federation"

wb_data <- wb(country = c("ALB", "AND", "ARM", "AUT", "BLR", "RUS", "BEL", "BIH", "BGR", "HRV", "CYP", "CZE", "DNK", "EST", "FIN", "FRA", "DEU", "GRC", "HUN", "ISL", "IRL", "ITA", "LVA", "LIE", "LTU", "LUX", "MLT", "MDA", "MCO", "XKX", "MNE", "MKD", "NOR", "POL", "PRT", "ROU", "SMR", "SRB", "SVK", "SVN", "ESP", "SWE", "CHE", "TUR", "UKR", "GBR", "NLD"), 
              indicator = c("SE.TER.ENRR.FE"), 
              startdate = 2018, enddate = 2018, return_wide = TRUE)

europe <- merge(europe, wb_data, by ="country", all = TRUE)

# insert custom data for Kosovo


# define custom theme

# plot
p <- ggplot(europe) +
  geom_sf_interactive(aes(fill = europe$SP.POP.GROW,
                          tooltip = country),
                      color = '#ffffff',
                      size = 0.10) +
  #scale_fill_viridis('%', option = "E", direction = -1)+
  coord_sf(xlim = c(40, -25), ylim = c(34, 72), expand = FALSE)+
  labs(
    title = 'Population Growth (Annual %)',
    subtitle = "",
    caption = "Source: World Bank"
  ) +
  theme_kv()+
  facet_wrap(~date)+
  theme(text = element_text(size = 7),
        plot.title = element_text(size = 9, 
                                  hjust = 0, 
                                  color = "#6E6F73"), 
        plot.subtitle = element_text(size = 6, hjust = 0, color = "#6E6F73", 
                                     margin = margin(b = -0.1, 
                                                     t = -0.1, 
                                                     l = 2, 
                                                     unit = "cm"), 
                                     debug = F),
        legend.title = element_text(size = 8),
        axis.ticks = element_blank(), 
        legend.direction = "vertical", 
        legend.position = "right",
        legend.box = "horizontal",
        plot.margin = margin(0.5, 0.5, 0.5, 0.5, 'cm'),
        legend.key.height = unit(1, "cm"), 
        legend.key.width = unit(0.2, "cm"),
        plot.caption = element_text(size = 6, 
                                    hjust = 0, 
                                    margin = margin(t = 0.0, 
                                                    b = 0, 
                                                    unit = "cm"), 
                                    color = "#6E6F73")
  )