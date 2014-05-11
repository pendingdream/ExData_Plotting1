##plot1

##read two days data using SQL syntax
library(sqldf)
f <-"household_power_consumption.txt"
d <- read.csv.sql(f,header=TRUE,sep=";",colClass=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                  sql="select * from file where Date = '1/2/2007' OR Date = '2/2/2007'")
closeAllConnections()
##combine date and time to date/time class
d$Date_and_Time<-paste(d$Date,d$Time)
d$Date_and_Time<-strptime(d$Date_and_Time,"%d/%m/%Y %H:%M:%S")
d<-d[,c(10,3:9)]
d[d=="?",]=NA

##modify font size
par(mfcol=c(1,1),cex=0.8)

##plot histogram
hist(d$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
##copy to file
dev.copy(png,file="plot1.png")
dev.off()
