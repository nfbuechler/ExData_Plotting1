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
par(mfrow = c(1,1))
plot(datefix$datetime, datefix$Sub_metering_1 , type = "l", main = "Plot 3", xlab = "", ylab = "Energy sub metering")
lines(datefix$datetime, datefix$Sub_metering_2, col = "red", type = "l")
lines(datefix$datetime, datefix$Sub_metering_3, col = "blue", type = "l")
legend("topright", pch = "l", col = c( "black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.copy(png, file = "plot3.png")
dev.off()
