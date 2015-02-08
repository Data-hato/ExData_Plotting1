## load necessary packages
library(dplyr)
library(tidyr)
library(lubridate)

## check if directory exists, if not create the directory
if (!file.exists("course_project1")) {
        dir.create("course_project1")
}

## download and unzip the file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(fileurl, destfile = "./course_project1/household_power_dataset.zip", method = "curl")
unzip("./course_project1/household_power_dataset.zip", exdir = "./course_project1/")
list.files("./course_project1")

## load file into r
## use read.delim because it is a ; delimited file
## use stringsAsFactors = FALSE or all the dates will be read as factors in stead of characters
CompleteData <- read.delim("./course_project1/household_power_consumption.txt", 
                           header = TRUE, stringsAsFactors = FALSE, sep = ';')
TwoDays <- filter(CompleteData, Date == '1/2/2007' | Date == '2/2/2007')

## Global_active_power is now a character -> change back to numeric
TwoDays$Global_active_power <- as.numeric (TwoDays$Global_active_power)

## combinde date and time column
TwoDays$DateTime <- paste(TwoDays$Date, TwoDays$Time)

## transform to date and time using lubridate
TwoDays$DateTime <- dmy_hms(TwoDays$DateTime)

## create plot
## Copy my plot to a PNG file
## Don't forget to close the PNG device!
plot(TwoDays$DateTime, TwoDays$Global_active_power, type = 'l', 
     xlab = '', ylab = 'Global Active Power (kilowatts)', main = NULL)
dev.copy(png, file = "plot2.png") 
dev.off()

