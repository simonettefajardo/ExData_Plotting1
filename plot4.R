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

power_subset<-subset(power,Date==as.Date(c("01/02/2007","02/02/2007"),"%d/%m/%Y"))

##check power_consumption_subset structure
str(power_subset)
##convert Date column back to character format
power_subset$Date<-as.character(power_subset$Date)

##combine Date and Time columns  under datetime column using paste function
power_subset$datetime<-paste(power_subset$Date,power_subset$Time)

##convert datetime column format from character to date-time using strptime function
power_subset$datetime<-strptime(power_subset$datetime,"%Y-%m-%d %H:%M:%S")

##call png graphics device to save output graph as "plot4.png" file with 
##height and width of 480

png(filename="plot4.png", height=480, width=480)
## set plotting grid using mfcol and mar parameters
par(mfcol=c(2,2),mar=c(4,4,2,4))

##Plot 1st graph: time series of Global Active Power 
plot(power_subset$datetime,power_subset$Global_active_power,type="l",ylab="Global Active Power",xlab="")

##Plot 2nd graph: time series of Submetering data
##Plot time series of Sub_metering_1
plot(power_subset$datetime,power_subset$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")

##Add second time series plot of Sub_metering_2
par(new=T)
plot(power_subset$datetime,power_subset$Sub_metering_2,type="l",col="red",ylab="",xlab="",axes=F)

##Add second time series plot of Sub_metering_3
par(new=T)
plot(power_subset$datetime,power_subset$Sub_metering_3,type="l",col="blue",ylab="",xlab="",axes=F)

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lwd=3,cex=0.5)

##Plot 3rd graph: Voltage time series
plot(power_subset$datetime,power_subset$Voltage,type="l",ylab="Voltage",xlab="datetime")

##Plot 4th graph: Global reactive power time series
plot(power_subset$datetime,power_subset$Global_reactive_power,type="l",
     ylab="Global_reactive_power",xlab="datetime")

##return plotting grid setting to previous
par(mfcol=c(1,1))

##Close graphic device
dev.off()