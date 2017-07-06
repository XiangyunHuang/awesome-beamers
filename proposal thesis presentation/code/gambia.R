gambia.map.col <- function (col="red",pch=3,cex=1,lwd=1) 
{
    gb <- gambia.borders/1000
    gd <- gambia[, 1:2]/1000
    plot(gb, ty = "l", asp = 1,xlab="",ylab="",family="Times")
	title(xlab = "西-东 （千米）", ylab = "北-南 （千米）",family="SimSun")
    points(gd, pch = pch, cex = cex,col=col,lwd=lwd)
    r1b <- gb[gb[, 1] < 420, ]
    r2b <- gb[gb[, 1] >= 420 & gb[, 1] < 550, ]
    r3b <- gb[gb[, 1] >= 550, ]
    r1bn <- zoom.coords(r1b, 1.7, xoff = 30, yoff = -90)
    lines(r1bn)
    r2bn <- zoom.coords(r2b, 1.7, xoff = -20, yoff = 90)
    lines(r2bn)
    r3bn <- zoom.coords(r3b, 1.7, xoff = -20, yoff = -90)
    lines(r3bn)
    r1d <- gd[gd[, 1] < 420, ]
    r2d <- gd[gd[, 1] >= 420 & gd[, 1] < 550, ]
    r3d <- gd[gd[, 1] >= 550, ]
    r1dn <- zoom.coords(r1d, 1.7, xoff = 20, yoff = -90)
    r1dn <- zoom.coords(r1d, 1.7, xlim.o = range(r1b[, 1], na.rm = TRUE), 
        ylim.o = range(r1b[, 2], na.rm = TRUE), xoff = 20, yoff = -90)
    points(r1dn, pch = pch, cex = cex,col=col,lwd=lwd)
    r2dn <- zoom.coords(r2d, 1.7, xlim.o = range(r2b[, 1], na.rm = TRUE), 
        ylim.o = range(r2b[, 2], na.rm = TRUE), xoff = -20, yoff = 90)
    points(r2dn, pch = pch, cex = cex,col=col,lwd=lwd)
    r3dn <- zoom.coords(r3d, 1.7, xlim.o = range(r3b[, 1], na.rm = TRUE), 
        ylim.o = range(r3b[, 2], na.rm = TRUE), xoff = -20, yoff = -90)
    points(r3dn, pch = pch, cex = cex,col=col,lwd=lwd)
    rc1n <- rect.coords(r1bn, xzoom = 1.05, lty = 2)
    rc2n <- rect.coords(r2bn, xzoom = 1.05, lty = 2)
    rc3n <- rect.coords(r3bn, xzoom = 1.05, lty = 2)
    text(c(400, 550, 480), c(1340, 1430, 1550), c("西部", 
        "东部", "中部"), cex = 1.5,family="SimSun")
}

library(showtext)
showtext.auto()
# fc-list :lang=zh
# fc-list :lang=en > en.txt
font.add("SimSun",regular="C:/Windows/Fonts/simsun.ttc")
font.add("Times",regular="C:/Windows/Fonts/times.ttf")
font.families()

# 图1 抽样的村庄位置
library(geoR)

pdf(file="gambia00.pdf",width = 8,height = 7)
par(mar = c(4, 4, .5, .5))
gambia.map.col(col="black",lwd=1)
dev.off()

# gambia数据集描述
# 共65个村子
# 采集2035个儿童的blood sample样本
# x  y 村子的位置坐标
# pos 是否出现疟疾1有 0无
# age 儿童的年龄 按天计算
# netuse 儿童是否睡在蚊帐中1是 0 不是
# treated 蚊帐是否消毒 1是 0 否
# green 村庄附近的绿色植物的绿色度 由卫星数据获得
# phc  村庄是否有健康中心  1是 0 否

Child <-  cbind(unique(gambia[,1:2])/1000, as.data.frame(table(gambia$x))[,2])
colnames(Child) <- c("x","y","num")
range(Child$num) # 8~63 
# 图2 每个村庄抽样人数 
pdf(file="gambia01.pdf",width = 8,height = 7)
with(Child,{
	 par(mar = c(4, 4, .5, .5),family="Times")
	 plot(y~x,xlab="",ylab="",frame.plot=FALSE,
		  pch=1,lwd=1.5,cex=num/24,col= "black")
	 par(family="SimSun")	  
	 title(xlab="横坐标（千米）",ylab="纵坐标（千米）")	  
	 par(family="Times")		
	 legend("bottom",legend = seq(from=.5,to=2.5,by=.5)*24,col="black",
            pt.cex=seq(from=.5,to=2.5,by=.5),pch=1,box.col = "black",horiz=TRUE)
})
dev.off()

