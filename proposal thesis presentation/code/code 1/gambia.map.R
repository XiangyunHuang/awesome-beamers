
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



