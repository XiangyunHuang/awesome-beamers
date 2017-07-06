# 加载数据
data(rongelap,package="geoRglm")
# consists of measurements of gamma-ray counts at 157 locations.
# 157个位置 伽马射线粒子辐射数目的测量
# 数据属性
str(rongelap)
# 数据列表里的分量
names(rongelap)
# 采样点坐标 数目
 rongelap$coords
# 157 个采样点
dim(rongelap$coords)
# 采样点的分布
plot(rongelap$coords)

# 放射性强度
range(rongelap$data)

rongelap$units.m 
# n-dimensional vector of observation-times for the data.
# 每个数据的观察时间

rongelap$data/rongelap$units.m
# 单位时间辐射强度  单位时间内射线粒子数目

rongelap$borders 
# a matrix with the coordinates defining the coastline on Rongelap Island. 
# Rongelap岛的海岸线坐标

# 分布情况
range(rongelap$data/rongelap$units.m)
boxplot(rongelap$data/rongelap$units.m)

# 放射强度分布
plot(rongelap$coords,cex=rongelap$data/rongelap$units.m/5,pch=1)

# 考虑空间效应、 测量误差和 小范围内的变化（四个子区域）或者说局部变化的影响
# 以上三个因素 要定固定效应和随机效应 以确定模型形式
# 再考虑参数估计 系数显著性检验 模型显著性检验 （这两部分就是模型选择） 最后预测

# 如何看待以上三种效应 基于似然 这部分文献 MCML方法   提出基于其他似然的方法 然后与之比较 
# 基于贝叶斯方法 MCMC 







 

