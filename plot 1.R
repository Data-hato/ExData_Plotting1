## load necessary packages
library(dplyr)
library(tidyr)

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
## create histogram and change axis
## Copy my plot to a PNG file
## Don't forget to close the PNG device!
TwoDays$Global_active_power <- as.numeric (TwoDays$Global_active_power)
par(mar = c(5.1, 4.1, 4.1, 2.1))
hist(TwoDays$Global_active_power, xlab = 'Global Active Power (kilowatts)', 
     col = 'red', main = 'Global Active Power', ylim = c(0,1200))
dev.copy(png, file = "plot1.png") 
dev.off() 

