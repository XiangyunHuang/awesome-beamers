
library(maps)
library(mapdata)
library(ggplot2)

ga <- ggplot2::map_data('worldHires', 'gambia')
class(ga)

ggplot(ga, aes(x = long, y = lat, group = group)) +
  geom_polygon()
  
library(ggfortify)
ga <-  map('worldHires', 'gambia', plot = FALSE, fill = TRUE) 
autoplot(ga) 
  
################  
p <- autoplot(ga, geom = 'polygon', fill = 'subregion') + 
  theme(legend.position="none")
p

cities <- get('world.cities')
cities <- cities[cities$country.etc == 'Gambia', ]
head(cities)

p + geom_point(data = cities, aes(x = long, y = lat),
               colour = 'blue', size = 0.1)
			   
			   
library(sp)
df <- data.frame(long = c(139.691704, 135.519711),
                 lat = c(35.689521, 34.686316),
                 label = c('Tokyo', 'Osaka'),
                 population = c(1335, 886))
coordinates(df) <- ~ long + lat
class(df)


library(ggmap)
bbox <- c(130.0, 30.0, 145.0, 45.0)
map <- get_openstreetmap(bbox = bbox, scale = 475000)
p <- ggmap(map)
autoplot(df, p = p, colour = 'red', size = 'population') + 
  scale_size_area() +
  theme(legend.justification = c(1, 0), legend.position = c(1, 0))

##
library(ggmap)
bbox <- c(-17,  13,  -13.5,14)
map <- get_openstreetmap(bbox = bbox, scale = 475000)
p <- ggmap(map)











  