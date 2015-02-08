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
datefix$datetime <- strptime(datefix$datetime, "%d/%m/%Y %H:%M:%S")
#bind new datetime column to old columns, ommitting original date and time columns
par(mfrow = c(1,1))
plot(datefix$datetime, datefix$Global_active_power, type = "l", main = "Plot 2", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
# need to correct datetime
dev.copy(png, file = "plot2.png")
dev.off()
