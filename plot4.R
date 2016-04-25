# Creates a file of four plots data over a two-day period, from the data set at:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Assumes the data set is downloaded and unzipped in the working directory.

plot4 <- function(){
        
        #load necessary libraries
        library(data.table)
        
        #read data (assumes file in working directory)
        all_data<-fread("./household_power_consumption.txt", na.strings="?")
        
        #convert Date and Time variables to Date/Time classes
        all_data$Date <- as.Date(all_data$Date, format="%d/%m/%Y")
        
        #select subset of dates of interest
        key_days <- subset(all_data,subset=(Date=="2007-02-01"|Date=="2007-02-02"))
        rm(all_data)
        
        #create new datetime variables from Date and Time and convert to POSIXct class
        datetime <- paste(key_days$Date, key_days$Time)
        key_days$datetime <- as.POSIXct(datetime)
        
        #open png device and create "plot4.png" in working directory
        png(filename="plot4.png")
        
        #set paramaters for 2x2 plots
        par(mfrow=c(2,2))
        
        #create plotA and send to file (Global active power over time)
        with(key_days, plot(datetime, Global_active_power, type="l", ylab = "Global Active Power", xlab=""))
        
        #create plotB and send to file (Voltage over time)
        with(key_days, plot(datetime, Voltage, type="l")) 
        
        #create plotC and send to file (Energy sub metering over time)
        with(key_days, plot(datetime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")) 
        
        #add additional lines
        with(key_days,lines(datetime, Sub_metering_2, col="red"))
        with(key_days,lines(datetime, Sub_metering_3, col="blue"))
        
        #add legend
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, bty="n",col=c("black","red","blue"))
        
        #create plotD and send to file (Global reactive power over time)
        with(key_days, plot(datetime, Global_reactive_power, type="l"))
        
        #close the png file device
        dev.off()
        
        message("Done")
        
}