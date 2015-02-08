temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"))
unlink(temp)

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", quote = "", stringsAsFactors = FALSE)
#read data into R
select <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
#subset data 
datetime <- paste(select[,"Date"],select[,"Time"])
#put date and time colunms together
datefix <- cbind(datetime, select[,c(-1,-2)])
#bind new datetime column to old columns, ommitting original date and time columns
datefix$datetime <- strptime(datefix$datetime, "%d/%m/%Y %H:%M:%S")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(datefix, {
  #1 (plot2)
  plot(datefix$datetime, datefix$Global_active_power, type = "l", xlab = "", 
       ylab = "Global Active Power")
  # need to correct datetime
  
  #2
  plot(datetime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  # need to correct datetime
  
  #3 (plot3)
  plot(datefix$datetime, datefix$Sub_metering_1 , type = "l", xlab = "", ylab = "Energy sub metering")
  lines(datefix$datetime, datefix$Sub_metering_2, col = "red", type = "l")
  lines(datefix$datetime, datefix$Sub_metering_3, col = "blue", type = "l")
  legend("topright", pch = "l", col = c( "black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  #need to correct datetime 
  
  #4
  plot(datetime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
  
  mtext("Plot 4", outer = TRUE)
})

dev.copy(png, file = "plot4.png")
dev.off()
