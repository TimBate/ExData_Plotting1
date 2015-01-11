###
# Creates "Plot 3" both on the screen and as a PNG file
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

# Ensure we are back to a single plot (in case plot 4 was made first)
par(mfrow = c(1,1))

# Plot to the screen.
# Despite debate on the forum, I believe this is as accurate as the examiner 
# intended.
plot(S$datetime, S$Sub_metering_1 , type = "l", 
     ylab = "Energy sub metering", xlab = "")
points(S$datetime, S$Sub_metering_2, type = "l", col = "red")
points(S$datetime, S$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


###
# Create the PNG.
# Method as above. 480x480 is the default, but explicitly stated for clarity.
# Alternative method below.
###
png("plot3.png", width = 480, height = 480)

plot(S$datetime, S$Sub_metering_1 , type = "l", 
     ylab = "Energy sub metering", xlab = "")
points(S$datetime, S$Sub_metering_2, type = "l", col = "red")
points(S$datetime, S$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = c(1,1,1), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off()

# Uncomment for alternative method (copying from screen).
#dev.copy(png, file = "plot3.png", width = 480, height = 480)
