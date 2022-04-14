install.packages("lidR")
install.packages('RCSF')

setwd("G:/2021 TLS Lynx/GPSscans/StatePlane")
library("lidR")
library('RCSF')
library('raster')
help(package = lidR)

############ These are the only variables to change ######################
site = 51965800
plot0<-readLAS ("ColorGPS_519658000 - StatePlane.las",select = "xyz")
plot1<-readLAS ("ColorGPS_519658001 - StatePlane.las", select = "xyz")
plot2<-readLAS ("ColorGPS_519658002 - StatePlane.las", select = "xyz")
plot3<-readLAS ("ColorGPS_519658003 - StatePlane.las", select = "xyz")
ALS<-readLAS("LoomisNorth_1057.laz", select="xyz")
p0X<-1822278.37
p0Y<-1217059.602
p1X<-1822303.013
p1Y<-1217095.828
p2X<-1822319.878
p2Y<-1217039.532
p3X<-1822249.428
p3Y<-1217034.721
##########################################################################


projection(ALS)
epsg(ALS)
st_crs(ALS) <- 2927
st_crs(plot0) <- 2927
st_crs(plot1) <- 2927
st_crs(plot2) <- 2927
st_crs(plot3) <- 2927

TLS<-rbind(plot0,plot1,plot2,plot3)

TLS<-clip_circle(TLS,p0X,p0Y,328)
ALS<-clip_circle(ALS,p0X,p0Y,328)
Merged<-rbind(TLS,ALS)
#plot(Merged)

mycsf <- csf(
  sloop_smooth = FALSE,
  class_threshold = 0.5,
  cloth_resolution = 1,
  rigidness = 2L,
  iterations = 500L,
  time_step = 0.65
)
Classified <- classify_ground(Merged, mycsf)#This takes awhile... 
ClassScaled <- las_rescale(Classified, xscale = 0.001, yscale = 0.001,zscale = 0.001)#this must be run if an error about scale factors is thrown
?rasterize_terrain
DTM<-rasterize_terrain(ClassScaled, algorithm = tin())
plot(DTM)
writeRaster(DTM,filename = paste("TLS_DTMs/",site,"DTM.tif"),overwrite=TRUE)

plot0_10m<-clip_circle(plot0,p0X,p0Y,32.8)
plot0_10m <- las_rescale(plot0_10m, xscale = 0.001, yscale = 0.001,zscale = 0.001) #only needs to be run if an error about scale is thrown
plot0_10mN<- normalize_height(plot0_10m,DTM)
plot0_10mNV<-voxelize_points(plot0_10mN,0.328084)#10cm voxel 
plot0_10mVM <- voxel_metrics(plot0_10mNV, ~length(Z), 1.64042)#0.5m cube of voxels count
writeLAS(plot0_10mN,file = paste("NormalizedPlots/",site,"plot0_10mN.laz"))
writeLAS(plot0_10mNV,file = paste("NormalizedPlots/",site,"plot0_10mNV.laz"))
write.csv(plot0_10mVM,file = paste("Voxels/",site,"plot0_10mNVM.csv"))
#plot(plot0_10mNV)
#plot(plot0_10mVM, color = "V1",voxel = TRUE)

plot1_10m<-clip_circle(plot1,p1X,p1Y,32.8)
plot1_10m <- las_rescale(plot1_10m, xscale = 0.001, yscale = 0.001,zscale = 0.001) #only needs to be run if an error about scale is thrown
plot1_10mN<- normalize_height(plot1_10m,DTM)
plot1_10mNV<-voxelize_points(plot1_10mN,0.328084)#10cm voxel 
plot1_10mVM <- voxel_metrics(plot1_10mNV, ~length(Z), 1.64042)#0.5m cube of voxels count
writeLAS(plot1_10mN,file = paste("NormalizedPlots/",site,"plot1_10mN.laz"))
writeLAS(plot1_10mNV,file = paste("NormalizedPlots/",site,"plot1_10mNV.laz"))
write.csv(plot1_10mVM,file = paste("Voxels/",site,"plot1_10mNVM.csv"))
#plot(plot1_10mNV)
#plot(plot1_10mVM, color = "V1",voxel = TRUE)

plot2_10m<-clip_circle(plot2,p2X,p2Y,32.8)
plot2_10m <- las_rescale(plot2_10m, xscale = 0.001, yscale = 0.001,zscale = 0.001) #only needs to be run if an error about scale is thrown
plot2_10mN<- normalize_height(plot2_10m,DTM)
plot2_10mNV<-voxelize_points(plot2_10mN,0.328084)
plot2_10mVM <- voxel_metrics(plot2_10mNV, ~length(Z), 1.64042)
writeLAS(plot2_10mN,file = paste("NormalizedPlots/",site,"plot2_10mN.laz"))
writeLAS(plot2_10mNV,file = paste("NormalizedPlots/",site,"plot2_10mNV.laz"))
write.csv(plot2_10mVM,file = paste("Voxels/",site,"plot2_10mNVM.csv"))
#plot(plot2_10mNV)
#plot(plot2_10mVM, color = "V1",voxel = TRUE)

