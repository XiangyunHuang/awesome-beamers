# 
# 有多少R包发布之后就不再维护了
# 
# 增长的速度  新添加的R包-淘汰的R包
# 
# 两个角度： R包和开发者
# 
# 
# Rcmdr
# 截屏 https://socialsciences.mcmaster.ca/jfox/Misc/Rcmdr/Rcmdr-screenshot.jpg
# 介绍 https://socialsciences.mcmaster.ca/jfox/Misc/Rcmdr/Getting-Started-with-the-Rcmdr.pdf
# 	Rcmdr_0.8-2.tar.gz  2003-05-26 16:51	30K	 
# 	Rcmdr_2.4-0.tar.gz	2017-08-28 23:12	5.2M	 

# Rattle: A Graphical User Interface for Data Mining using R

install.packages("rattle") # 从 CRAN 安装
install.packages("rattle", repos="https://rattle.togaware.com", type="source") # 从源代码安装
devtools::install_bitbucket("kayontoga/rattle") # 从 Bitbucket 仓库安装


library(showtext)
showtext_auto(enable = TRUE)
font_add('SourceHanSansCN', 'SourceHanSerifCN-Regular.otf')
library(ggplot2)
library(cranlogs)
library(ggthemes)
pkgs_down <- cran_downloads(package = 'rattle',from = Sys.Date() - 365*5, to = Sys.Date())
p <- ggplot(pkgs_down, aes(x = date,y = count,colour = package)) +
  geom_line() +
  geom_point(size = 1.5) + 
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  ylim(c(0,1500)) + 
 # scale_colour_brewer(palette = "Set1") +
  scale_color_fivethirtyeight("") +
  theme_fivethirtyeight() +
  labs( subtitle = paste('Last update:',Sys.Date()),
		title = "Rattle Installations per Day last 5 years from RStudio CRAN node",
		caption = " Data from: http://cran-logs.rstudio.com/ ") +
  theme( legend.position = "none", text = element_text(family = 'SourceHanSansCN'))
  
  
pdf(file = 'rattle_downloads.pdf',width = 12,height = 6)
print(p)
dev.off()

########
pkgs_down <- cran_downloads(package = 'Rcmdr',from = Sys.Date() - 365*5, to = Sys.Date())
p <- ggplot(pkgs_down, aes(x = date,y = count,colour = package)) +
  geom_line(colour = "#FF2700") +
  geom_point(size = 1.5,colour = "#FF2700") + 
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  ylim(c(0,1500)) + 
 # scale_colour_brewer(palette = "Set1") +
  scale_color_fivethirtyeight() +
  theme_fivethirtyeight() +
  labs( subtitle = paste('Last update:',Sys.Date()),
		title = "Rcmdr Installations per Day last 5 years from RStudio CRAN node",
		caption = " Data from: http://cran-logs.rstudio.com/ ") +
  theme( legend.position = "none", text = element_text(family = 'SourceHanSansCN'))
  
  
pdf(file = 'Rcmdr_downloads.pdf',width = 12,height = 6)
print(p)
dev.off()


