library(sqldf)

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
png("plot1.png", width = 480, height = 480)

# generates the graph
hist(powcons$Global_active_power, 
     col="red", 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

# and closes the device
dev.off()

# clean up memory as the object is quite big
rm(powcons)