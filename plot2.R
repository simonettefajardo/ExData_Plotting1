##Loading the Data
##Read Data from source
##Download zip data files from url indicated in the assessment page
url<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"exdata%2Fdata%2Fhousehold_power_consumption.zip")

##Extract files 
unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.txt")
##read partial data to view content and structure
power<-read.csv("household_power_consumption.txt",header=TRUE,nrows=10)
View(power)

##there are 9 columns as mentioned in the assessment page, and based on the introduction, will set columns
##data types as character (columns 1-2) and as numeric (columns 3-9)
##store column class type setting in classes object; 
classes<-c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric')

##read household_power_consumption text file and store in power object
##missing values codes as "?" treated as NAs, data columns separated by ";" after viewing partial data
power<-read.table("household_power_consumption.txt",header=TRUE,na.strings="?",sep=";",colClasses=classes)

##double check that dataset loaded has 2,075,259 rows and 9 columns
dim(power)
##also check structure
str(power)

##to be able to manipulate data, convert Date column format from character to Date type dd/mm/yyyy
power$Date<-as.Date(power$Date,"%d/%m/%Y")


##the subset data to extract rows with Dates '2007-02-01' and '2007-02-02' as specified in the assessment page
##and only needed  columns (1 to 3) to construct plot 2
power_subset<-subset(power,Date==as.Date(c("01/02/2007","02/02/2007"),"%d/%m/%Y"),select=1:3)

##check power_consumption_subset structure
str(power_subset)
##convert Date column back to character format
power_subset$Date<-as.character(power_subset$Date)

##combine Date and Time columns  under datetime column using paste function
power_subset$datetime<-paste(power_subset$Date,power_subset$Time)

##convert datetime column format from character to date-time using strptime function
power_subset$datetime<-strptime(power_subset$datetime,"%Y-%m-%d %H:%M:%S")

##call png graphics device to save output graph as "plot2.png" file with 
##height and width of 480

png(filename="plot2.png", height=480, width=480)

##Plot time series of Global Active Power 

plot(power_subset$datetime,power_subset$Global_active_power,type="l",
      ylab="Global Active Power (kilowatts)",xlab="")

##Close graphic device
dev.off()