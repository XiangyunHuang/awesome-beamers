data(loaloa,package="PrevMap")
head(loaloa)

library(RColorBrewer)
pick_cols <- brewer.pal(11,"RdBu")
prevalence <- loaloa$NO_INF/loaloa$NO_EXAM
# prevalence[order(prevalence)] # 默认升序

cols_fun <- function(x){
	 for(i in seq(from=0,to=10,by=1)){
		if(0.05*i <= x && x < 0.05*i+0.05) return( list(pick_cols[11-i],0.025+0.05*i) )
	 }
}

cols  <- rep("ff",197)
sizes <- rep(0,197)

for(i in seq(197)){
	cols[i] <- cols_fun(prevalence[i])[[1]]
	sizes[i] <- cols_fun(prevalence[i])[[2]]
}
loaloa$cols <- cols
loaloa$sizes <- sizes

# embed( hist(prevalence[order(prevalence)],plot=FALSE)$breaks,2)

pdf(file="Prevalence01.pdf",width = 8,height = 7,pointsize=16)
par(mar = c(4, 4, .5, .5),family="Times")
with(loaloa,{
	plot(LATITUDE~LONGITUDE,xlab="Longitude",ylab="Latitude",type="n")
	points(LATITUDE~LONGITUDE,pch=21,bg=cols,cex = sizes*10 )
})
dev.off()