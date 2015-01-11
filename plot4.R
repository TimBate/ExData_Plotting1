###
# Creates "Plot 4" both on the screen and as a PNG file
#
# Expects the file "household_power_consumption.txt" to be present in the
# working directory.
### 

# Loads the data only if needed; it's a lot to load, so let's not waste time
if (!exists("DataSet")) {
  DataSet <- read.table(file = "household_power_consumption.txt", 
                        header = TRUE, sep = ";", na.strings = c("?", ""))
}

# Overwrite the date with a parsed Date and also create the datetime field
if (!exists("Date")) {
  datetime <- strptime( paste(DataSet$Date, DataSet$Time), 
                        format = "%d/%m/%Y %H:%M:%S")
  Date <- as.Date(datetime)
  DataSet$Date <- Date
  DataSet$datetime <- datetime
}

# Select our data subset (the two days required)
S <- DataSet[DataSet$Date >= as.Date("2007-02-01") & 
               DataSet$Date < as.Date("2007-02-03"),]

# Ready for 4 plots
par(mfrow = c(2,2))

# Plot to the screen.
# Despite debate on the forum, I believe this is as accurate as the examiner 
# intended.
plot(S$datetime, S$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")

plot(S$datetime, S$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(S$datetime, S$Sub_metering_1 , type = "l", 
     ylab = "Energy sub metering", xlab = "")
points(S$datetime, S$Sub_metering_2, type = "l", col = "red")
points(S$datetime, S$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")


plot(S$datetime, S$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")

###
# Create the PNG.
# Method as above. 480x480 is the default, but explicitly stated for clarity.
# Alternative method below.
###
png("plot4.png", width = 480, height = 480, bg = "transparent")

par(mfrow = c(2,2))

plot(S$datetime, S$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")

plot(S$datetime, S$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(S$datetime, S$Sub_metering_1 , type = "l", 
     ylab = "Energy sub metering", xlab = "")
points(S$datetime, S$Sub_metering_2, type = "l", col = "red")
points(S$datetime, S$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")


plot(S$datetime, S$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()

# Uncomment for alternative method (copying from screen).
#dev.copy(png, file = "plot4.png", width = 480, height = 480, 
#         bg = "transparent")
