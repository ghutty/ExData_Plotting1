# 
# plot1.R
#

# Calculate a rough estimate of how much memory the dataset will require in memory before reading into R. 
hpcfz <- paste("File Size: ",file.info("household_power_consumption.txt")$size /1024 /1024,"MB")


# Filter data from the dates 2007-02-01 and 2007-02-02. 
# One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
library(sqldf)
hpc <- read.csv.sql("household_power_consumption.txt", sep = ";", sql = 'select * from file where Date in ("1/2/2007","2/2/2007") order by Date ASC, Time ASC')

# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
hpcdate <- as.character(as.Date(hpc$Date, "%d/%m/%Y"))
dtcomb <- paste(hpcdate,hpc$Time)
dtcombfmt <- strptime(dtcomb,"%Y-%m-%d %H:%M:%S")
hpcts <- cbind(datetime=dtcombfmt,hpc )

# Note that in this dataset missing values are coded as ?.

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
png("plot1.png", width = 480, height = 480)
hist(as.numeric(hpcts$Global_active_power), col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)", axes = TRUE, plot = TRUE, labels = FALSE)
dev.off()