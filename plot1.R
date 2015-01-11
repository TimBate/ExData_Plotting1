###
# Creates "Plot 1" both on the screen and as a PNG file
### 

# Download and unzip the data if needed
if (!file.exists("household_power_consumption.txt")) {
  
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  fileName <- "exdata-data-household_power_consumption.zip"
  download.file(fileURL, 
                destfile = fileName,
                mode = "wb")
  unzip(zipfile = fileName, files = "household_power_consumption.txt")
}

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
hist(S$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")


###
# Create the PNG.
# Method as above. 480x480 is the default, but explicitly stated for clarity.
# Alternative method below.
###
png("plot1.png", width = 480, height = 480, bg = "transparent")

hist(S$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()

# Uncomment for alternative method (copying from screen).
#dev.copy(png, file = "plot1.png", width = 480, height = 480, 
#         bg = "transparent")
