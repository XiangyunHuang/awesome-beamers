data(gambia,package="geoR")
library(viridis)

with(gambia,{
	cols <- viridis(3,begin = 0.2, end = .8)
	op <- par(mfrow=c(1,3),mar=c(4,4,0.5,0.5))
	plot(age~factor(pos),xlab="pos",ylab="age",yaxs = "i",col=cols[1], frame.plot=FALSE)
	par(mar=c(4,.5,.5,.5))
	plot(age~factor(netuse),xlab="netuse",ylab="",yaxt = "n", col=cols[2],frame.plot=FALSE)
	plot(age~factor(treated),xlab="treated",ylab="",yaxt = "n",col=cols[3], frame.plot=FALSE)
	par(op)
})

# 是否使用蚊帐和杀虫剂看作一个因素三个水平

# 没有使用蚊帐，有疟疾
dat1<-subset(gambia,netuse==0 & pos==1)
# 没有使用蚊帐，无疟疾
dat2<-subset(gambia,netuse==0 & pos==0)
dat3<-subset(gambia,netuse==1 & pos==1)
dat4<-subset(gambia,netuse==1 & pos==0)
# 使用蚊帐但没有杀虫，无疟疾
dat5<-subset(gambia,netuse==1 & treated==0 & pos==0)

# 使用蚊帐但没有杀虫，有疟疾
dat6<-subset(gambia,netuse==1 & treated==0 & pos==1)
# 使用蚊帐且有杀虫，无疟疾
dat7<-subset(gambia,netuse==1 & treated==1 & pos==0)

# 使用蚊帐且有杀虫，有疟疾
dat8<-subset(gambia,netuse==1 & treated==1 & pos==1)


pdf(file="netuse_treated_jitter.pdf",width = 8,height = 7,pointsize=16)
op <- par(mfrow=c(1,4),mar=c(4,4,0.5,0.5))
cols <- viridis(4,begin = 0.2, end = .8,alpha = .5)
ylim <- seq(from=300,to=1900,by=200)
xlim <- c(0,1)
plot(c(-1,2),c(300,1900),xlab="",ylab="",type="n",axes = FALSE, frame.plot=FALSE)
axis(2,labels=ylim,at=ylim,las=0)
axis(1,labels=xlim,at=c(0,1),las=1)
plot(age~factor(pos),at=c(0,1),subset=netuse==0,xlab="net not use",ylab="age",
			axes = FALSE,col=cols[1], frame.plot=FALSE,add=TRUE,data=gambia)
points(jitter(dat1$pos, amount = .2),dat1$age,col=cols[1])
points(jitter(dat2$pos, amount = .2),dat2$age,col=cols[1])

# par(mar=c(4,.5,0.5,0.5))
plot(c(-1,2),c(300,1900),xlab="net use",ylab="",type="n",axes = FALSE, frame.plot=FALSE)
axis(1,labels=xlim,at=c(0,1),las=1)
plot(age~factor(pos),at=c(0,1),subset=netuse==1,xlab="net use",ylab="",
			axes = FALSE,col=cols[2], frame.plot=FALSE,add=TRUE,data=gambia)

points(jitter(dat3$pos, amount = .2),dat3$age,col=cols[2])
points(jitter(dat4$pos, amount = .2),dat4$age,col=cols[2])

plot(c(-1,2),c(300,1900),xlab="not treated",ylab="",type="n",axes = FALSE, frame.plot=FALSE)
axis(1,labels=xlim,at=c(0,1),las=1)
plot(age~factor(pos),at=c(0,1),subset=netuse==1 & treated==0,xlab="not treated",ylab="",
	 axes = FALSE,col=cols[3], frame.plot=FALSE,add=TRUE,data=gambia)
	
points(jitter(dat5$pos, amount = .2),dat5$age,col=cols[3])
points(jitter(dat6$pos, amount = .2),dat6$age,col=cols[3])

plot(c(-1,2),c(300,1900),xlab="treated",ylab="",type="n",axes = FALSE, frame.plot=FALSE)
axis(1,labels=xlim,at=c(0,1),las=1)
plot(age~factor(pos),at=c(0,1),subset=netuse==1 & treated==1,xlab="treated",ylab="",
			axes = FALSE,col=cols[4], frame.plot=FALSE,add=TRUE,data=gambia)	

points(jitter(dat7$pos, amount = .2),dat7$age,col=cols[4])
points(jitter(dat8$pos, amount = .2),dat8$age,col=cols[4])
par(op)
dev.off()	
	
pdf(file="netuse_treated.pdf",width = 8,height = 7,pointsize=16)
with(gambia,{
	cols <- viridis(4,begin = 0.2, end = .8)
	op <- par(mfrow=c(1,4),mar=c(4,4,0.5,0.5))
	
	ylim <- seq(from=300,to=1900,by=200)
	xlim <- c(0,1)
	plot(c(0,3),c(300,1900),xlab="",ylab="",type="n",axes = FALSE, frame.plot=FALSE)
	axis(2,labels=ylim,at=ylim,las=0)
	axis(1,labels=xlim,at=c(1,2),las=1)	
	
	plot(age~factor(pos),subset=netuse==0,xlab="net not use",ylab="age",
			axes = FALSE,col=cols[1], frame.plot=FALSE,add=TRUE)
			
	# par(mar=c(4,0,0.5,0.5))	
	plot(c(0,3),c(300,1900),xlab="",ylab="",type="n",axes = FALSE, frame.plot=FALSE)
	axis(1,labels=xlim,at=c(1,2),las=1)	
	plot(age~factor(pos),subset=netuse==1,xlab="net use",ylab="",
			axes = FALSE,col=cols[2], frame.plot=FALSE,add=TRUE)
			
	plot(c(0,3),c(300,1900),xlab="",ylab="",type="n",axes = FALSE, frame.plot=FALSE)

	axis(1,labels=xlim,at=c(1,2),las=1)		
	plot(age~factor(pos),subset=netuse==1 & treated==0,xlab="not treated",ylab="",
			axes = FALSE,col=cols[3], frame.plot=FALSE,add=TRUE)
			
	plot(c(0,3),c(300,1900),xlab="",ylab="",type="n",axes = FALSE, frame.plot=FALSE)	
	axis(1,labels=xlim,at=c(1,2),las=1)		
	plot(age~factor(pos),subset=netuse==1 & treated==1,xlab="treated",ylab="",
			axes = FALSE,col=cols[4], frame.plot=FALSE,add=TRUE)	
			
	par(op)
})
dev.off()







# 儿童年龄都在五岁以下
gambia$age[order(gambia$age)]
# 三岁半到四岁之间 得疟疾可能性比较大
# 下面表格中单位是 人数
		无蚊帐	有蚊帐没杀虫	有蚊帐有杀虫     有蚊帐  
有疟疾   285 		294				148				442
无疟疾   303		592				413 			1005

在没有使用蚊帐的情况下，得疟疾和没有得疟疾的人数接近1:1
使用蚊帐的人群中，疟疾人数比例下降一半

使用蚊帐的人群中，对蚊帐没有杀虫的人群中，
得疟疾和没有得疟疾的人数比例0.5:1

对蚊帐杀虫的人群中，
得疟疾和没有得疟疾的人数比例0.35:1

蚊帐和杀虫剂的作用非常重要，其中蚊帐比杀虫剂的作用更明显