plot3_10m<-clip_circle(plot3,p3X,p3Y,32.8)
plot3_10m <- las_rescale(plot3_10m, xscale = 0.001, yscale = 0.001,zscale = 0.001) #only needs to be run if an error about scale is thrown
plot3_10mN<- normalize_height(plot3_10m,DTM)
plot3_10mNV<-voxelize_points(plot3_10mN,0.328084)
plot3_10mVM <- voxel_metrics(plot3_10mNV, ~length(Z), 1.64042)
writeLAS(plot3_10mN,file = paste("NormalizedPlots/",site,"plot3_10mN.laz"))
writeLAS(plot3_10mNV,file = paste("NormalizedPlots/",site,"plot3_10mNV.laz"))
write.csv(plot3_10mVM,file = paste("Voxels/",site,"plot3_10mNVM.csv"))
#plot(plot3_10mNV)
#plot(plot3_10mVM, color = "V1",voxel = TRUE)

#################################################################################################################
############################## Pull Metrics using DTMs###########################################################
#################################################################################################################

############ These are the only variables to change ######################
site = 51965800
plot0<-readLAS ("ColorGPS_519658000 - StatePlane.las",select = "xyz")
plot1<-readLAS ("ColorGPS_519658001 - StatePlane.las", select = "xyz")
plot2<-readLAS ("ColorGPS_519658002 - StatePlane.las", select = "xyz")
plot3<-readLAS ("ColorGPS_519658003 - StatePlane.las", select = "xyz")
ALS<-readLAS("LoomisNorth_1057.laz", select="xyz")
p0X<-1822278.37
p0Y<-1217059.602
p1X<-1822303.013
p1Y<-1217095.828
p2X<-1822319.878
p2Y<-1217039.532
p3X<-1822249.428
p3Y<-1217034.721
##########################################################################

DTM<-raster(paste("TLS_DTMs/",site,"DTM.tif"))
#DTM<-raster(paste("TLS_DTMs/51965500 DTM.tif"))
plot(DTM)
projection(DTM)
epsg(ALS)
st_crs(ALS) <- 2927
st_crs(plot0) <- 2927
st_crs(plot1) <- 2927
st_crs(plot2) <- 2927
st_crs(plot3) <- 2927

plot0_10m<-clip_circle(plot0,p0X,p0Y,32.8)
plot0_10mN<- normalize_height(plot0_10m,DTM)
plot0_10mNV<-voxelize_points(plot0_10mN,0.328084)#10cm voxel 
plot0_10mVM <- voxel_metrics(plot0_10mNV, ~length(Z), 1.64042)#0.5m cube of voxels count
writeLAS(plot0_10mN,file = paste("NormalizedPlots/",site,"plot0_10mN.laz"))
writeLAS(plot0_10mNV,file = paste("NormalizedPlots/",site,"plot0_10mNV.laz"))
write.csv(plot0_10mVM,file = paste("Voxels/",site,"plot0_10mNVM.csv"))
#plot(plot0_10mNV)
#plot(plot0_10mVM, color = "V1",voxel = TRUE)

plot1_10m<-clip_circle(plot1,p1X,p1Y,32.8)
plot1_10mN<- normalize_height(plot1_10m,DTM)
plot1_10mNV<-voxelize_points(plot1_10mN,0.328084)#10cm voxel 
plot1_10mVM <- voxel_metrics(plot1_10mNV, ~length(Z), 1.64042)#0.5m cube of voxels count
writeLAS(plot1_10mN,file = paste("NormalizedPlots/",site,"plot1_10mN.laz"))
writeLAS(plot1_10mNV,file = paste("NormalizedPlots/",site,"plot1_10mNV.laz"))
write.csv(plot1_10mVM,file = paste("Voxels/",site,"plot1_10mNVM.csv"))
#plot(plot1_10mNV)
#plot(plot1_10mVM, color = "V1",voxel = TRUE)

plot2_10m<-clip_circle(plot2,p2X,p2Y,32.8)
plot2_10mN<- normalize_height(plot2_10m,DTM)
plot2_10mNV<-voxelize_points(plot2_10mN,0.328084)
plot2_10mVM <- voxel_metrics(plot2_10mNV, ~length(Z), 1.64042)
writeLAS(plot2_10mN,file = paste("NormalizedPlots/",site,"plot2_10mN.laz"))
writeLAS(plot2_10mNV,file = paste("NormalizedPlots/",site,"plot2_10mNV.laz"))
write.csv(plot2_10mVM,file = paste("Voxels/",site,"plot2_10mNVM.csv"))
#plot(plot2_10mNV)
#plot(plot2_10mVM, color = "V1",voxel = TRUE)

plot3_10m<-clip_circle(plot3,p3X,p3Y,32.8)
plot3_10mN<- normalize_height(plot3_10m,DTM)
plot3_10mNV<-voxelize_points(plot3_10mN,0.328084)
plot3_10mVM <- voxel_metrics(plot3_10mNV, ~length(Z), 1.64042)
writeLAS(plot3_10mN,file = paste("NormalizedPlots/",site,"plot3_10mN.laz"))
writeLAS(plot3_10mNV,file = paste("NormalizedPlots/",site,"plot3_10mNV.laz"))
write.csv(plot3_10mVM,file = paste("Voxels/",site,"plot3_10mNVM.csv"))
#plot(plot3_10mNV)
#plot(plot3_10mVM, color = "V1",voxel = TRUE)
