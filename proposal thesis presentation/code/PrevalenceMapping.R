# Prevalence Mapping
# font settings
library(showtext)
showtext.auto()
# fc-list :lang=zh
# fc-list :lang=en > en.txt
font.add("SimSun",regular="C:/Windows/Fonts/simsun.ttc")
font.add("Times",regular="C:/Windows/Fonts/times.ttf")
font.families()
#  a study of the prevalence of Loa loa (eyeworm) in a series of surveys 
#  undertaken in 197 villages in west Africa (Cameroon and southern Nigeria)

data(loaloa,package="PrevMap")
head(loaloa)

library(ggplot2)
# library(ggthemes)
# library(ggforce)
library(viridis)
pdf(file="Prevalence01.pdf",width = 8,height = 7)
ggplot(data=loaloa,aes(x=LONGITUDE, y=LATITUDE,size=NO_INF/NO_EXAM,
					   fill=NO_INF/NO_EXAM )) + 
	geom_point(shape=21)+
	scale_size_area()+
	scale_fill_viridis(
        direction = -1, end = 0.85, option = "C",  # A
        breaks = seq(0, 0.6, 0.1),
        labels = scales::percent_format())+
	labs(x="Longitude",y="Latitude",fill = "Prob",size="Prob")+
	theme(text=element_text(size=16,family="Times",face="plain")) 	 
dev.off()		

		
viridis_pals <- viridis_pal(alpha = 1, begin = 0, end = 1, option = "C")(10)

pdf(file="Prevalence02.pdf",width = 8,height = 7)
ggplot(data=loaloa,aes(x=ELEVATION, y=NO_INF/NO_EXAM,colour=NO_INF/NO_EXAM)) + 
	geom_point(shape=16,size = 2,aes(colour = NO_INF/NO_EXAM))+
	geom_smooth(method = "loess",colour=viridis_pals[6],se=FALSE)+ # "blue4"
	scale_color_viridis(
        direction = -1, end = 0.85, option = "C",  # A
        breaks = seq(0, 0.6, 0.1),
        labels = scales::percent_format())+
	labs(x="Elevation",y="Prevalence",colour="Prob")+
	theme(text=element_text(size=16,family="Times",face="plain"),legend.position="none")
dev.off()		

## logit Prevalence

pdf(file="Prevalence0202.pdf",width = 8,height = 7)
ggplot(data=loaloa,aes(x=ELEVATION, 
			y=log(NO_INF/NO_EXAM/(1-NO_INF/NO_EXAM)),
			colour=log(NO_INF/NO_EXAM/(1-NO_INF/NO_EXAM)))) + 
	geom_point(shape=16,size = 2,aes(colour =log( NO_INF/NO_EXAM/(1-NO_INF/NO_EXAM))))+
	geom_smooth(method = "loess",colour=viridis_pals[6],se=FALSE)+ # "blue4"
	scale_color_viridis(
        direction = -1, end = 0.85, option = "C",  # A
        breaks = seq(0, 0.6, 0.1),
        labels = scales::percent_format())+
	labs(x="Elevation",y="Logit prevalence",colour="Prob")+
	theme(text=element_text(size=16,family="Times",face="plain"),legend.position="none")
dev.off()
	
	
pdf(file="Prevalence03.pdf",width = 8,height = 7)
ggplot(data=loaloa,aes(x=LONGITUDE, y=LATITUDE,size=MAX9901,
					   fill=MAX9901 )) + 
	geom_point(shape=21)+
	scale_size_area()+
	scale_fill_viridis(
        direction = -1, end = 0.85, option = "C",  # A
        breaks = seq(0.6, 0.9, 0.05),
        labels = seq(0.6, 0.9, 0.05))+
	labs(x="Longitude",y="Latitude",fill = "MaxNDVI",size="MaxNDVI")+
	theme(text=element_text(size=16,family="Times",face="plain")) 
dev.off()

