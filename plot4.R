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
png(file="plot4.png", width = 480, height = 480, units = "px")

#create the layout for the 4 graphs
par(mfcol=c(2,2))

#gaph1
plot(data$fulldate,
     data$Global_active_power,
     ylab="Global Active Power",
     xlab=NA,
     type="l")

#graph2
plot(data$fulldate,
     data$Sub_metering_1,
     ylab="Energy sub metering",
     xlab=NA,
     type="l",
     col="black")
lines(data$fulldate,
      data$Sub_metering_2,
      col="red")
lines(data$fulldate,
      data$Sub_metering_3,
      col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)

#graph3
plot(data$fulldate,
     data$Voltage,
     ylab="Voltage",
     xlab="datetime",
     type="l")

#Graph4
plot(data$fulldate,
     data$Global_reactive_power,
     ylab="Global_reactive_power",
     xlab="datetime",
     type="l")


#close the output
dev.off()
