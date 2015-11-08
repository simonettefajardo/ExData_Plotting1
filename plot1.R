##Loading the Data
##Read Data from source
##Download zip data files from url indicated in the assessment page
    url<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url,"exdata%2Fdata%2Fhousehold_power_consumption.zip")
    
##Extract files 
    unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.txt")
##read partial data to view content and structure
    power_consumption<-read.csv("household_power_consumption.txt",header=TRUE,nrows=10)
    View(power_consumption)

##there are 9 columns as mentioned in the assessment page, and based on the introduction, will set columns
##data types as character (columns 1-2) and as numeric (columns 3-9)
##store column class type setting in classes object; 
    classes<-c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric')
    
##read household_power_consumption text file and store in power_consumption object
##missing values codes as "?" treated as NAs, data columns separated by ";" after viewing partial data
    power_consumption<-read.table("household_power_consumption.txt",header=TRUE,
                                   na.strings="?",sep=";",colClasses=classes)
    
##double check that dataset loaded has 2,075,259 rows and 9 columns
    dim(power_consumption)
##also check structure
    str(power_consumption)
    
##to be able to manipulate data, convert Date column format from character to Date type dd/mm/yyyy
    power_consumption$Date<-as.Date(power_consumption$Date,"%d/%m/%Y")
    
##the subset data to extract rows with Dates '2007-02-01' and '2007-02-02' as specified in the assessment page
##and only needed  columns (1 and 3) to construct plot 1
    power_consumption_subset<-subset(power_consumption,
                                     Date==as.Date(c("01/02/2007","02/02/2007"),"%d/%m/%Y"),select=c(1,3))
##check power_consumption_subset structure
    str(power_consumption_subset)
    
##call png graphics device to save output graph as "plot1.png" file with 
##height and width of 480
    
    png(filename="plot1.png", height=480, width=480)

##Plot histogram of Global Active Power 
    hist(power_consumption_subset$Global_active_power,
         col="Red",xlab="Global Active Power (kilowatts)",main="Global Active Power",axes=F)
    axis(2)
    axis(1, at=seq(0,6, by=2), labels=seq(0,6, by=2))
##Close graphic device
    dev.off()