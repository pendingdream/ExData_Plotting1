##Plot4

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

##save the default setting for resetting use
def<-par()
par(mfcol=c(2,2),cex=0.7) ##set layour
#first plot
with(d,plot(Date_and_Time,Global_active_power,type="l",xlab="",ylab="Global Active Power"))
#second
with(d,plot(Date_and_Time,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(d,points(Date_and_Time,Sub_metering_2,type="l",col="red"))
with(d,points(Date_and_Time,Sub_metering_3,type="l",col="blue"))
legend("topright",legend=names(d[,6:8]),bty="n",lty=1,col=c("black","red","blue"))
#third
with(d,plot(Date_and_Time,Voltage,type="l",xlab="datetime"))
#last
with(d,plot(Date_and_Time,Global_reactive_power,type="l",xlab="datetime"))
##copy to file
dev.copy(png,file="plot4.png")
dev.off()

#reset the layour
par<-def
