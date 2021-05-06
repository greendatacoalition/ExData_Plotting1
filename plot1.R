library(data.table)

# Get the data and subset contain only data from Feb 1 and 2, 2007
tempfile <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file( fileUrl, tempfile)
hpcData <- fread(unzip(tempfile), sep=";", header=TRUE, na.strings="?")
unlink(tempfile)
hpcData <- subset(hpcData, Date == "1/2/2007" | Date == "2/2/2007")


# create the png
png(file="plot1.png", width=480, height=480)
par(mar=c(5,5,6,2))
with(hpcData, hist(
    Global_active_power,
    col="red",
    xlab="Global Active Power (kilowatts)",
    main="Global Active Power"
))
dev.off()
