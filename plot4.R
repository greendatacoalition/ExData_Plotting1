library(data.table)
library(dplyr)
library(lubridate)

## Get the data and prepare by subsetting and mutating as required
tempfile <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file( fileUrl, tempfile)
hpcData <- fread(unzip(tempfile), sep=";", header=TRUE, na.strings="?")
unlink(tempfile)

hpcData <- subset(hpcData, Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(datetime = dmy_hms(paste(Date, Time, sep=" ")), wday = lubridate::wday(datetime, label=TRUE))


## create the plots and png
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(5,4,3,2), oma=c(1, 1, 0, 1))
# plot 1 and 2
with(hpcData, {
    plot(Global_active_power ~ datetime, type="l", ylab="Global Active Power", xlab="", lwd=1)
    plot(Voltage ~ datetime, type="l", ylab="Voltage", lwd=1)
})
# plot 3
with(hpcData, plot(datetime,Sub_metering_1, type="l", lwd=1, xlab="", ylab="Energy sub metering"))
with(hpcData, lines(datetime, Sub_metering_2, lwd= 1, col="blue"))
with(hpcData, lines(datetime, Sub_metering_3, lwd= 1, col="red"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "blue", "red"), lty = 1, cex = 0.8)
# plot 4
with(hpcData, plot(Global_reactive_power ~ datetime, type="l",lwd=1))
dev.off()
