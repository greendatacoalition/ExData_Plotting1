library(data.table)
library(dplyr)
library(lubridate)


# Get the data and prepare by subsetting and mutating as required
tempfile <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file( fileUrl, tempfile)
hpcData <- fread(unzip(tempfile), sep=";", header=TRUE, na.strings="?")
unlink(tempfile)
hpcData <- subset(hpcData, Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(dtime = dmy_hms(paste(Date, Time, sep=" ")), wday = lubridate::wday(dtime, label=TRUE))


## create the png
png(file="plot2.png", width=480, height=480)
par(mar=c(5,5,3,3))
with(hpcData, plot(
    Global_active_power ~ dtime,
    ylab="Global Active Power (kilowatts)",
    xlab="",
    lwd=1,
    type="l"
))
dev.off()