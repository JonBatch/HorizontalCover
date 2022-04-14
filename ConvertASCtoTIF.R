install.packages('raster')
install.packages('sp')
install.packages('rgdal')
library(raster)
library(sp)
library(rgdal)
?raster
setwd("G:/2021 TLS Lynx/Depth Rasters")

#DM<-raster("514860001.asc")

DM<-flip((raster("514860000.asc")), direction='y')
writeRaster(DM,filename = "514860000.tif", format="GTiff")

fasc <- list.files(pattern='.asc$', full=TRUE)
ftif <- gsub(".asc$", ".tif", fasc)

for (i in 1:length(fasc)) {
  r <- flip((raster(fasc[i])), direction='y')
  #r <- raster(fasc[i])
  r <- writeRaster(r, ftif[i])
}