pdf(file="Prevalence04.pdf",width = 8,height = 7)
ggplot(data=loaloa,aes(x=ELEVATION, y=MAX9901,colour=MAX9901)) + 
	geom_point(shape=16,size = 2,aes(colour = MAX9901))+
	geom_smooth(method = "loess",colour=viridis_pals[6],se=FALSE)+ # "blue4"
	scale_color_viridis(
        direction = -1, end = 0.85, option = "C",  # A
        breaks = seq(0, 0.6, 0.1),
        labels = scales::percent_format())+
	labs(x="Elevation",y="MaxNDVI",colour="Prob")+
	theme(text=element_text(size=16,family="Times",face="plain"),legend.position="none") 
dev.off()

pdf(file="Prevalence05.pdf",width = 8,height = 7)
ggplot(data=loaloa,aes(x=ELEVATION, y=STDEV9901,colour=STDEV9901)) + 
	geom_point(shape=16,size = 2,aes(colour = STDEV9901))+
	geom_smooth(method = "loess",colour=viridis_pals[6],se=FALSE)+ # "blue4"
	scale_color_viridis(
        direction = -1, end = 0.85, option = "C",  # A
        breaks = seq(0, 0.6, 0.1),
        labels = scales::percent_format())+
	labs(x="Elevation",y="StdNDVI",colour="Prob")+
	theme(text=element_text(size=16,family="Times",face="plain"),legend.position="none") 
dev.off()

library(colormap)
ls("package:colormap")

colormap_pals <- colormap_pal(colormap="hot")(10)
pdf(file="Prevalence06.pdf",width = 8,height = 7)
ggplot(data=loaloa,aes(x=ELEVATION, y=STDEV9901,colour=STDEV9901)) + 
	geom_point(shape=16,size = 2,aes(colour = STDEV9901))+
	geom_smooth(method = "loess",colour=colormap_pals[6],se=FALSE)+ 
	scale_color_colormap(
        colormap="hot",  reverse=TRUE,
        breaks = seq(0.1, 0.2, 0.02),
        labels = scales::percent_format())+
	labs(x="Elevation",y="StdNDVI",colour="StdNDVI")+
	theme(text=element_text(size=16,family="Times",face="plain"),legend.position="none")
dev.off()

 
# 地图

library(maps)
library(mapdata)
pdf(file="Prevalence00.pdf",width = 8,height = 7,pointsize=16)
# Cameroon 喀麦隆及周边地区
par(family="Times",mar=c(4,4,.5,.5))
plot(c(15.5,7.5),c(7.5,2.0),axes=FALSE,type="n",xlab="Longitude",ylab="Latitude")

countries <- c("Gabon","Congo","Equatorial Guinea","Malabo","Nigeria","Cameroon")
map(database="worldHires",regions=countries, add = TRUE,
	xlim = c(7.5,15.5), ylim = c(2.0,7.5),fill=TRUE,col="white")
# # 添加坐标轴
axis(1,at=seq(from=7.5,to=15.5,by=1),labels=TRUE) 
axis(2,at=seq(from=2.0,to=7,by=1),labels=TRUE)
box()	
# map.axes() # cex.axis=0.8 刻度数字大小
# 添加数据 
library(RColorBrewer)
colormap_pals <- rev(brewer.pal(11,"RdBu"))
# colormap_pals <- colormap_pal(colormap="plasma",reverse=TRUE)(11) 
# colormap_pals[1] 是白色 colormap_pals[11] 黑色
cols <- function(x){
	mycols <- rep("white",length(x))
	for(i in seq(length(x)))
		mycols[i] <- colormap_pals[which(ifelse(x[i] < seq(from=0.05,to=0.55,by=0.05),1,0)==1)[1]]
	return(mycols)	
}

cexs <- function(x){
	mycexs <- rep(0,length(x))
	len1 <- seq(from=0.5,to=3.0,by=0.5) # 设置cex 大小
	len2 <- seq(from=0.05,to=0.55,by=0.1) # 颜色按变量大小分级
	for(i in seq(length(x)))
		mycexs[i] <- len1[which(ifelse(x[i] < len2,1,0)==1)[1]]
	return(mycexs)	
}
points(LATITUDE~LONGITUDE,data=loaloa,
		bg=cols(NO_INF/NO_EXAM),
		pch=21,cex=cexs(NO_INF/NO_EXAM))	
# title(x="Longitude",y="Latitude") #,main="Observed Loa loa Prevalence"		
dev.off()		


# library(mapproj)
# map.grid()






  
  
  
