## reading the data

# we assume that the data is already downloaded either directly from the UC Irvine Machine Learning Repository
# either via the link to the Dataset provided within the Coursera Course Project 1 assignment.

# the working directory which also contains the unzipped datafile is '~/R/Coursera/Exploratory_Data_Analysis/project1'.

# unzip the 'exdata-data-household_power_consumption.zip' file
# and extract the files to the "project1" directory.

unzip("exdata-data-household_power_consumption.zip")

# the unzipped file is 'household_power_consumption.txt'

# predicting the dataset objectsize
# RStudio indicates an objectsize of 126.8 MB, while my computer has 6 GB RAM. That should be fine.

# understanding the column classes and reading the dataset faster by making the colClasses explicity

initial <- read.table("household_power_consumption.txt", nrows = 100)
classes <- sapply(initial, class)

# the file has one column of class 'factor'. 

# now let's read the entire dataset

df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
head(df); str(df)

# We combine the Date and Time to a new variable 'Date_Time'

date <- as.character(df$Date)
time <- as.character(df$Time)

date_time <- paste(date, time)

df$Date_Time <- strptime(date_time, "%d/%m/%Y %H:%M:%S")

# subset data from dates 2007-02-01 and 2007-02-02

dfsubset2 <- subset(df, Date == "1/2/2007" | Date == "2/2/2007")

# plot a timeline for the Global Active Power and send it to the Graphics PNG file device

png(file = "plot3.png")

with(dfsubset2, plot(Date_Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering" ))
with(dfsubset2, lines(Date_Time, Sub_metering_2, col = "red"))
with(dfsubset2, lines(Date_Time, Sub_metering_3, col = "blue"))

legend("topright", lty = 1, col = c("black" , "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

dev.off()

