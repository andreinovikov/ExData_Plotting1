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

# construct plot and save it to png
png("plot1.png", height=480, width=480, bg="transparent")

hist(as.numeric(sdata$Global_active_power), col="red", main= "Global Active Power", xlab="Global Active Power (in kilowatt)")

dev.off()

