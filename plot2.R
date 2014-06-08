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
sdata <- data[data$Date >= d20070201 & data$Date<= d20070202,]
datetime1 <- paste(sdata$Date, sdata$Time)
datetime <- strptime(datetime1, format="%Y-%m-%d %H:%M:%S")

# construct plot and save it to png
png("plot2.png", height=480, width=480, bg="transparent")

plot(datetime, as.numeric(sdata$Global_active_power), type="l", ylab="Global Active Power (in kilowatt)", xlab="")

dev.off()