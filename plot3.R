##Plot3

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

##plot3. 
with(d,plot(Date_and_Time,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(d,points(Date_and_Time,Sub_metering_2,type="l",col="red"))
with(d,points(Date_and_Time,Sub_metering_3,type="l",col="blue"))
legend("topright",legend=names(d[,6:8]),lty=1,col=c("black","red","blue"))
dev.copy(png,file="plot3.png")
dev.off()

