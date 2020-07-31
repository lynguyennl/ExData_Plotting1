url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- getwd()
download.file(url, file.path(destfile, "household_power_consumption.zip"))
unzip(zipfile = "household_power_consumption.zip")
power_household <- read.table("household_power_consumption.txt", header = TRUE, sep=";")

# Subset relevant data
power_household_sub <- subset(power_household,power_household$Date == "1/2/2007" | power_household$Date == "2/2/2007")

# Reformat Date and Time Columns into Date and POSIXct classes. 
power_household_sub$Date <- as.Date(power_household_sub$Date, format = "%d/%m/%Y")
power_household_sub$Time <- strptime(power_household_sub$Time, format = "%H:%M:%S")

# Reformat Time column to reflect correct date in 2007.
power_household_sub[1:1440, "Time"] <- format(power_household_sub[1:1440, "Time"], "2007-02-01 %H:%M:%S")
power_household_sub[1440:2880, "Time"] <- format(power_household_sub[1440:2880, "Time"], "2007-02-02 %H:%M:%S")

# Create png file 
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Define par 
par(mfrow = c(2,2), mar=c(4,4,2,2))

# Create first plot 
plot(power_household_sub$Time, power_household_sub$Global_active_power, type = "l", 
     xlab="", ylab="Global Active Power")

# Create second plot 
plot(power_household_sub$Time, power_household_sub$Voltage, type = "l", 
     xlab="datetime", ylab="Voltage")

# Create third plot (similar to plot3)
plot(power_household_sub$Time, power_household_sub$Sub_metering_1, type = "n", 
     xlab="", ylab="Energy sub metering")
lines(power_household_sub$Time, power_household_sub$Sub_metering_1, col = "black")
lines(power_household_sub$Time, power_household_sub$Sub_metering_2, col = "red")
lines(power_household_sub$Time, power_household_sub$Sub_metering_3, col = "blue")
legend("topright", col=c("black","red","blue"),lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 1, bty = "n")

# Create fourth plot 
plot(power_household_sub$Time, power_household_sub$Global_reactive_power, type = "l", 
     xlab="datetime", ylab="Global_reactive_power")

dev.off()