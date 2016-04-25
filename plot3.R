# Creates a plot of Energy Sub Metering over a two-day period, from the data set at:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Assumes the data set is downloaded and unzipped in the working directory.

plot3 <- function(){
        
        #load necessary libraries
        library(data.table)
        
        #read data (assumes file in working directory)
        all_data<-fread("./household_power_consumption.txt", na.strings="?")
        
        #convert Date variables to Date class
        all_data$Date <- as.Date(all_data$Date, format="%d/%m/%Y")
        
        #select subset of dates of interest
        key_days <- subset(all_data,subset=(Date=="2007-02-01"|Date=="2007-02-02"))
        rm(all_data)
        
        #create new datetime variables from Date and Time and convert to POSIXct class
        datetime <- paste(key_days$Date, key_days$Time)
        key_days$datetime <- as.POSIXct(datetime)
        
        #open png device and create "plot3.png" in working directory
        png(filename="plot3.png")
        
        #create plot and send to file
        with(key_days, plot(datetime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")) 
        
        #add additional lines
        with(key_days,lines(datetime, Sub_metering_2, col="red"))
        with(key_days,lines(datetime, Sub_metering_3, col="blue"))
        
        #add legend
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=1, col=c("black","red","blue"))
        
        #close the png file device
        dev.off()
        
        message("Done")
        
}