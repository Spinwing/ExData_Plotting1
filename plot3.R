# Exploratory Data Analysis, Johns Hopkins University on Coursera
# Peer Graded Assignment: Course Project 1
# 
# Author: spinwing
# date created: 2016-07-21

library(sqldf)
library(lubridate)
library(dplyr)

# loads the data from the xtx
# note the use of read.csv.sql from the sqldf package 
# it allows for loading only the interesting records and thus reduce memory use
powcons <- read.csv.sql("household_power_consumption.txt", 
                        sep=";", 
                        sql="select * from file where [Date]='1/2/2007' or [Date]='2/2/2007'",
                        colClasses = c("character", "character", "double", "double", 
                                       "double", "double", "double", "double", "double"))

# converts Date to real date class
powcons <- powcons %>% mutate(Timestamp=dmy_hms(paste(Date, Time))) %>%
    select(Timestamp, Global_active_power:Sub_metering_3)

# opens the graphical device for output
png("plot3.png", width = 480, height = 480)

# generates the graph
plot(powcons$Timestamp, powcons$Sub_metering_1, 
     type="l",
     xlab="", 
     ylab="Energy sub metering")

# add additional series
lines(powcons$Timestamp, powcons$Sub_metering_2, type="l", col="red")
lines(powcons$Timestamp, powcons$Sub_metering_3, type="l", col="blue")

# adds legend
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=3, 
       col=c("black", "red", "blue"))

# and closes the device
dev.off()

# clean up memory as the object is quite big
rm(powcons)