#############################################################################################

prevalence <- rep(0,65)
greeness <- rep(0,65)
health <- rep(0,65)
for( i in seq(65)){
	ii <- unique(gambia$x)[i]
	dat <- subset(gambia,x==ii)
	prevalence[i] <- sum(dat$pos)/dim(dat)[1]
	greeness[i] <- unique(dat$green)
	health[i] <- unique(dat$phc) 	
}
# 图3 疟疾流行度与植物绿色度关系
pdf(file="prevalence.pdf",width = 8,height = 7)
par(mar = c(4, 4, .5, .5))
plot(prevalence~greeness,axes=FALSE,type = "n",
	 xlab="绿色度",ylab="疟疾流行度",family="SimSun")
abline(h=seq(from=0,to=.9,by=.1),v=seq(from=25,to=60,by=5),
	   lty=2,col="lightgray")
# 灰色 表示有健康中心 黑色 表示没有健康中心	   
points(prevalence~greeness,pch=1,lwd=2,cex=1.5,
	col=ifelse(health,"gray","black" ))
axis(1,at=seq(from=30,to=60,by=5))
axis(2,at=seq(from=0,to=.9,by=.1))
dev.off()


# 图4 抽样村庄疟疾流行度
dat <- cbind(Child,prevalence)

pdf(file="gambia02.pdf",width = 8,height = 7)
with(dat,{
	 par(mar = c(4, 4, .5, .5),family="Times")
	 plot(y~x,xlab="",ylab="",frame.plot=FALSE,
		  pch=1,lwd=1.5,cex=prevalence*3,col= "black")
	 par(family="SimSun")	  
	 title(xlab="横坐标（千米）",ylab="纵坐标（千米）")	  
	 par(family="Times")		
	 legend("bottom",legend = seq(from=.2,to=1,by=.2),col="black",
            pt.cex=seq(from=.2,to=1,by=.2)*3,
			pch=1,box.col = "black",horiz=TRUE)
})
dev.off()

library(colorspace)

pal <- function(col, border = "light gray", ...)
 {
 n <- length(col)
 plot(0, 0, type="n", xlim = c(0, 1), ylim = c(0, 1),
 axes = FALSE, xlab = "", ylab = "", ...)
 rect(0:(n-1)/n, 0, 1:n/n, 1, col = col, border = border)
}
# 灰色 12 种
pal(sequential_hcl(10, c = 0, power = 1.5))

library(RColorBrewer)
brewer.pal(9, "Greys")
display.brewer.pal(9, "Greys")

mba.int <- MBA::mba.surf(dat[,c(1,2,4)],100, 100, extend=TRUE)$xyz.est 
cols <-  sequential_hcl(10, c = 0, power = 1.5)

pdf(file="gambia03.pdf",width = 8,height = 7)
par(mar = c(4, 4, .5, .5),family="Times")
plot(c(340,630),c(1455,1510),axes=FALSE,xlab="",ylab="",type = "n",frame.plot=FALSE)
image(mba.int, col = cols[order(cols,decreasing= TRUE)],add=TRUE)
# contour(mba.int, levels = seq(0, 1, by = .1),add = TRUE, col = "black")
axis(1,at=seq(from=340,to=630,by=35),labels=seq(from=340,to=630,by=35))
axis(2,at=seq(from=1456,to=1511,by=11),labels=seq(from=1456,to=1511,by=11))
title(xlab = "横坐标（千米）",ylab = "纵坐标（千米）",family="SimSun") 
points(y~x,data=dat,pch=1,lwd=1.5,cex=prevalence*3,col= "black")
legend("bottom",legend = seq(from=.2,to=1,by=.2),col="black",
       pt.cex=seq(from=.2,to=1,by=.2)*3,
	   pch=1,box.col = "black",horiz=TRUE)
dev.off()





cairo_pdf(file="gambia_points.pdf",width = 8,height = 7,family="STKaiti")
par(mar = c(4, 4, .5, .5))
# 发现疟疾和没发现疟疾的儿童年龄的分布
with(gambia,{
	op <- par(mfrow=c(1,3),mar=c(4,4,0.5,0.5))
	boxplot(age~pos,xlab="pos",ylab="age",yaxs = "i", frame.plot=FALSE)
	par(mar=c(4,.5,.5,.5))
	boxplot(age~netuse,xlab="netuse",yaxt = "n", frame.plot=FALSE)
	boxplot(age~treated,xlab="treated",yaxt = "n", frame.plot=FALSE)
	par(op)
})

