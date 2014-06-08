#download file if needed to "data/" directory
if (!file.exists("data/household_power_consumption.zip")){
        if(!file.exists("data")){
                dir.create("data")
        }
        
        
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile="data/household_power_consumption.zip", method="curl")
}

#read data from file
data <- read.table(unz("data/household_power_consumption.zip","household_power_consumption.txt"),header=TRUE, sep=";", dec = ".", stringsAsFactors=FALSE)

## subseting data
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
d20070201 <- as.Date("2007-02-01")
d20070202 <- as.Date("2007-02-02")
sdata <- data[data$Date >= d20070201 & data$Date<= d20070202,]

datetime1 <- paste(sdata$Date, sdata$Time)

datetime <- strptime(datetime1, format="%Y-%m-%d %H:%M:%S")

# construct plot and save it to png
png("plot4.png", height=480, width=480,  bg = "transparent")

par(mfcol=c(2,2))


plot(datetime, as.numeric(sdata$Global_active_power), type="l", ylab="Global Active Power (in kilowatt)", xlab="")


plot(datetime, as.numeric(sdata$Sub_metering_1), type="l", ylab="Energy sub metering", xlab="")
lines(datetime, as.numeric(sdata$Sub_metering_2), col="red")
lines(datetime, as.numeric(sdata$Sub_metering_3), col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red","blue"), lty=1)

plot(datetime, as.numeric(sdata$Voltage), type="l", ylab="Voltage")

plot(datetime, as.numeric(sdata$Global_reactive_power), type="l", ylab="Global reactive power")

dev.off()

