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
    mutate(dtime = dmy_hms(paste(Date, Time, sep=" ")))


## create the png
png(file="plot3.png", width=480, height=480)
par(mar=c(4,5,3,3))
with(hpcData, {
    plot(dtime,Sub_metering_1, type="l", lwd=1, xlab="", ylab="Energy sub metering")
    lines(dtime, Sub_metering_2, lwd= 1, col="red")
    lines(dtime, Sub_metering_3, lwd= 1, col="blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        col = c("black", "red", "blue"), lty = 1, cex = 0.8)
})
dev.off()