library(viridis)
cairo_pdf(file="gambia_boxplot.pdf",width = 8,height = 7,pointsize=20)
with(gambia,{
	cols <- viridis(3,begin = 0.2, end = .8)
	op <- par(mfrow=c(1,3),mar=c(4,4,0.5,0.5))
	plot(age~factor(pos),xlab="pos",ylab="age",yaxs = "i",col=cols[1], frame.plot=FALSE)
	par(mar=c(4,.5,.5,.5))
	plot(age~factor(netuse),xlab="netuse",ylab="",yaxt = "n", col=cols[2],frame.plot=FALSE)
	plot(age~factor(treated),xlab="treated",ylab="",yaxt = "n",col=cols[3], frame.plot=FALSE)
	par(op)
})
dev.off()


pdf(file="age_pos.pdf",width = 8,height = 7,pointsize=16)
showtext.begin()
par(family="Kaiti")	
# 有疟疾的儿童年龄分布
par(mar=c(4,4,.5,.5))
pos1 <- subset(gambia,pos==1,select=c(pos,age))
with(pos1,{
hist(age,freq = FALSE,plot=TRUE,axes=FALSE,
	col=rgb(77, 175, 74, 90,  maxColorValue = 255),border="white",
	xlab="年龄（天数）",ylab="概率密度 10^(-4)",main="")
xlim <- seq(300,1900,by=100)
ylim <- seq(0,10,by=1)
yylim <- seq(0,10,by=1)/10000
axis(1,labels=xlim,at=xlim,las=1) # x 轴
axis(2,labels=ylim,at=yylim,las=1) # y 轴
lines(density(age),col= brewer.pal(5, "Set1")[3],lwd=2)
})
# 无疟疾的儿童年龄分布
pos0 <- subset(gambia,pos==0,select=c(pos,age))
with(pos0,{
hist(age,freq = FALSE,plot=TRUE,axes=FALSE,add=TRUE,
	col=rgb(255, 127, 0, 90,maxColorValue = 255),border="white")
lines(density(age),col=brewer.pal(5, "Set1")[5],lwd=2)
})
legend("topright",legend=c("有疟疾","无疟疾"),
       col=brewer.pal(5, "Set1")[c(3,5)],lwd=2,box.col = "gray")
showtext.end()	   
dev.off()

	

	
library(jpeg)
library(BayesFactor)
library(coda)
library(Matrix)
library(yarrr)
pirateplot(formula = age ~ pos,
           data = gambia,
           theme = 1,
           pal = "google")

library(ggplot2)
library(gridExtra)

ggplot(gambia,aes(x=factor(pos),y=age))+
	geom_violin(adjust=0.5,trim=FALSE)+
	geom_boxplot(width=.2,fill="lightblue")
	
p1 <- ggplot(gambia,aes(x=factor(pos),y=age))+geom_boxplot()	
# table(gambia$pos)
p2 <- ggplot(gambia,aes(x=factor(netuse),y=age))+geom_boxplot()
# table(gambia$netuse)
p3 <- ggplot(gambia,aes(x=factor(treated),y=age))+geom_boxplot()
# table(gambia$treated)

grid.arrange(p1, p2,p3, nrow=1)
dev.off()


library(sjPlot)
library(sjmisc)
library(ggplot2)
# theme_set(theme_bw())

data(gambia,package="geoR")

# sjp.grpfrq(gambia$pos, gambia$treated, geom.colors = "Set1")

dat1 <- subset(gambia,netuse==0) # 0没有使用蚊帐
dat1$Index <- rep(0,dim(dat1)[1])
dat2 <- subset(gambia,netuse==1 & treated == 0)  # 1
dat2$Index <- rep(1,dim(dat2)[1])
dat3 <- subset(gambia,netuse==1 & treated == 1)  # 2 
dat3$Index <- rep(2,dim(dat3)[1])
mydata <- rbind(dat1,dat2,dat3)

sjp.setTheme(theme.font="Times",
			 geom.outline.color = "white",
			 axis.linecolor = "white", 
             base = theme_classic())

pdf(file="bed_net.pdf",width = 6,height = 5.25)
sjp.grpfrq(	mydata$Index,mydata$pos,  geom.colors = "Set1",
			axis.titles="Childhood malaria in the Gambia",
			axis.labels= c("net not use","net not treated","net treated"),
			legend.title="RDT")
dev.off()






