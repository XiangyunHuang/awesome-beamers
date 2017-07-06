
# 线性混合效应模型

# fit model
library(lme4)
help(sleepstudy)
str(sleepstudy)
head(sleepstudy)
# demo
require(lattice)
xyplot(Reaction ~ Days | Subject, sleepstudy, type = c("g","p","r"),
		index = function(x,y) coef(lm(y ~ x))[1],
		xlab = "Days of sleep deprivation",
		ylab = "Average reaction time (ms)", aspect = "xy")
(fm1 <- lmer(Reaction ~ Days + (Days|Subject), sleepstudy))
(fm2 <- lmer(Reaction ~ Days + (1|Subject) + (0+Days|Subject), sleepstudy))

# 可视化	
library(sjPlot)
fit <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
# simple plot
sjp.lmer(fit)
# 对预测排列
sjp.lmer(fit, sort = "Days")

# 置信区间的估计
coev <- as.matrix(lme4::vcov.merMod(fit))
tmp <- as.data.frame(cbind(OR = exp(mydf.ef[,i]),
                     lower.CI = exp(mydf.ef[,i] - (1.96 * sqrt(diag(coev))[i])),
                     upper.CI = exp(mydf.ef[,i] + (1.96 * sqrt(diag(coev))[i]))))
					 
					 
library(lme4)
# create binary response
sleepstudy$Reaction.dicho <- sju.dicho(sleepstudy$Reaction, 
                                       dichBy = "md")
# fit model
fit <- glmer(Reaction.dicho ~ Days + (Days | Subject),
             sleepstudy,
             family = binomial("logit"))
sjp.setTheme(theme = "forest")
sjp.glmer(fit, 
          facet.grid = FALSE, 
          sort = "sort.all")					 
sjp.glmer(fit, 
          type = "fe", 
          sort = TRUE)					 
					 
##广义线性混合效应模型
# fit model
library(lme4)
# create binary response
sleepstudy$Reaction.dicho <- sju.dicho(sleepstudy$Reaction, 
                                       dichBy = "md")
# fit first model
fit <- glmer(Reaction.dicho ~ Days + (Days | Subject),
             sleepstudy,
             family = binomial("logit"))
 
data(efc)
# create binary response
efc$hi_qol <- sju.dicho(efc$quol_5)
# prepare group variable
efc$grp = as.factor(efc$e15relat)
levels(x = efc$grp) <- sji.getValueLabels(efc$e15relat)
# data frame for 2nd fitted model
mydf <- na.omit(data.frame(hi_qol = as.factor(efc$hi_qol),
                           sex = as.factor(efc$c161sex),
                           c12hour = as.numeric(efc$c12hour),
                           neg_c_7 = as.numeric(efc$neg_c_7),
                           grp = efc$grp))
# fit 2nd model
fit2 <- glmer(hi_qol ~ sex + c12hour + neg_c_7 + (1|grp),
              data = mydf,
              family = binomial("logit"))					 
## 诊断图					 
# plot fixed effects correlation matrix
sjp.glmer(fit2, type = "fe.cor")

# plot qq-plot of random effects
sjp.glmer(fit, type = "re.qq")	

# plot probability curve of fixed effects
sjp.glmer(fit2, type = "fe.pc")

# plot probability curves for each covariate
# grouped by random intercepts
sjp.glmer(fit2,
          type = "ri.pc",
          show.se = TRUE)
# plot probability curves for each covariate
# grouped by random intercepts
sjp.glmer(fit2,
          type = "ri.pc",
          facet.grid = FALSE)


library(ggplot2)



				 