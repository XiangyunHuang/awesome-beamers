
# 流行病数据集
library(outbreaks)


# Fit linear and generalized linear mixed-effects models using 'Eigen' and S4
# The core computational algorithms are implemented
# using the 'Eigen' C++ library for numerical linear algebra 
# and 'RcppEigen' "glue".

library(Matrix)
library(lme4)
sessionInfo()
# 调用关系
devtools::session_info()$packages

# Linear and Nonlinear Mixed Effects Models
# Fit and compare Gaussian linear 
# and nonlinear mixed-effects models.
library(nlme)

data(sleepstudy)
data(gambia,package="geoR")

library(geoR)
library(geoRglm)

library(PrevMap) #MCML









