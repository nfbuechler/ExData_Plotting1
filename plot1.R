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

datefix$Global_active_power <- as.numeric(datefix$Global_active_power, frequency=TRUE)
hist(datefix$Global_active_power, col = "red", main = "Plot 1", xlab = "Global Active Power(kilowatts)")

dev.copy(png, file = "plot1.png")
dev.off()

