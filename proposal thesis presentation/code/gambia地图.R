
library(maps)
# map(regions="Gambia",fill=TRUE,col="gray")
library(mapdata)
# gambia
map(database="worldHires",regions="Gambia",fill=TRUE,col="lightgray")
# Cameroon 

countries <- c("Gabon","Congo","Equatorial Guinea","Malabo","Nigeria","Cameroon")
map(database="worldHires",regions=countries, add = FALSE,
	xlim = c(7.5,16), ylim = c(1,8),fill=TRUE,col="white")
map.axes()


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



library(ggmap)
library(magrittr)

Gambia <- c(left = -16.7, bottom = 13, right = -13.5, top = 13.5)

cairo_pdf(file="gambia_map.pdf",width = 6,height = 6,pointsize=12,family="STKaiti")
get_map(Gambia, zoom = 8) %>% ggmap()+theme(axis.text=element_text(size=12,family="Helvetica",face="plain"))+labs(x = "经度", y = "纬度")
dev.off()

pdf(file="gambia_map.pdf",width = 6,height = 6,pointsize=12)
showtext.begin()
par(family="Kaiti")	
get_map(Gambia, zoom = 8) %>% ggmap()+theme(axis.text=element_text(size=12,face="plain"))+labs(x = "经度", y = "纬度")
showtext.end()
dev.off()

data(gambia,package="geoR")
village <- unique(gambia[,1:2])
dim(unique(gambia[,1:2]))

bbox <- c(-17,  13,  -13.5,14)
map <- get_openstreetmap(bbox = bbox, scale = 475000,format ="pdf")
p <- ggmap(map)








  
library(rworldmap)
library(rworldxtra)
library(maps)
library(maptools)
library(sp)
library(mapdata)

gambia.borders <- readRDS("data/gambia.borders.RDS")
class(gambia.borders)
str(gambia.borders)
head(gambia.borders)

data(gambia,package = "geoR")

library(ggplot2)
ggplot(gambia.borders/1000,aes(x,y)) + 
  geom_point(size=.2)+ 
  geom_point(data=gambia/1000,pch=16,aes(x,y),colour="red")+
  scale_y_continuous(name = "北-南（千米）")+
  scale_x_continuous(name = "西-东（千米）")




