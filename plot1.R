url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- getwd()
download.file(url, file.path(destfile, "household_power_consumption.zip"))
unzip(zipfile = "household_power_consumption.zip")

# Load data
power_household <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")

# Format date data 
power_household$Date <- as.Date(power_household$Date, format = "%d/%m/%Y")

# Subset relevant data 
power_household_sub <- subset(power_household,power_household$Date == "2007-02-01" | power_household$Date == "2007-02-02")

# Create png file and plot graph 
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(power_household_sub$Global_active_power, main="Global Active Power", col="red", xlab = "Global Active Power (kilowatts)")
dev.off()



