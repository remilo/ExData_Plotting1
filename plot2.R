#Do not forget to set the working directory to the folder where you saved this file. Use setwd() for that
library(data.table)

# set the local LC_Time to us so that the name of the day appear in english
Sys.setlocale("LC_TIME", "en_US.UTF-8")

#Load the data
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

#Give the date and time format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$fulldate <- paste(data$Date, data$Time, sep = " ")
data$fulldate <- strptime(data$fulldate, format = "%Y-%m-%d %H:%M:%S")

data <- data[data$Date >= as.Date("2007-02-01", format="%Y-%m-%d") & data$Date <= as.Date("2007-02-02", format="%Y-%m-%d"),]

#plot the graph

#open the output
png(file="plot2.png", width = 480, height = 480, units = "px")

plot(data$fulldate,
     data$Global_active_power,
     ylab="Global Active Power (kilowatts)",
     xlab=NA,
     type="l")

#close the output
dev.off()
