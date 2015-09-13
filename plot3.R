# Source in dplyr library
library(dplyr)

# Read in household power consumption data set
df <- read.table("household_power_consumption.txt", header = TRUE, sep=";", quote = "\"'", dec=".", na.strings =c("NA", "?"), colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Date vector to use in subsetting the full data set down to the two days we are exploring
dates <- c("1/2/2007", "2/2/2007")

# Filter down data set
df <- filter(df, Date %in% dates)

# Combine separate Date and Time fields into a single datetime field
df <- mutate(df, datetime = paste(Date, Time))
df$datetime <- as.POSIXlt(strptime(df$datetime, format = "%d/%m/%Y %H:%M:%S"))

# Create line graph of 3 sub meter readings
plot(df$datetime, df$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(df$datetime, df$Sub_metering_2, col="red")
lines(df$datetime, df$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), 
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lwd = 1, lty = 1, cex = .5)

dev.copy(png, file = "plot3.png", width=800, height=800)        # Copy graph to png file
dev.off()                                                       # Close png device

