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

# and let's convert the Date variable to a Date class, the Time variable to a Time class.

dates <- df$Date
dates <- as.Date(dates, "%d/%m/%Y")

library(lubridate)

times <- hms(df$Time)

dfNew <- df
dfNew$Date <- dates
dfNew$Time <- times

# subset, by means of the dplyr package, data from dates 2007-02-01 and 2007-02-02

library(dplyr)

result1 <- dfNew %>%
        select(Date, Global_active_power) %>%
        filter(Date == "2007-02-01" | Date == "2007-02-02")

## plot the histogram for the Global_active_power

hist(result1$Global_active_power, col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )

## copy the histogram from the Graphics screen device to the Graphics PNG file device

dev.copy(png, file = "plot1.png")
dev.off()



