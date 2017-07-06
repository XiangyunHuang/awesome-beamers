library(maps)
# map(regions="Gambia",fill=TRUE,col="gray")

library(mapdata)
# gambia
map(database="worldHires",regions="Gambia",fill=TRUE,col="lightgray")

data(gambia,package="geoR")
head(gambia)
# Cameroon 
map(database="worldHires",regions="Cameroon",fill=TRUE,col="lightgray")

cols <- yarrr::piratepal(palette = "xmen",trans = .5)[1:5]
library(RColorBrewer)

 
Child_Num <-  cbind(unique(gambia[,1:2]), as.data.frame(table(gambia$x))[,2])
colnames(Child_Num) <- c("x","y","num")
# 8-63 8个等级 颜色  1-8 9-16 17-24 ...  57-64
# 圈的大小表示 个数 使用透明色
plot(y~x,data=Child_Num,pch=16,cex=num/30,col= rgb(0,0,0,0.5) )

 
cairo_pdf(file="gambia01.pdf",width = 8,height = 7)
with(Child_Num,{
	 par(mar = c(4, 4, .5, .5),family="Times New Roman")
	 # plot(x/1000,y/1000,xlab="",ylab="",
		  # pch=1,lwd=1.5,cex=num/25,col= brewer.pal(5, "Set1")[3])
	 plot(x/1000,y/1000,xlab="",ylab="",frame.plot=FALSE,
		  pch=1,lwd=1.5,cex=num/25,col= "gray")
	 par(family="SimSun")	  
	 title(xlab="横坐标（千米）",ylab="纵坐标（千米）")	  
})
dev.off()

library(showtext)
showtext.auto()
# fc-list :lang=zh
# fc-list :lang=en > en.txt
font.add("SimSun",regular="C:/Windows/Fonts/simsun.ttc")
font.add("Times",regular="C:/Windows/Fonts/times.ttf")
font.families()

range(gambia$x)
range(gambia$y) 

pdf(file="gambia01.pdf",width = 8,height = 7)
with(Child_Num,{
	 par(mar = c(4, 4, .5, .5),family="Times")
	 plot(x/1000,y/1000,axes=FALSE,ann=FALSE,type="n",frame.plot=FALSE)
	 abline()
	 points(x/1000,y/1000,
		  pch=1,lwd=1.5,cex=num/25,col= "black")
	 par(family="SimSun")	  
	 title(xlab="横坐标（千米）",ylab="纵坐标（千米）")	  
})
dev.off()


# 青色 42 198 254
# 绿色 40 222 139
# 黄色 254 194 89
# 红色 255 115 112
library(geoR)

cairo_pdf(file="gambia.pdf",width = 8,height = 7,family="STKaiti")
par(mar = c(4, 4, .5, .5))
# gambia.map()
gambia.map.col(col=brewer.pal(5, "Set1")[1],pch=4,cex=.5,lwd=1)
dev.off()

pdf(file="gambia.pdf",width = 8,height = 7)
par(mar = c(4, 4, .5, .5))
showtext.begin()
par(family="Kaiti")	
# gambia.map()
gambia.map.col(col=brewer.pal(5, "Set1")[1],pch=4,cex=.5,lwd=1)
showtext.end()	
dev.off()
# gambia
# 共65个村子
# 采集2035个儿童的blood sample样本
# x  y 村子的位置坐标
# pos 是否出现疟疾1有 0无
# age 儿童的年龄 按天计算
# netuse 儿童是否睡在蚊帐中1是 0 不是
# treated 蚊帐是否消毒 1是 0 否
# green 村庄附近的绿色植物的绿色度 由卫星数据获得
# phc  村庄是否有健康中心  1是 0 否



plot(y~x,data=gambia)
unique(gambia$green)

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

range(prevalence)
range(greeness) 
lmfit <- lm(prevalence~greeness)
# 还要添加村庄是否有健康中心
pdf(file="prevalence.pdf",width = 8,height = 7)
par(mar = c(4, 4, .5, .5))
plot(prevalence~greeness,axes=FALSE,type = "n")
abline(h=seq(from=0,to=.9,by=.1),v=seq(from=25,to=60,by=5),
	   lty=2,col="lightgray")
# 绿色 表示有健康中心 橘色 表示没有健康中心	   
# points(prevalence~greeness,pch=ifelse(health,1,2),lwd=2,col="springgreen3" )
points(prevalence~greeness,pch=1,lwd=2,cex=1.5,
	col=ifelse(health,brewer.pal(5, "Set1")[3],brewer.pal(5, "Set1")[5]) )
axis(1,at=seq(from=30,to=60,by=5))
axis(2,at=seq(from=0,to=.9,by=.1))
dev.off()

abline(lmfit,lwd=2,col=rgb(254, 194 ,89,max=255))
lines(lowess(prevalence~greeness),lwd=2,col="orange2")



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












