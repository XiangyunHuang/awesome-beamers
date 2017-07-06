
matern <-function (u, phi, kappa) 
{
	uphi <- u/phi
	uphi <- ifelse(u > 0, (((2^(-(kappa - 1))) / ifelse(0, Inf, gamma(kappa))) * (uphi^kappa) * besselK(x = uphi, nu = kappa)), 1)
	# uphi[u > 600 * phi] <- 0
	return(uphi)
}

curve(matern(x, phi= 0.25, kappa = 0.5),from = 0, to = 2,
   xlab = expression(u), ylab = expression(rho(u)), lty = 2,
   main=expression(paste("varying  ", kappa, "  and fixed  ", phi)))
curve(matern(x, phi= 0.25, kappa = 1),from = 0, to = 2, add = TRUE)
curve(matern(x, phi= 0.25, kappa = 2),from = 0, to = 2, add = TRUE,
   lwd = 2, lty=2)
curve(matern(x, phi= 0.25, kappa = 3),from = 0, to = 2, add = TRUE,
   lwd = 2)
legend("topright", expression(kappa==0.5, kappa==1, kappa==2, kappa==3),
 lty=c(2,1,2,1), lwd=c(1,1,2,2))   
   
   
# Matern族
library(tikzDevice)
tf <- file.path(getwd(),'matern1.tex')

tikz(tf,width = 4,height = 4,pointsize = 30,standAlone=TRUE)
par(mar = c(4, 4, 3, .5))
curve(matern(x, phi= 0.25, kappa = 0.5),from = 0, to = 2,
   xlab = '$u$', ylab = '$\\rho(u)$', lty = 2,
   main='varying  $\\kappa$ and fixed  $\\phi=0.25$')
curve(matern(x, phi= 0.25, kappa = 1),from = 0, to = 2, add = TRUE)
curve(matern(x, phi= 0.25, kappa = 2),from = 0, to = 2, add = TRUE,
   lwd = 2, lty=2)
curve(matern(x, phi= 0.25, kappa = 3),from = 0, to = 2, add = TRUE,
   lwd = 2)
legend("topright", c('$\\kappa=0.5$ ',' $\\kappa=1$' , '$\\kappa=2$', '$\\kappa=3$'),
 lty=c(2,1,2,1), lwd=c(1,1,2,2)) 
dev.off()

# View the output
tools::texi2dvi(tf,pdf=T)
system(paste(getOption('pdfviewer'),file.path(getwd(),'Matern1.pdf')))

# Matern族	 
tf <- file.path(getwd(),'matern2.tex')

tikz(tf,width = 4,height = 4,pointsize = 30,standAlone=TRUE)
par(mar = c(4, 4, 3, .5))
curve(matern(x, phi= 0.2, kappa = 1.5),from = 0, to = 4,
   xlab = '$u$', ylab = '$\\rho(u)$', lty = 2,
   main='fixed  $\\kappa=1.5$ and varying  $\\phi$')
curve(matern(x, phi= 0.4, kappa = 1.5),from = 0, to = 4, add = TRUE)
curve(matern(x, phi= 0.6, kappa = 1.5),from = 0, to = 4, add = TRUE,
   lwd = 2, lty=2)
curve(matern(x, phi= 0.8, kappa = 1.5),from = 0, to = 4, add = TRUE,
   lwd = 2)
legend("topright", c('$\\phi=0.2$ ',' $\\phi=0.4$' , '$\\phi=0.6$', '$\\phi=0.8$'),
 lty=c(2,1,2,1), lwd=c(1,1,2,2)) 
dev.off()

# View the output
tools::texi2dvi(tf,pdf=T)
system(paste(getOption('pdfviewer'),file.path(getwd(),'Matern2.pdf')))
