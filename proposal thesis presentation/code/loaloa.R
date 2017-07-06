
library("PrevMap")
data("loaloa")

loaloa$logit <- log((loaloa$NO_INF + 0.5)/(loaloa$NO_EXAM - loaloa$NO_INF + 0.5))
 
profile.kappa <- shape.matern(formula = logit ~ 1,coords = ~ LONGITUDE + LATITUDE,
								data = loaloa, set.kappa = seq(0.2,2.2, length = 80),
								start.par = c(0.2,0.05), coverage = 0.95,
								messages=FALSE,plot.profile=FALSE)

 c(profile.kappa$lower, profile.kappa$upper)
# 0.2136587	1.104513

 profile.kappa$kappa.hat
  # 0.4988445
library(tikzDevice)
tf <- file.path(getwd(),'kappa.tex')
tikz(tf,width = 4,height = 4,pointsize = 30,standAlone=TRUE)
par(mar = c(4, 4, 3, .5))
plot(profile.kappa$set.kappa,profile.kappa$val.kappa,pch=20,
	xlab='$\\kappa$',ylab="Log-likelihood",main='Profile likelihood for $\\kappa$')
dev.off()
# View the output
tools::texi2dvi(tf,pdf=T)
system(paste(getOption('pdfviewer'),file.path(getwd(),'kappa.pdf')))


 
 library("geoR")
 coords <- as.matrix(loaloa[, c("LONGITUDE", "LATITUDE")])
 vari <- variog(coords = coords, data = loaloa$logit,
				uvec = c(0, 0.1, 0.15, 0.2, 0.4, 0.8, 1.4, 1.8, 2, 2.5, 3))

 vari.fit <- variofit(vari, ini.cov.pars = c(2, 0.2),
					  cov.model = "matern",
					  fix.nugget = FALSE, nugget = 0 ,
					  fix.kappa = TRUE, kappa = 0.5)  # LSE 
					  
tf <- file.path(getwd(),'variogram.tex')
tikz(tf,width = 4,height = 4,pointsize = 30,standAlone=TRUE)
par(mar = c(4, 4, 3, .5))
plot(vari,pch=20,xlab='$u$',ylab='$V(u)$', main = "Empirical and theoretical variogram ")
lines(vari.fit,lwd=1.5,col="red") # theoretical variogram
dev.off()
# View the output
tools::texi2dvi(tf,pdf=T)
system(paste(getOption('pdfviewer'),file.path(getwd(),'variogram.pdf')))

 
 vari.fit
 # tausq = 0.1554
 # sigmasq= 2.0827
 # phi = 0.1890
 # fixed kappa = 0.5
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 