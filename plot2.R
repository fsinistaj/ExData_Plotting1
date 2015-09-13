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

# Create line graph of Global Active Power
plot(df$datetime ,df$Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png")       # Copy graph to png file
dev.off()                               # Close png device