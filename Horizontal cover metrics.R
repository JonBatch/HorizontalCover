## a script to calculate metrics from csv files

library(dplyr)

# import files
files <- list.files(path = "G:/2021 TLS Lynx/Depth Rasters/QGIS Project/CSV/", recursive = FALSE,
                    full.names = TRUE)

# create a row for every file
numRows <- length(files)


# create a dummy dataframe 
store <- data.frame(id = integer(numRows),
                    file = character(numRows),
                    totalpixels = numeric(numRows),
                    TotalCoverPixels=numeric(numRows),
                    percentcover = numeric(numRows),
                    CoverBelow10Pixels = numeric(numRows),
                    MeanDistanceToCover = numeric(numRows),
                    SDToCover = numeric(numRows),
                    stringsAsFactors=FALSE)

# loop through all our files and get what we want
for(j in 1:length(files)) {
  indata <- read.csv(files[j])
  
  # write id
  store[j,'id'] <- j
  
  # write file name
  store[j,'file'] <- files[j]
  
  # write total pixels
  store[j, 'totalpixels'] <- sum(indata$count)
  
  # write Total Cover Pixels
  abovezero <- indata[indata$value > 0,]
  store[j, 'TotalCoverPixels'] <- sum(abovezero$count)
  
  #Write MeanDistanceToCover
  store[j, 'MeanDistanceToCover'] <- mean(abovezero$value)
  
  #Write  SDToCover
  store[j, 'SDToCover'] <- sd(abovezero$value)
  
  # write percent cover - total non-zero pixels divided by total pixels
  store[j, 'percentcover'] <- sum(abovezero$count) / sum(indata$count)
  
  # write 10m Cover Pixels
  abovezerobelowten <- abovezero[abovezero$value <= 10,]
  store[j, 'CoverBelow10Pixels'] <- sum(abovezerobelowten$count)
  
  # write percent cover for up 10 m
  store[j, 'percentcoverbelow10m'] <- sum(abovezerobelowten$count) / sum(indata$count)
  
}

View(store)

write.csv(store, "G:/2021 TLS Lynx/Depth Rasters/QGIS Project/CSV/HorizontalCoverSummary.csv")

