install.packages("lidR")
library(lidR)
setwd("G:/2021 TLS Lynx/ALS/datasetsA/loomis_loup_loup_2016/laz")
las<-readLAS("LoomisNorth_0910.laz")
las
las2 = spTransform(las, sp::CRS(SRS_string = "EPSG:32611"))
las2
writeLAS(las2,"UTM_LoomisNorth_0910.laz")
?writeLAS
