
fun <- expression(3*(1-x)^2*exp(-x^2-(y+1)^2)-10*(x/5-x^3-y^5)-1/3*exp(-(x+1)^2-y^2))

D(fun, "x")
D(fun, "y")

library(Deriv)
Simplify(D(fun, "x"))
Simplify(D(fun, "y"))

library(numDeriv)	

fr <- function(m){
  x=m[1];
  y=m[2];
  3*(1-x)^2*exp(-x^2-(y+1)^2)-10*(x/5-x^3-y^5)-1/3*exp(-(x+1)^2-y^2)
}

grr <- function(x) {
	x1 <- x[1];
	x2 <- x[2];
	grad(fr, c(x1, x2)) 
}

grr2 <- function(m) {
	x <- m[1];
	y <- m[2];
	c(eval(D(fun, "x")), eval(D(fun, "y")))
}
# 绘制点图
library(ggplot2)
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE, method = "loess") +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )