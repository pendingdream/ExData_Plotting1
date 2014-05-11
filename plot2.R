##Plot2

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

##plot2. set locale first to ensure the x-axis label is english
Sys.setlocale(category = "LC_TIME", locale = "English")
with(d,plot(Date_and_Time,Global_active_power,type="l",xlab="",ylab="Global Active Power (Kilowatts)"))
##copy to png
dev.copy(png,file="plot2.png")
dev.off()
