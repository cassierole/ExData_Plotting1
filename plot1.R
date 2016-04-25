# Creates a histogram of Global Active Power consumption over a two-day period, from the data set at:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Assumes the data set is downloaded and unzipped in the working directory.

plot1 <- function(){
        
        #load necessary libraries
        library(data.table)
        
        #read data (assumes file in working directory)
        all_data<-fread("./household_power_consumption.txt", na.strings="?")
        
        #convert Date variables to Date class
        all_data$Date <- as.Date(all_data$Date, format="%d/%m/%Y")
        
        #select subset of dates of interest
        key_days <- subset(all_data,subset=(Date=="2007-02-01"|Date=="2007-02-02"))
        rm(all_data)
        
        #open png device and create "plot1.png" in working directory
        png(filename="plot1.png")
        
        #create plot and send to file
        with(key_days, hist(Global_active_power, col = "red", main ="Global Active Power", xlab="Global Active Power (kilowatts)"))
        
        #close the png file device
        dev.off()
        
        message("Done")
}