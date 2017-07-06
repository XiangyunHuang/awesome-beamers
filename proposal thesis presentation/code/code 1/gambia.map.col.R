gambia.map.col <- function (col="red",pch=3,cex=1,lwd=2) 
{
    gb <- gambia.borders/1000
    gd <- gambia[, 1:2]/1000
    plot(gb, ty = "l", asp = 1,xlab="",ylab="",family="Helvetica")
	title(xlab = "西-东 （千米）", ylab = "北-南 （千米）")
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
        "东部", "中部"), cex = 1.5)
    return(invisible())
}
