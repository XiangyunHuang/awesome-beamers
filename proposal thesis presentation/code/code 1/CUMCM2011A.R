cumcm2011A <- readRDS("data/cumcm2011A.RDS")

library(RColorBrewer) 

library(showtext)
# 更多介绍
# http://cos.name/2014/01/showtext-interesting-fonts-and-graphs/#comment-7570
font.add("arial",regular="C:/Windows/Fonts/arial.ttf")
font.families()
# regular是字体文件的路径，如果字体在系统的标准位置
# （例如Windows的C:\Windows\Fonts）
# 或是当前的工作目录，
# 则可以直接输入文件名。
font.add("AdobeKaitiStd",regular="C:/Windows/Fonts/AdobeKaitiStd-Regular.otf")
font.families()

font.add("Kaiti",regular="C:/Windows/Fonts/simkai.ttf")
font.families()

pdf(file="points.pdf",width = 8,height = 7)
par(mar = c(4, 4, .5, .5))

showtext.begin()
with(cumcm2011A,{ 
	plot(c(0,30000),c(0,20000),axes=FALSE,type = "n",
		 xlab = "横坐标（千米）",ylab = "纵坐标（千米）",family="Kaiti")
	abline(h=seq(from=0,to=20000,by=2500),v=seq(from=0,to=30000,by=2500),
		   lty=2,col="lightgray")
	points(y ~ x,cex=As/5,
	       col=brewer.pal(5, "Set1")[unclass(area)],pch=16) 
	par(family="Kaiti")	
	legend("top",legend = c("生活区","工业区","山区","交通区","公园绿地区"),
			col = brewer.pal(5, "Set1"),pch = 16,box.col = "gray",horiz = TRUE) 
	par(family="arial")		
	legend( 0,17500,legend = seq(from=.5,to=2.5,by=.5)*5,border="gray",
            pt.cex=seq(from=.5,to=2.5,by=.5),pch=16,box.col = "gray")
	text(2500,17500,"浓度   \n（微克/克）",adj=c(0.7,-0.2),family="Kaiti")		
	axis(1,at=seq(from=0,to=30000,by=2500),labels=seq(from=0,to=30,by=2.5),family="arial")
	axis(2,at=seq(from=0,to=20000,by=2500),labels=seq(from=0,to=20,by=2.5),family="arial")

})
showtext.end()
dev.off()

pdf(file="As.pdf",width = 8,height = 7)
showtext.begin()
par(mar = c(4, 4, .5, .5))
par(family="Kaiti")	
with(cumcm2011A,{
	plot(c(0,310),c(1,31),axes=FALSE,type = "n",
		 xlab = "海拔（米）",ylab = "浓度（微克/克）",family="Kaiti")
	abline(v=seq(from=0,to=320,by=40),h=seq(from=0,to=32,by=4),
		   lty=2,col="lightgray")
	points(As~z,col=brewer.pal(5, "Set1")[unclass(area)],pch=16)
	legend("topright",legend = c("生活区","工业区","山区","交通区","公园绿地区"),
			col = brewer.pal(5, "Set1"),pch = 16,box.col = "gray",horiz = FALSE)	
	axis(1,at=seq(from=0,to=320,by=40),family="arial")
	axis(2,at=seq(from=0,to=32,by=4),family="arial")

})
showtext.end()
dev.off()


# 局部平滑

pdf(file="Cd.pdf",width = 8,height = 9)
showtext.begin()
par(mfrow=c(3,2),mar = c(4, 4, .5, .5))
# par(family="Kaiti")	
with(cumcm2011A,{
for(i in seq(5)){
	plot(c(0,310),c(40,1640),axes=FALSE,type = "n",
		 xlab = "海拔（米）",ylab = "浓度（纳克/克）",family="Kaiti")
	abline(v=seq(from=0,to=320,by=40),h=seq(from=40,to=1640,by=160),
		   lty=2,col="lightgray")		   
	points(Cd~z,subset=area == i,col=brewer.pal(5, "Set1")[unclass(area)],pch=16)
	# dat <- subset(cumcm2011A,area == i,select=c(Cd,z))
	lines(lowess(subset(cumcm2011A,area == i,select=c(z,Cd))),col="Black",lwd=2)
	axis(1,at=seq(from=0,to=320,by=40),family="arial")
	axis(2,at=seq(from=40,to=1640,by=160),las=1,family="arial")
}	
	plot(c(0,310),c(40,1640),axes=FALSE,type = "n",xlab="",ylab="")
	legend("center",legend = c("生活区","工业区","山区","交通区","公园绿地区"),
			col = brewer.pal(5, "Set1"),pch = 16,box.col = "white",horiz = FALSE)
})
showtext.end()
dev.off()




pdf(file="As_lowess.pdf",width = 8,height = 9)
showtext.begin()
par(mfrow=c(3,2),mar = c(4, 4, .5, .5))
with(cumcm2011A,{
for(i in seq(5)){
	plot(c(0,310),c(1,31),axes=FALSE,type = "n",
		 xlab = "海拔（米）",ylab = "浓度（微克/克）",family="Kaiti")
	abline(v=seq(from=0,to=320,by=40),h=seq(from=0,to=32,by=4),
		   lty=2,col="lightgray")		   
	points(As~z,subset=area == i,col=brewer.pal(5, "Set1")[unclass(area)],pch=16)
	lines(lowess(subset(cumcm2011A,area == i,select=c(z,As))),col="Black",lwd=2)
	axis(1,at=seq(from=0,to=320,by=40),family="arial")
	axis(2,at=seq(from=0,to=32,by=4),family="arial")
}	
	plot(c(0,310),c(40,1640),axes=FALSE,type = "n",xlab="",ylab="")
	legend("center",legend = c("生活区","工业区","山区","交通区","公园绿地区"),
			col = brewer.pal(5, "Set1"),pch = 16,box.col = "white",horiz = FALSE)
})
showtext.end()
dev.off()


