library(maps)
library(mapdata)
## Gambia
map(database="worldHires",regions="Gambia",fill=TRUE,col="lightgray")
## Cameroon 
# map(database="worldHires",regions="Cameroon",fill=TRUE,col="lightgray")

library(ggplot2)
ga <- map_data('worldHires', 'gambia')
ggplot(ga, aes(x = long, y = lat, group = group)) +
  geom_polygon()
  
library(ggfortify)
ga <-  map('worldHires', 'gambia', plot = FALSE, fill = TRUE,col="lightgray") 
autoplot(ga) 
##############################################################################

data(gambia,package="geoR")
head(gambia)

Child_Num <-  cbind(unique(gambia[,1:2]), as.data.frame(table(gambia$x))[,2])
colnames(Child_Num) <- c("x","y","num")

cairo_pdf(file="gambia01.pdf",width = 8,height = 7)
with(Child_Num,{
	 par(mar = c(4, 4, .5, .5),family="Times New Roman")
	 plot(x/1000,y/1000,xlab="",ylab="",frame.plot=FALSE,
		  pch=16,lwd=1.5,cex=num/25,
		  col= heat.colors(20,alpha= .5)[1] )
		  # (num-min(num))/(max(num)-min(num))
	 # plot(x/1000,y/1000,xlab="",ylab="",frame.plot=FALSE,
		  # pch=1,lwd=1.5,cex=num/25,col= "gray")
	 par(family="SimSun")	  
	 title(xlab="横坐标（千米）",ylab="纵坐标（千米）")	  
})
dev.off()

# terrain.colors
# topo.colors(n, alpha = 1)
# cm.colors(n, alpha = 1)

library(sp)

coordinates(Child_Num)=~x/1000+y/1000
## coloured points plot with legend in plotting area and scales:
spplot( Child_Num, "num", do.log = TRUE,
		key.space=list(x=0.2,y=0.9,corner=c(0,1)),
		scales=list(draw=T))

spplot(meuse, "zinc", do.log = TRUE,
		key.space=list(x=0.2,y=0.9,corner=c(0,1)),
		scales=list(draw=T), cuts = 3,
		legendEntries = c("low", "intermediate", "high"))

scale = list("SpatialPolygonsRescale", layout.scale.bar(),
				offset = c(178600,332990), scale = 500, fill=c("transparent","black"))
text1 = list("sp.text", c(178600,333090), "0")
text2 = list("sp.text", c(179100,333090), "500 m")
arrow = list("SpatialPolygonsRescale", layout.north.arrow(),
				offset = c(178750,332500), scale = 400)
				
				
spplot(meuse, "zinc", do.log=T,
		key.space=list(x=0.1,y=0.93,corner=c(0,1)),
		sp.layout=list(scale,text1,text2,arrow),
		main = "Zinc (top soil)")