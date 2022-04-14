## a script to calculate metrics from csv files

library(dplyr)

# import files
files <- list.files(path = "G:/2021 TLS Lynx/GPSscans/StatePlane/Voxels/", recursive = FALSE,
                    full.names = TRUE)

# create a row for every file
numRows <- length(files)


# create a dummy dataframe 
store <- data.frame(id = integer(numRows),
                    file = character(numRows),
                    CountBigV0m= numeric(numRows),
                    Mean0m= numeric(numRows),
                    SD0m= numeric(numRows),
                    Sum0m= numeric(numRows),
                    CountBigV0.5m= numeric(numRows),
                    Mean0.5m= numeric(numRows),
                    SD0.5m= numeric(numRows),
                    Sum0.5m= numeric(numRows),
                    CountBigV1m= numeric(numRows),
                    Mean1m= numeric(numRows),
                    SD1m= numeric(numRows),
                    Sum1m= numeric(numRows),
                    CountBigV1.5m= numeric(numRows),
                    Mean1.5m= numeric(numRows),
                    SD1.5m= numeric(numRows),
                    Sum1.5m= numeric(numRows),
                    CountBigV2m= numeric(numRows),
                    Mean2m= numeric(numRows),
                    SD2m= numeric(numRows),
                    Sum2m= numeric(numRows),
                    CountBigV2.5m= numeric(numRows),
                    Mean2.5m= numeric(numRows),
                    SD2.5m= numeric(numRows),
                    Sum2.5m= numeric(numRows),
                    CountBigV3m= numeric(numRows),
                    Mean3m= numeric(numRows),
                    SD3m= numeric(numRows),
                    Sum3m= numeric(numRows),
                    stringsAsFactors=FALSE)

# loop through all our files and get what we want
for(j in 1:length(files)) {
  indata <- read.csv(files[j])
  
  # write id
  store[j,'id'] <- j
  
  # write file name
  store[j,'file'] <- files[j]
  
  # write count of voxels at 0m
  m0 <- indata[indata$Z == 0,]
  store[j, 'CountBigV0m'] <- nrow(m0)
  store[j, 'Mean0m'] <- mean(m0$V1)
  store[j, 'SD0m'] <- sd(m0$V1)
  store[j, 'Sum0m'] <- sum(m0$V1)
  # write count of voxels at 0.5m
  m0.5 <- indata[indata$Z == 1.64042,]
  store[j, 'CountBigV0.5m'] <- nrow(m0.5)
  store[j, 'Mean0.5m'] <- mean(m0.5$V1)
  store[j, 'SD0.5m'] <- sd(m0.5$V1)
  store[j, 'Sum0.5m'] <- sum(m0.5$V1)
  # write count of voxels at 1m
  m1 <- indata[indata$Z == 3.28084,]
  store[j, 'CountBigV1m'] <- nrow(m1)
  store[j, 'Mean1m'] <- mean(m1$V1)
  store[j, 'SD1m'] <- sd(m1$V1)
  store[j, 'Sum1m'] <- sum(m1$V1)
  # write count of voxels at 1.5m
  m1.5 <- indata[indata$Z == 4.92126,]
  store[j, 'CountBigV1.5m'] <- nrow(m1.5)
  store[j, 'Mean1.5m'] <- mean(m1.5$V1)
  store[j, 'SD1.5m'] <- sd(m1.5$V1)
  store[j, 'Sum1.5m'] <- sum(m1.5$V1)
  # write count of voxels at 2m
  m2 <- indata[indata$Z == 6.56168,]
  store[j, 'CountBigV2m'] <- nrow(m2)
  store[j, 'Mean2m'] <- mean(m2$V1)
  store[j, 'SD2m'] <- sd(m2$V1)
  store[j, 'Sum2m'] <- sum(m2$V1)
  # write count of voxels at 2.5m
  m2.5 <- indata[indata$Z == 8.2021,]
  store[j, 'CountBigV2.5m'] <- nrow(m2.5)
  store[j, 'Mean2.5m'] <- mean(m2.5$V1)
  store[j, 'SD2.5m'] <- sd(m2.5$V1)
  store[j, 'Sum2.5m'] <- sum(m2.5$V1)
  # write count of voxels at 3m
  m3 <- indata[indata$Z == 9.84252,]
  store[j, 'CountBigV3m'] <- nrow(m3)
  store[j, 'Mean3m'] <- mean(m3$V1)
  store[j, 'SD3m'] <- sd(m3$V1)
  store[j, 'Sum3m'] <- sum(m3$V1)
}

View(store)

write.csv(store, "G:/2021 TLS Lynx/VOXEL_SUMMARY.csv")




